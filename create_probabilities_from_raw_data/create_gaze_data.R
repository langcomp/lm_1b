library(tidyverse)

# this function encapsulates all alignment functions 
# to create only the main data frame
create_dat.no.punct <- function() {
  
  ## load utility functions to detect punctuation ##
  is.letters <- function(x) {
    grepl("^[[:alpha:]]+$", x)
  }
  
  is.leading.letter <- function(x) {
    grepl("^[[:alpha:]]", x)
  }
  
  is.trailing.letter <- function(x) {
    grepl("[[:alpha:]]$", x)
  }
  
  ##### interpolation
  log10sumexp <- function(a, b) {
    # modeled on scipy.misc.logsumexp
    # https://docs.scipy.org/doc/scipy-0.14.0/reference/generated/scipy.misc.logsumexp.html
    # see there for argument meaning
    a_max <- max(a)
    log10(sum(b * 10^(a - a_max))) + a_max
  }
  
  interpolate <- function(lp1, lp2, b) {
    # interpolates two log probabilities with mixing weight b
    log10sumexp(c(lp1, lp2), c(b, 1-b))
  }
  
  ##############################################################
  
  # alignment
  
  token.surprisal.all <- read_csv('token_surprisalv2.csv') # created in preprocessing
  lm_1b.tokens <- read.csv('lm1b-1gram.tsv', sep='\t', quote="")
  token.line <- read_csv('token_line_num.csv')
  
  ### insert interpolated token surprisal, using best fit and balanced
  token.surprisal.all <- token.surprisal.all %>%
    rowwise() %>%
    mutate(interp_logprob = interpolate(rnn_prob, kenlm5gram_prob, 0.73),
           interp.balanced_logprob = interpolate(rnn_prob, kenlm5gram_prob, 0.50),
           interp.overweight_logprob = interpolate(rnn_prob, kenlm5gram_prob, 0.27)) %>%
    ungroup()
  
  # filter out </s>
  token.surprisal <- token.surprisal.all %>% filter(!is.na(WNUM))
  
  # group tokens by word, add logprobs for each token
  word.surprisal.all <- token.surprisal %>%
    group_by(FILE, WNUM) %>%
    summarise(WORD = paste(WORD, collapse=''),
              rnn.curr = sum(rnn_prob),
              k5gram.curr = sum(kenlm5gram_prob),
              k4gram.curr = sum(kenlm4gram_prob),
              k3gram.curr = sum(kenlm3gram_prob),
              k2gram.curr = sum(kenlm2gram_prob),
              interp.curr = sum(interp_logprob),
              interp.balanced.curr = sum(interp.balanced_logprob),
              interp.overweight.curr = sum(interp.overweight_logprob)) %>%
    ungroup()
  
  # Add unigrams. Words with punctuation or OOV won't find a match,
  # and have NA for klm1gram.total.prob
  word.surprisal <- left_join(word.surprisal.all, lm_1b.tokens, by="WORD")
  # # do not filter by BNC at the moment
  # word.surprisal <- left_join(word.surprisal.all, bnc.unique.tokens, by="WORD")
  
  # add previous word's variables
  word.surprisal <- word.surprisal %>%
    group_by(FILE) %>%
    mutate(rnn.prev = lag(rnn.curr),
           k5gram.prev = lag(k5gram.curr),
           k4gram.prev = lag(k4gram.curr),
           k3gram.prev = lag(k3gram.curr),
           k2gram.prev = lag(k2gram.curr),
           k1gram.prev = lag(k1gram.curr),
           interp.prev = lag(interp.curr),
           interp.balanced.prev = lag(interp.balanced.curr),
           interp.overweight.prev = lag(interp.overweight.curr),
           wlen.prev = lag(nchar(WORD)),
           alpha.prev = lag(is.letters(WORD)), 
           # trailing.punct.prev = lag(!is.trailing.letter(WORD)),
           leading.punct.next = lead(!is.leading.letter(WORD))) %>%
    ungroup()
  
  # filter only words where previous word was alphabetical word
  word.surprisal <- word.surprisal %>% filter(alpha.prev == TRUE)
  
  # filter words where following word leads with punctuation
  word.surprisal <- word.surprisal %>% filter(leading.punct.next == FALSE)
  
  # sanity check, should be 0
  # word.surprisal.na <- word.surprisal[is.na(word.surprisal$FILE) , ]
  
  # adjust alignment. bug in dundee
  ### \years!'''\ printed as \years!_\ in file
  word.surprisal$WNUM[word.surprisal$FILE == 18 & word.surprisal$WNUM > 1169] <- word.surprisal$WNUM[word.surprisal$FILE == 18 & word.surprisal$WNUM > 1169] + 1
  
  # add word_id (FILE_WNUM). Make sure word_id is a factor
  word.surprisal$word_id <- as.factor(paste(word.surprisal$FILE, word.surprisal$WNUM, sep='_'))
  
  # add 1/0 (true/false) denoting if word is at the beginning or end of a line
  token.line <- token.line %>%
    group_by(FILE, SCREEN, LINE.NUM) %>%
    arrange(WORD.IN.LINE.NUM) %>%
    mutate(line.beginning = ifelse(row_number()==1,1,0),
           line.ending = ifelse(row_number()==n(),1,0)) %>%
    ungroup()
  
  # sanity check. should be 0
  token.line.dupe <- token.line[duplicated(token.line$word_id) , ]
  
  # add line position info
  token.line$word_id <- factor(token.line$word_id)
  word.surprisal <- left_join(x=word.surprisal, y=token.line[ , c('SCREEN', 'LINE.NUM', 'WORD.IN.LINE.NUM',
                                                                  'line.beginning', 'line.ending', 'word_id')],
                              by=c('word_id'))
  # filter NAs
  word.surprisal <- word.surprisal[!is.na(word.surprisal$k1gram.curr), ]
  word.surprisal <- word.surprisal[!is.na(word.surprisal$k1gram.prev), ]
  word.surprisal <- word.surprisal %>% filter(is.letters(WORD))
  
  ## incorporate into raw data for all subjects
  gaze.times <- read_csv('masterTX.csv')
  dat <- left_join(gaze.times, word.surprisal, by=c('FILE', 'WNUM', 'WORD'))
  dat$word_id <- as.factor(paste(dat$FILE, dat$WNUM, sep='_'))
  dat$SUBJ <- factor(dat$SUBJ)
  
  # filter to words where current word is alphabetical
  dat.no.punct <- dat %>% filter(is.letters(WORD))
  
  # sanity check
  # dat.no.punct.na <- dat.no.punct[is.na(dat.no.punct$kenlm1gram.total.prob) , ]
  
  # filter words not in lm_1b, i.e. no unigram probability
  dat.no.punct <- dat.no.punct[!is.na(dat.no.punct$k1gram.curr) , ]
  dat.no.punct <- dat.no.punct[!is.na(dat.no.punct$k1gram.prev) , ]
  
  dat.unique.token <- dat.no.punct[!duplicated(dat.no.punct$word_id) , ]
  
  # remove line beginnings and endings
  dat.no.punct <- dat.no.punct %>% filter(line.beginning==0, line.ending==0)
  
  # return word.surprisal and dat.no.punct
  return(list(word.surprisal, dat.no.punct))
}
# run the alignment function and save resulting df
all_results <- create_dat.no.punct()
word.surprisal <- data.frame(all_results[1])
dat.no.punct <- data.frame(all_results[2])
