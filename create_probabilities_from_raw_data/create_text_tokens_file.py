import glob
import codecs
from tokenize_text import tokenize_word
import os
import re
from pathlib import Path
import os.path as op
import filenames


def create(dundee_path, group, tokenized_corpus_filename, tokenized_line_filename):
    sentence_end = set(['?', '!', '.'])
    sentence_begin = True

    word_string = ''
    word_num_token_list = []
    n_tokens = 0

    
    
    group1 = ["tx01wrdp.dat", "tx02wrdp.dat", "tx03wrdp.dat", "tx04wrdp.dat", "tx05wrdp.dat"]
    group2 = ["tx06wrdp.dat", "tx07wrdp.dat", "tx08wrdp.dat", "tx09wrdp.dat", "tx10wrdp.dat"]
    group3 = ["tx11wrdp.dat", "tx12wrdp.dat", "tx13wrdp.dat", "tx14wrdp.dat", "tx15wrdp.dat"]
    group4 = ["tx16wrdp.dat", "tx17wrdp.dat", "tx18wrdp.dat", "tx19wrdp.dat", "tx20wrdp.dat"]
    groupT = ["txT0wrdp.dat", "txT1wrdp.dat"]
    file_group = groupT
    if group == '1':
        file_group = group1
    elif group == '2':
        file_group = group2
    elif group == '3':
        file_group = group3
    elif group == '4':
        file_group = group4
        

    # Change a few symbols that cause issues with tokenization
    # Output two files:
    #   One corpus file with one sentence per line
    #   One corpus file with one token per line
    #       Punctuation constitutes a separate token

    for file_name in file_group:
        word_file = op.join(filenames.root, 'raw_data/raw_dundee_english/', file_name)
    # for word_file in glob.glob(dundee_path):
        print('Processing file {}'.format(word_file))
        file_id = os.path.basename(word_file)[2:4]
        with codecs.open(word_file, 'r', encoding='utf-8', errors='ignore') as word_list:
            for index, line in enumerate((word_list)):
                if sentence_begin:
                    sentence_begin = False
                word_info = line.split()
                word = word_info[0]
                # break word into tokens
                token_list = []
                if word == "...":
                    token_list = ['.']
                elif word == ".":
                    token_list = ["."]
                elif word == "-":
                    token_list = ['-']
                else:
                    tokenize_word(word, token_list)

                n_tokens += len(token_list)

                for token in token_list:
                    word_string += '{} '.format(token)
                    word_num_token_list.append([file_id, index+1, "\"{}\"".format(token)])

                # if any of the tokens are sentence-ending punctuation
                ## add sentence terminal </s>, and new line
                ## </s> has no index
                if any(i in token_list for i in sentence_end):
                    word_string += " \n"
                    n_tokens += 1
                    word_num_token_list.append([file_id, "NA", "</s>"])
                    sentence_begin = True
                # reset token_list
                token_list.clear()

    print('{} tokens'.format(n_tokens))

    # print one tokenized sentence per line
    with open(tokenized_corpus_filename, 'w') as outf:
        outf.write(word_string)

    # print one token per line
    with open(tokenized_line_filename, 'w') as linef:
        for token_index in word_num_token_list:
            linef.write('{},{},{}\n'.format(token_index[0], token_index[1], token_index[2]))

    return word_string