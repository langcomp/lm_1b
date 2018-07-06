from contractions import contractions
punctuation_set = set(['.', '?', '!', ';', ',', ':', '\'', '(', ')'])

def tokenize_word(word, token_list):
    '''
    Split word into constituent tokens based on puntuation
    :param word: entire word, including punctuation
    :param token_list: list of constituent tokens. starts out empty
    :return: list of constituent tokens
    '''
    if word.startswith("'") or word.startswith("("):
        token_list.append(word[0])
        tokenize_word(word[1:], token_list)
    elif word[-1] in punctuation_set:
        tokenize_word(word[:-1], token_list)
        token_list.append(word[-1])
    elif word in contractions.keys():
        whole_words = contractions[word].split()
        for token in whole_words:
            token_list.append(token)
    # possessive, not in contraction list
    elif word[-2:] == "\'s":
        token_list.append(word[:-2])
        token_list.append(word[-2:])
    else:
        token_list.append(word)

    return
