import os.path as op
import sys

import numpy as np
import tensorflow as tf
from google.protobuf import text_format

import data_utils as data_utils
import filenames

from scipy.special import logsumexp
from numpy import array

import math

import kenlm

# For saving demo resources, use batch size 1 and step 1.
BATCH_SIZE = 1
NUM_TIMESTEPS = 1
MAX_WORD_LEN = 50


class GoogleLanguageModel(object):

    pbtxt = 'graph-2016-09-10.pbtxt'
    ckpt = 'ckpt-*'
    vocab_file = 'vocab-2016-09-10.txt'

    def __init__(self):
        pbtxt = op.join(filenames.google_lm_dir, self.pbtxt)
        ckpt = op.join(filenames.google_lm_dir, self.ckpt)
        vocab_file = op.join(filenames.google_lm_dir, self.vocab_file)

        self.load_model(pbtxt, ckpt) 
        self.vocab = data_utils.CharsVocabulary(vocab_file, MAX_WORD_LEN)
        self.graph = list(self.t.values())[0].graph

    def load_affine_transformation(self):
        self.bias = self.sess.run(self.graph.get_tensor_by_name('softmax/b:0'))
        w = self.sess.run([self.graph.get_tensor_by_name('softmax/W_%d:0' % i)
                           for i in range(8)])
        # The weight matrix W is (800000, 1024); it's saved broken up into
        # 8 matrices, but they're interleaved: final order or rows should be
        # m0[0], m1[0], ..., m7[0], m0[1], ..., m7[1], etc.
        self.w = np.reshape(np.hstack(w), (-1, 1024))

    def load_model(self, gd_file, ckpt_file):
        with tf.Graph().as_default():
            sys.stderr.write('Recovering graph.\n')
            with tf.gfile.FastGFile(gd_file, 'r') as f:
                s = f.read()
                gd = tf.GraphDef()
                text_format.Merge(s, gd)

            tf.logging.info('Recovering Graph %s', gd_file)
            t = {}
            [t['states_init'], t['lstm/lstm_0/control_dependency'],
             t['lstm/lstm_1/control_dependency'], t['inputs_in'],
             t['targets_in'], t['target_weights_in'], t['char_inputs_in']
            ] = tf.import_graph_def(gd, {}, ['states_init',
                                       'lstm/lstm_0/control_dependency:0',
                                       'lstm/lstm_1/control_dependency:0',
                                       'inputs_in:0',
                                       'targets_in:0',
                                       'target_weights_in:0',
                                       'char_inputs_in:0'], name='')

            sys.stderr.write('Recovering checkpoint %s\n' % ckpt_file)
            sess = tf.Session(config=tf.ConfigProto(allow_soft_placement=True))
            sess.run('save/restore_all', {'save/Const:0': ckpt_file})
            sess.run(t['states_init'])

        self.sess = sess
        self.t = t

    # calls process_word() with "<S>" (the sentence initiator)
    def process_init(self):
        targets = np.zeros([BATCH_SIZE, NUM_TIMESTEPS], np.int32)
        weights = np.ones([BATCH_SIZE, NUM_TIMESTEPS], np.float32)

        self.sess.run(self.t['states_init'])

        inputs = np.zeros([BATCH_SIZE, NUM_TIMESTEPS], np.int32)
        char_ids_inputs = np.zeros([BATCH_SIZE, NUM_TIMESTEPS,
                                    self.vocab.max_word_length], np.int32)

        feed_dict={self.t['char_inputs_in']: char_ids_inputs,
                   self.t['inputs_in']: inputs,
                   self.t['targets_in']: targets,
                   self.t['target_weights_in']: weights}
        lstm = self.t['lstm/lstm_1/control_dependency']

        return self.process_word('<S>', inputs, char_ids_inputs, feed_dict, lstm)


    def process_word(self, word, inputs, char_ids_inputs, feed_dict, lstm):
        word_id = self.vocab.word_to_id(word)
        char_id = self.vocab.word_to_char_ids(word)

        inputs[0, 0] = word_id
        char_ids_inputs[0, 0, :] = char_id

        lstm_state = self.sess.run(lstm, feed_dict=feed_dict)

        return inputs, char_ids_inputs, feed_dict, lstm, lstm_state

    # returns log base 10
    def get_logprob(self, lstm_state, word):
        w = self.w
        bias = self.bias
        unnorm_logprobs = np.squeeze(np.dot(self.w, lstm_state.T)) + bias
        logprobs = unnorm_logprobs - logsumexp(unnorm_logprobs)

        # now get the id of word
        id = self.vocab.word_to_id(word)
        natural_log = logprobs[id]
        return natural_log/2.303

    # this is part of a loop over every word in the testing corpus
    # for each individual word, separate vectors are returned, where
    # the vector's length is the vocabulary size, and each element is the logprob
    # of one of the words in the vocabulary.
    # The separate vectors returned are the logprobs for
    # 1) The LSTM model
    # 2) The kenlm 5-gram model
    # 3) The kenlm 2-gram model
    def get_logprob_vectors_for_word(self, lstm_state, klm_5gram_state, klm_5gram_model,
                                     klm_2gram_state, klm_2gram_model):
        # get next word logprobs for lstm
        w = self.w
        bias = self.bias
        unnorm_logprobs = np.squeeze(np.dot(self.w, lstm_state.T)) + bias
        lstm_logprobs = unnorm_logprobs - logsumexp(unnorm_logprobs)
        
        klm_5gram_out_state = kenlm.State()
        klm_2gram_out_state = kenlm.State()
        
        lstm_vector = []
        klm_5gram_vector = []
        klm_2gram_vector = []
        
        # get score for each word, but keep using initial state. Do not update it
        with open( op.join(filenames.google_lm_dir, self.vocab_file) , 'r') as vocab_file:
         
            for word in vocab_file:
                word = word.strip()
                tf_id = self.vocab.word_to_id(word)
                
     
                
                lstm_score = lstm_logprobs[tf_id]#/2.303 #convert from log_e to log_10
                lstm_vector.append(lstm_score)
                
                klm_5gram_score = klm_5gram_model.BaseScore(klm_5gram_state, word, klm_5gram_out_state) * 2.303
                klm_5gram_vector.append(klm_5gram_score)
                
                klm_2gram_score = klm_2gram_model.BaseScore(klm_2gram_state, word, klm_2gram_out_state) * 2.303
                klm_2gram_vector.append(klm_2gram_score)

        # compare dimensionality and logsumexp of lstm_logprobs and lstm_vector
        # print("lstm_logprobs.size: {}, lstm_vector.size: {}".format(lstm_logprobs.size, len(lstm_vector)))
        # print("logsumexp(lstm_logprobs): {}, logsumexp(lstm_vector): {}".format(logsumexp(lstm_logprobs),
        #                                                                         logsumexp(lstm_vector[:-1])))
            
        return array(lstm_vector[:-1]), array(klm_5gram_vector[:-1]), array(klm_2gram_vector[:-1])

