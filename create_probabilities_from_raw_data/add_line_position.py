import glob
import os
import codecs

dundee_path = 'dundee/dundee_texts/tx*.dat'

for word_file in glob.glob(dundee_path):
    print('Processing file {}'.format(word_file))
    file_id = os.path.basename(word_file)[2:4]
    with codecs.open(word_file, 'r', encoding='utf-8', errors='ignore') as word_list:
        with open('token_line_num.csv', 'a') as outf:
            current_line_num = 0
            line_change = False
            line_beginning = True
            line_ending = False
            token_info_list = []
            for index, line in enumerate((word_list)):
                word_info = line.split()
                word = word_info[0]
                text_num = word_info[2]
                line_num = word_info[3]
                word_num_in_line = word_info[4]
                word_num = word_info[12]
                word_id = '{}_{}'.format(file_id, word_num)
                # if line_num == current_line_num:

                outf.write('\"{}\",{},{},{},{},{}\n'.format(word, file_id, text_num, line_num, word_num_in_line, word_id))