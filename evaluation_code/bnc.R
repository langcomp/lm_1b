library(tidyverse)

bnc <- read_delim('bnc_tokens_space.csv',delim=" ")

# word.surprisal.all.lower <- word.surprisal.all
# word.surprisal.all.lower$WORD <- tolower(word.surprisal.all.lower$WORD)

bnc.unique.tokens <- bnc[!duplicated(bnc$WORD) , ]

# bnc.dundee.tokens <- left_join(x=word.surprisal.all, y=bnc.unique.tokens, 
#                                 by="WORD")
# 
# # add previous word's variables
# bnc.dundee.tokens <- bnc.dundee.tokens %>%
#   group_by(FILE) %>%
#   mutate(rnn.prev = lag(rnn.total.prob),
#          k5gram.prev = lag(kenlm5gram.total.prob),
#          k4gram.prev = lag(kenlm4gram.total.prob),
#          k3gram.prev = lag(kenlm3gram.total.prob),
#          k2gram.prev = lag(kenlm2gram.total.prob),
#          k1gram.prev = lag(kenlm1gram.total.prob),
#          interp.prev = lag(interp.total.prob),
#          interp.balanced.prev = lag(interp.balanced.total.prob),
#          wlen.prev = lag(nchar(WORD)),
#          alpha.prev = lag(is.letters(WORD))) %>%
#   ungroup()
# 
# # filter only words where previous word was alphabetical word
# bnc.dundee.tokens <- bnc.dundee.tokens %>% filter(alpha.prev == TRUE)
# 
# # adjust alignment. bug in dundee
# ### \years!'''\ printed as \years!_\ in file
# bnc.dundee.tokens$WNUM[bnc.dundee.tokens$FILE == 18 & bnc.dundee.tokens$WNUM > 1169] <- bnc.dundee.tokens$WNUM[bnc.dundee.tokens$FILE == 18 & bnc.dundee.tokens$WNUM > 1169] + 1
# 
# # add word_id (FILE_WNUM). Make sure word_id is a factor
# bnc.dundee.tokens$word_id <- as.factor(paste(bnc.dundee.tokens$FILE, bnc.dundee.tokens$WNUM, sep='_'))
# 
# # add line position info
# bnc.dundee.tokens <- left_join(x=bnc.dundee.tokens, y=token.line[ , c('SCREEN', 'LINE.NUM', 'WORD.IN.LINE.NUM',
#                                                                 'line.beginning', 'line.ending', 'word_id')],
#                             by=c('word_id'))
# 
# ## incorporate into raw data for all subjects
# bnc.dat <- left_join(gaze.times, bnc.dundee.tokens, by=c('FILE', 'WNUM', 'WORD'))
# bnc.dat$word_id <- as.factor(paste(bnc.dat$FILE, bnc.dat$WNUM, sep='_'))
# bnc.dat$SUBJ <- factor(bnc.dat$SUBJ)
# 
# # filter to words where current word is alphabetical
# bnc.dat.no.punct <- bnc.dat %>% filter(is.letters(WORD))
# 
# # filter words not in lm_1b, i.e. no unigram probability
# bnc.dat.no.punct <- bnc.dat.no.punct[!is.na(bnc.dat.no.punct$kenlm1gram.total.prob) , ]
# 
# # remove line beginnings and endings
# bnc.dat.no.punct <- bnc.dat.no.punct %>% filter(line.beginning==0, line.ending==0)
