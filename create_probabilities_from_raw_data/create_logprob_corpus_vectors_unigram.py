import timeit
from csv import reader
from google_lm import GoogleLanguageModel
import kenlm
import os
import os.path as op
import filenames
import interpolate
from scipy.special import logsumexp
import numpy as np
from numpy import array

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # suppress build warnings

sentence_end = set(['?', '!', ';', ',', ':'])  # set(['.', '?', '!', ';', ',', ':']) #no comma?


# creating logprob vectors for each word, where each element of the vector is the logprob of a
# vocab word
def create(token_corpus_line_file, logprob_probability_file):
	# initialize lstm model
	tic = timeit.default_timer()
	glm = GoogleLanguageModel()
	glm.load_affine_transformation()
	toc = timeit.default_timer()
	print("Google LM built in {} seconds".format(toc - tic))
	inputs, char_ids_inputs, feed_dict, lstm, lstm_state = glm.process_init()

	# initialize kenlm 5-gram model
	klm_5gram_model = kenlm.Model(op.join(filenames.preproc_dir, 'lm1b-5gram.binary'))
	klm_5gram_state = kenlm.State()
	klm_5gram_model.BeginSentenceWrite(klm_5gram_state)
	print("Built 5gram model in {}".format(timeit.default_timer() - toc))

	# initialize kenlm 2-gram model
	# print("Building 2gram model...")
	# klm_2gram_model = kenlm.Model(op.join(filenames.preproc_dir, 'lm1b-2gram.binary'))
	# klm_2gram_state = kenlm.State()
	# klm_2gram_model.BeginSentenceWrite(klm_2gram_state)
	
	# loop through corpus
	current_file_id = ''
	with open(token_corpus_line_file, 'r') as token_file:
		# with open(logprob_probability_file, 'w') as logprob_out_file:
		csv_reader = reader(token_file)
		for token_line in csv_reader:
			file_id = token_line[0]
			if current_file_id != file_id:
				print("Calculating probabilities for file {}...".format(file_id))
				current_file_id = file_id
			
			token_index = token_line[1]
			token = token_line[2]
			vocab_vec_idx = glm.vocab.word_to_id(token)
			print(token, token_index, vocab_vec_idx)
			
			# get full vocab vectors for this token, from different models
			token_lstm_vector, token_5gram_vector, token_ngram_vector = \
				glm.get_logprob_vectors_for_word_unigram(lstm_state,
												 klm_5gram_state, klm_5gram_model)
			

			# print(token_ngram_vector.shape, token_5gram_vector.shape, token_lstm_vector.shape)

			# print( logsumexp(token_lstm_vector), logsumexp(token_5gram_vector), logsumexp(token_ngram_vector) )

			# perform interpolation
			## first, create an interpolated vector of lstm and 5gram vectors
			### this will give us our surprisal model's log probability for each word
			## then, perform multiplicative interpolation of the optimal vector and the
			## 2gram vector
			optimal_interpolated_vec = interpolate.interpolate_vectors(token_lstm_vector, token_5gram_vector)
			# sanity check using regular interpolation where logsumexp should equal 1.0
			# sanity_logprob_vec = interpolate.interpolate_vectors(optimal_interpolated_vec, token_ngram_vector)
			# print( logsumexp(sanity_logprob_vec) )
			# # perform multiplicative interpolation

			# loop through different weights for token, and *then* update the models
			interp_weights = np.arange(0.0, 1.01, 0.01)
			with open("{}_{}.data".format(logprob_probability_file, current_file_id), 'a') as logprob_out_file:
				for i_weight in interp_weights:
	
					multiplicative_interp_vec = interpolate.multiplicative_interpolate_vectors(optimal_interpolated_vec,
																							   token_ngram_vector,
																							   i_weight)
					mult_logprob = logsumexp(multiplicative_interp_vec)
					print(token_index, '{0:.2f}'.format(i_weight), mult_logprob, multiplicative_interp_vec[vocab_vec_idx])
					
					logprob_out_file.write('{0:.2f}, {1}, {2}, {3}\n'.format(i_weight, token_index, mult_logprob,
																			multiplicative_interp_vec[vocab_vec_idx]))


			# update lstm states by feeding in next word
			inputs, char_ids_inputs, feed_dict, lstm, lstm_state = \
				glm.process_word(token, inputs, char_ids_inputs, feed_dict, lstm)

			# update kenlm 5gram state
			klm_5gram_out_state = kenlm.State()
			klm_5gram_model.BaseScore(klm_5gram_state, token, klm_5gram_out_state)
			klm_5gram_state = klm_5gram_out_state

			# update kenlm 2gram state
			klm_2gram_out_state = kenlm.State()
			klm_2gram_model.BaseScore(klm_2gram_state, token, klm_2gram_out_state)
			klm_2gram_state = klm_2gram_out_state

			# when the sentence changes (sentence-ending punctuation is detected), reinitialize the model
			if token == "</s>":
				# reinitialize lstm
				inputs, char_ids_inputs, feed_dict, lstm, lstm_state = glm.process_init()
				# reinitialize 5gram
				klm_5gram_model.BeginSentenceWrite(klm_5gram_state)
				# reinitialize 2gram
				klm_2gram_model.BeginSentenceWrite(klm_2gram_state)
				print('Reinitializing')

	toc = timeit.default_timer()
	print("Elapsed time: {} seconds".format(toc - tic))
