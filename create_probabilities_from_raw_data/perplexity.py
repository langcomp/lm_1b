from __future__ import print_function
import codecs
from tokenize_text import tokenize_word
from tokenize_text import punctuation_set
import csv
import numpy as np
import sys
from itertools import tee

# def pairwise(iterable):
#     a, b = tee(iterable)
#     next(b, None)
#     return zip(a, b)

def calculate(token_probability_file, only_alphanum=False):
    '''
    Standard perplexity calculation
    :param token_probability_file: one token per line with
                                    token p() in 4th column
    :return: perplexity
    '''

    token_tuple_list = []
    perplexity = 0.0
    n_tokens = 0

    with open(token_probability_file, 'r') as token_file:
        token_line_csv = csv.reader(token_file)

        for token_line in token_line_csv:
            word_num = token_line[1]
            token = token_line[2]
            surprisal = float(token_line[3])
            token_tuple_list.append([word_num, token, surprisal])
            # if only_alphanum:
            #     if token not in punctuation_set and \
            #         token != "</S>" and \
            #         next_token_line[0] not in punctuation_set:

    # check if token or next token is punctuation
    # if it is, and only_alphanum, then do not include this token
    # do not include last line, which is </S> anyway
    for i, token_tuple in enumerate(token_tuple_list[:-1]):
        word_num = token_tuple[0]
        token = token_tuple[1]
        surprisal = token_tuple[2]
        token_alphanum = True
        if (token in punctuation_set) or (token == "</S>") or \
                (word_num == token_tuple_list[i+1][0] and token_tuple_list[i+1][1] in punctuation_set):
            token_alphanum = False
            # print(token)

        if only_alphanum and token_alphanum:
            perplexity += surprisal
            n_tokens += 1


    perplexity /= n_tokens
    perplexity = 10 ** (-1 * perplexity)

    print('Perplexity = {}, on {} tokens'.format(perplexity, n_tokens))

    return perplexity

if __name__ == "__main__":
    calculate(sys.argv[1], True)