library(lme4)
library(stargazer)

# centering function
ct <- function(x) scale(x, scale=FALSE)

##### curr + prev words
### bigrams
# control
lm.bigram.control <- lmer(FPASSD ~ interp.curr + interp.prev + 
                            ct(k1gram.curr)*ct(log(WLEN)) +
                            ct(k1gram.prev)*ct(log(wlen.prev)) +
                            ct(k2gram.curr) +
                            ct(k2gram.prev) +
                            PREVFIX + log(WNUM) + (1|SUBJ),
                          data=dat.no.punct)
summary(lm.bigram.control)
# bigram random effects
lm.bigram.rand.slope.curr.prev <- lmer(FPASSD ~ interp.curr + interp.prev + 
                               ct(k1gram.curr)*ct(log(WLEN)) +
                               ct(k1gram.prev)*ct(log(wlen.prev)) +
                               ct(k2gram.curr) +
                               ct(k2gram.prev) +
                               PREVFIX + log(WNUM) + 
                               (k2gram.curr + k2gram.prev|SUBJ),
                             data=dat.no.punct)
summary(lm.bigram.rand.slope.curr.prev)
# bigram + unigram random effects
lm.bigram.rand.slope.k1k2.curr.prev <- lmer(FPASSD ~ 
                                    ct(interp.curr) + ct(interp.prev) + 
                                    ct(k1gram.curr)*ct(log(WLEN)) +
                                    ct(k1gram.prev)*ct(log(wlen.prev)) +
                                    ct(k2gram.curr) +
                                    ct(k2gram.prev) +
                                    PREVFIX + log(WNUM) + 
                                    (k2gram.curr + k2gram.prev + 
                                       k1gram.curr + k1gram.prev|SUBJ),
                                  data=dat.no.punct)
summary(lm.bigram.rand.slope.k1k2.curr.prev)

stargazer(lm.bigram.control, lm.bigram.rand.slope.curr.prev, lm.bigram.rand.slope.k1k2.curr.prev,
          type='text', column.labels=c('1','k2','k2 + k1'))

####### trigrams
# control
lm.trigram.control <- lmer(FPASSD ~ interp.curr + interp.prev + 
                            ct(k1gram.curr)*ct(log(WLEN)) +
                            ct(k1gram.prev)*ct(log(wlen.prev)) +
                            ct(k2gram.curr) +
                            ct(k2gram.prev) +
                             ct(k3gram.curr) +
                             ct(k3gram.prev) +
                            PREVFIX + log(WNUM) + (1|SUBJ),
                          data=dat.no.punct)

# trigram random effects
lm.trigram.rand.slope.curr.prev <- lmer(FPASSD ~ interp.curr + interp.prev + 
                                         ct(k1gram.curr)*ct(log(WLEN)) +
                                         ct(k1gram.prev)*ct(log(wlen.prev)) +
                                         ct(k2gram.curr) +
                                         ct(k2gram.prev) +
                                          ct(k3gram.curr) +
                                          ct(k3gram.prev) +
                                         PREVFIX + log(WNUM) + 
                                         (k3gram.curr + k3gram.prev|SUBJ),
                                       data=dat.no.punct)

# trigram + bigram + unigram random effects
lm.trigram.rand.slope.k1k2k3.curr.prev <- lmer(FPASSD ~ interp.curr + interp.prev + 
                                              ct(k1gram.curr)*ct(log(WLEN)) +
                                              ct(k1gram.prev)*ct(log(wlen.prev)) +
                                              ct(k2gram.curr) +
                                              ct(k2gram.prev) +
                                                ct(k3gram.curr) +
                                                ct(k3gram.prev) +
                                              PREVFIX + log(WNUM) + 
                                              (k3gram.curr + k3gram.prev +
                                                k2gram.curr + k2gram.prev + 
                                                 k1gram.curr + k1gram.prev|SUBJ),
                                            data=dat.no.punct)

stargazer(lm.trigram.control, lm.trigram.rand.slope.curr.prev, lm.trigram.rand.slope.k1k2k3.curr.prev,
          type='text', column.labels=c('1','k3','k3 + k2 + k1'))
  
####### try a model without random correlations
lm.bigram.rand.slope.nocorrel.k1k2.curr.prev <- lmer(FPASSD ~ 
                                      interp.curr + interp.prev + 
                                      ct(k1gram.curr)*ct(log(WLEN)) +
                                      ct(k1gram.prev)*ct(log(wlen.prev)) +
                                      ct(k2gram.curr) +
                                      ct(k2gram.prev) +
                                      PREVFIX + log(WNUM) + 
                                      (k2gram.curr + k2gram.prev + 
                                         k1gram.curr + k1gram.prev||SUBJ),
                                    data=dat.no.punct)
summary(lm.bigram.rand.slope.nocorrel.k1k2.curr.prev)
