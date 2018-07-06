import create_text_tokens_file
import rnn_corpus
import perplexity



if __name__ == '__main__':

    # generate corpus file for language modeling, as well as index file
    # this is the directory where all dundee corpus files are stored
    # dundee_path = 'dundee/dundee_texts/test/tx3sent*wrdp.dat'
    dundee_path = 'dundee/dundee_texts/tx*.dat'
    # filename for file that will be created
    # with one sentence/line, all punctuation whitespaced
    corpus_tokenized_file = 'preprocessed_data/test_corpus.tkn'
    # filename for file that will be created
    # with one token per line, as well as file and word number
    tokenized_line_file = 'preprocessed_data/test_token_line.tkn'
    # where to output results of RNN
    rnn_file = 'output.csv'

    # create files named above
    # return the tokenized corpus string, one sentence per line
    token_corpus_string = create_text_tokens_file.create(dundee_path, corpus_tokenized_file, tokenized_line_file)

    # feed corpus_tokenized_file to kenlm, as is on CLI
    # output kenlm to R-appropriate format on CLI

    # feed to RNN
    ## output word number
    ### word # of punctuation goes with word, including sentence-ending period
    ### </s> has NA for word number
    rnn_corpus.create(tokenized_line_file, rnn_file)

    # calculate perplexity
    perplexity.calculate(rnn_file)