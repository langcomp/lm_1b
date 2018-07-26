import filenames
import os.path as op
import create_text_tokens_file
import rnn_corpus
import create_logprob_corpus_vectors
import perplexity
import re
import sys
from pathlib import Path


if __name__ == '__main__':

    # generate corpus file for language modeling, as well as index file
    # this is the directory where all dundee corpus files are stored
    dundee_path = filenames.dundee_dir
    group = sys.argv[1]
    # filename for file that will be created
    # with one sentence/line, all punctuation whitespaced
    corpus_tokenized_file = op.join(filenames.preproc_dir, 'test_corpus_{}.tkn'.format(group))
    # filename for file that will be created
    # with one token per line, as well as file and word number
    tokenized_line_file = op.join(filenames.preproc_dir, 'test_token_line_{}.tkn'.format(group))
    # where to output results of RNN
    rnn_file = op.join(filenames.preproc_dir, 'output_{}.csv'.format(group))
    logprob_file = op.join(filenames.preproc_dir, 'logprob')

    # create files named above
    # return the tokenized corpus string, one sentence per line
    token_corpus_string = create_text_tokens_file.create(dundee_path, group, corpus_tokenized_file, tokenized_line_file)

    # feed corpus_tokenized_file to kenlm, as is on CLI
    # output kenlm to R-appropriate format on CLI
    ## ADD DETAILS!

    # feed to RNN
    ## output word number
    ### word # of punctuation goes with word, including sentence-ending period
    ### </s> has NA for word number
    rnn_corpus.create(tokenized_line_file, rnn_file)
    
    # for calculating interpolated perplexity multiplicatively
    # this is for purely research purposes, and it is unlikely you
    # will need to interpolate in a non-geometrical fashion
    create_logprob_corpus_vectors.create(tokenized_line_file, logprob_file)

    # calculate perplexity
    # perplexity.calculate(rnn_file)
    