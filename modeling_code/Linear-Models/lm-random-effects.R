library(lme4)

# centering function
ct <- function(x) scale(x, scale=FALSE)

lm.bigram.full.model.rdm.slp.word <- lmer(FPASSD ~ 
     ct(interp.curr) + 
     ct(interp.prev) + 
     ct(k1gram.curr)*ct(log(WLEN)) +
     ct(k1gram.prev)*ct(log(wlen.prev)) +
     ct(k2gram.curr) +
     ct(k2gram.prev) +
     PREVFIX + 
     log(WNUM) + 
     (k2gram.curr + k2gram.prev + 
        k1gram.curr + k1gram.prev|SUBJ) +
     (k2gram.curr + k2gram.prev + 
        k1gram.curr + k1gram.prev|WORD),
   REML=FALSE,
   data=dat.no.punct)

# model interpolating rnn, 5gram and 2gram, to see the effects
# of 2gram. 
# removing random correlations
lm.rnn.5gram.2gram <- lmer(FPASSD ~ 
                             ct(rnn.curr) + 
                             ct(rnn.prev) + 
                             ct(k5gram.curr) +
                             ct(k5gram.prev) +
                             ct(k2gram.curr) +
                             ct(k2gram.prev) +
                             ct(k1gram.curr)*ct(log(WLEN)) +
                             ct(k1gram.prev)*ct(log(wlen.prev)) +
                             PREVFIX + 
                             log(WNUM) + 
                             (k2gram.curr + k2gram.prev + 
                                k1gram.curr + k1gram.prev||SUBJ),
                           REML=FALSE,
                           data=dat.no.punct)

summary(lm.rnn.5gram.2gram)
drop1(lm.rnn.5gram.2gram, scope='ct(k2gram.curr)', test='Chisq')
drop1(lm.rnn.5gram.2gram, scope='ct(k2gram.prev)', test='Chisq')

# model interpolating interp.balanced, 5gram and 2gram, to see the effects
# of 2gram. 
# removing random correlations
lm.interp.bal.5gram.2gram <- lmer(FPASSD ~ 
                                    ct(interp.balanced.curr) + 
                                    ct(interp.balanced.prev) + 
                                    ct(k5gram.curr) +
                                    ct(k5gram.prev) +
                                    ct(k2gram.curr) +
                                    ct(k2gram.prev) +
                                    ct(k1gram.curr)*ct(log(WLEN)) +
                                    ct(k1gram.prev)*ct(log(wlen.prev)) +
                                    PREVFIX + 
                                    log(WNUM) + 
                                    (k2gram.curr + k2gram.prev + 
                                       k1gram.curr + k1gram.prev||SUBJ),
                                  REML=FALSE,
                                  data=dat.no.punct)

summary(lm.interp.bal.5gram.2gram)
drop1(lm.interp.bal.5gram.2gram, scope='ct(k2gram.curr)', test='Chisq')
drop1(lm.interp.bal.5gram.2gram, scope='ct(k2gram.prev)', test='Chisq')

# random slopes for words
lm.bigram.rdm.slp.word <- lmer(FPASSD ~ 
                                 ct(interp.curr) + 
                                 ct(interp.prev) + 
                                 ct(k1gram.curr)*ct(log(WLEN)) +
                                 ct(k1gram.prev)*ct(log(wlen.prev)) +
                                 ct(k2gram.curr) +
                                 ct(k2gram.prev) +
                                 PREVFIX + 
                                 log(WNUM) + 
                                 (k2gram.curr + k2gram.prev + 
                                    k1gram.curr + k1gram.prev||SUBJ) +
                                 (k2gram.curr + k2gram.prev + 
                                    k1gram.curr + k1gram.prev||WORD),
                               REML=FALSE,
                               data=dat.no.punct)

