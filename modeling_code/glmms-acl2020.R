library(lme4)
library(tidyverse)
library(broom)
library(broom.mixed)

# this model isn't converging
# lm.unigram.iter.ACL2020 <- lmer(FPASSD ~ 
#                           ct(k1gram.curr) +
#                           ct(k1gram.prev) +
#                           ct(interp.curr) + 
#                           ct(interp.prev) + 
#                           scale(log(WLEN)) +
#                           scale(log(wlen.prev)) +
#                           scale(k1gram.curr):scale(log(WLEN)) +
#                           scale(k1gram.prev):scale(log(wlen.prev)) +
#                           PREVFIX + 
#                           log(WNUM) + 
#                           (k1gram.curr + k1gram.prev||SUBJ),
#                         data=dat.no.punct)
lm.unigram.iter.ACL2020 <- lmer(FPASSD ~ 
                                  ct(k1gram.curr) +
                                  ct(k1gram.prev) +
                                  ct(interp.curr) + 
                                  ct(interp.prev) + 
                                  scale(log(WLEN)) +
                                  scale(log(wlen.prev)) +
                                  scale(I(ct(k1gram.curr)*ct(log(WLEN)))) +
                                  scale(I(ct(k1gram.prev)*ct(log(wlen.prev)))) +
                                  scale(PREVFIX) + 
                                  scale(log(WNUM)) + 
                                  (k1gram.curr + k1gram.prev||SUBJ),
                                control = lmerControl(optimizer = 'bobyqa'),
                                data=dat.no.punct)
summary(lm.unigram.iter.ACL2020)

lm.bigram.iter.ACL2020 <- lmer(FPASSD ~
                         ct(k2gram.curr) +
                         ct(k2gram.prev) +
                         ct(k1gram.curr) +
                         ct(k1gram.prev) +
                         ct(interp.curr) + 
                         ct(interp.prev) + 
                         ct(log(WLEN)) +
                         ct(log(wlen.prev)) +
                         ct(k1gram.curr):ct(log(WLEN)) +
                         ct(k1gram.prev):ct(log(wlen.prev)) +
                         PREVFIX + 
                         log(WNUM) + 
                         (k2gram.curr + k2gram.prev +
                            k1gram.curr + k1gram.prev||SUBJ),
                       data=dat.no.punct,
                       control = lmerControl(optimizer = 'bobyqa')
                       )

lm.trigram.nobigram.iter.ACL2020.noprev <- lmer(FPASSD ~
                                   ct(k3gram.curr) +
                                   # ct(k3gram.prev) +
                                   # ct(k2gram.curr) +
                                   # ct(k2gram.prev) +
                                   ct(k1gram.curr) +
                                   ct(k1gram.prev) +
                                   ct(interp.curr) + 
                                   ct(interp.prev) + 
                                   ct(log(WLEN)) +
                                   ct(log(wlen.prev)) +
                                   ct(k1gram.curr):ct(log(WLEN)) +
                                   ct(k1gram.prev):ct(log(wlen.prev)) +
                                   PREVFIX + 
                                   log(WNUM) + 
                                   (k3gram.curr + 
                                      # k3gram.prev +
                                      # k2gram.curr + k2gram.prev +
                                      k1gram.curr + k1gram.prev||SUBJ),
                                 data=dat.no.punct,
                                 control = lmerControl(optimizer = 'bobyqa')
                                  )
                                 