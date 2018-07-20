import timeit
from csv import reader
from google_lm import GoogleLanguageModel
import os
os.environ['TF_CPP_MIN_LOG_LEVEL']='3' # suppress build warnings

sentence_end = set(['?', '!', ';', ',', ':']) #set(['.', '?', '!', ';', ',', ':']) #no comma?


def create(token_corpus_line_file, logprob_probability_file):
    # initialize lstm
    tic = timeit.default_timer()
    glm = GoogleLanguageModel()
    glm.load_affine_transformation()
    toc = timeit.default_timer()
    print("Model built in {} seconds".format(toc - tic))

    inputs, char_ids_inputs, feed_dict, lstm, lstm_state = glm.process_init()

    # loop through corpus
    current_file_id = ''
    with open(token_corpus_line_file, 'r') as token_file:
        with open(logprob_probability_file, 'w') as logprob_file:
            csv_reader = reader(token_file)
            for token_line in csv_reader:
                file_id = token_line[0]
                if current_file_id != file_id:
                    print("Calculating probabilities for file {}...".format(file_id))
                    current_file_id = file_id
                token_index = token_line[1]
                token = token_line[2]
                # print(token_index)

                # calculate probability of each token and sum
                # update model with each token
                token_probability_vector = glm.get_logprob_vector(lstm_state)
                print(token_probability_vector)

                inputs, char_ids_inputs, feed_dict, lstm, lstm_state = \
                    glm.process_word(token, inputs, char_ids_inputs, feed_dict, lstm)

                # logprob_file.write('{},{},\"{}\",{}\n'.format(file_id, token_index, token, token_probability_vector))

                # when the sentence changes (sentence-ending punctuation is detected), reinitialize the model
                if token == "</s>":
                    inputs, char_ids_inputs, feed_dict, lstm, lstm_state = glm.process_init()
                    print('Reinitializing')

    toc = timeit.default_timer()
    print("Elapsed time: {} seconds".format(toc - tic))
