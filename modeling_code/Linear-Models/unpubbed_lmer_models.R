library(tidyverse)
library(lme4)
library(mgcv)
library(gamm4)

######### simple lmer ########
lm.rnn.1 <- lmer(FPASSD ~ rnn.total.prob + (1|SUBJ) + (1|word_id), data=dat.no.punct, REML=FALSE)
summary(lm.rnn.1)

lm.kenlm5gram.1 <- lmer(FPASSD ~ kenlm5gram.total.prob + (1|SUBJ) + (1|word_id), data=dat.no.punct, REML=FALSE)
summary(lm.kenlm5gram.1)

lm.kenlm4gram.1 <- lmer(FPASSD ~ kenlm4gram.total.prob + (1|SUBJ) + (1|word_id), data=dat.no.punct, REML=FALSE)
summary(lm.kenlm4gram.1)

lm.kenlm3gram.1 <- lmer(FPASSD ~ kenlm3gram.total.prob + (1|SUBJ) + (1|word_id), data=dat.no.punct, REML=FALSE)
summary(lm.kenlm3gram.1)

lm.kenlm2gram.1 <- lmer(FPASSD ~ kenlm2gram.total.prob + (1|SUBJ) + (1|word_id), data=dat.no.punct, REML=FALSE)
summary(lm.kenlm2gram.1)

lm.kenlm1gram.1 <- lmer(FPASSD ~ kenlm1gram.total.prob + (1|SUBJ) + (1|word_id), data=dat.no.punct, REML=FALSE)
summary(lm.kenlm1gram.1)

########## lmer with additional covariates on current word #############

lm.rnn.2 <- lmer(FPASSD ~ rnn.total.prob +  
                   kenlm1gram.total.prob * 
                   log(WLEN) + PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                 data=dat.no.punct, REML=FALSE)
summary(lm.rnn.2)

lm.klm5gram.2 <- lmer(FPASSD ~ kenlm5gram.total.prob +  kenlm1gram.total.prob * log(WLEN) + PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                        data=dat.no.punct, REML=FALSE)
summary(lm.klm5gram.2)

lm.kenlm4gram.2 <- lmer(FPASSD ~ kenlm4gram.total.prob +  kenlm1gram.total.prob * log(WLEN) + PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                        data=dat.no.punct, REML=FALSE)
summary(lm.kenlm4gram.2)

lm.kenlm3gram.2 <- lmer(FPASSD ~ kenlm3gram.total.prob +  kenlm1gram.total.prob * log(WLEN) + PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                        data=dat.no.punct, REML=FALSE)
summary(lm.kenlm3gram.2)

lm.kenlm2gram.2 <- lmer(FPASSD ~ kenlm2gram.total.prob +  kenlm1gram.total.prob * log(WLEN) + PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                        data=dat.no.punct, REML=FALSE)
summary(lm.kenlm2gram.2)

lm.kenlm1gram.2 <- lmer(FPASSD ~ kenlm1gram.total.prob +  kenlm1gram.total.prob * log(WLEN) + PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                        data=dat.no.punct, REML=FALSE)
summary(lm.kenlm1gram.2)

################### lmer w previous #############

lm.rnn.3 <- lmer(FPASSD ~ rnn.total.prob + rnn.prev +
                   kenlm1gram.total.prob * log(WLEN) + 
                   k1gram.prev * log(wlen.prev) + 
                   PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                 data=dat.no.punct, REML=FALSE)
summary(lm.rnn.3)

dat.no.punct.rnn.na <- dat.no.punct[is.na(dat.no.punct$rnn.prev) , ]
str(eval(lm.rnn.3))
str(eval(lm.interp.curr.0))
lm.klm5gram.3 <- lmer(FPASSD ~ kenlm5gram.total.prob + k5gram.prev +
                        kenlm1gram.total.prob * log(WLEN) + 
                        k1gram.prev * log(wlen.prev) + 
                        PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                      data=dat.no.punct, REML=FALSE)
summary(lm.klm5gram.3)

lm.klm4gram.3 <- lmer(FPASSD ~ kenlm4gram.total.prob + k4gram.prev +
                        kenlm1gram.total.prob * log(WLEN) + 
                        k1gram.prev * log(wlen.prev) + 
                        PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                      data=dat.no.punct, REML=FALSE)
summary(lm.klm4gram.3)

lm.klm3gram.3 <- lmer(FPASSD ~ kenlm3gram.total.prob + k3gram.prev +
                        kenlm1gram.total.prob * log(WLEN) + 
                        k1gram.prev * log(wlen.prev) + 
                        PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                      data=dat.no.punct, REML=FALSE)
summary(lm.klm3gram.3)

lm.klm2gram.3 <- lmer(FPASSD ~ kenlm2gram.total.prob + k2gram.prev +
                        kenlm1gram.total.prob * log(WLEN) + 
                        k1gram.prev * log(wlen.prev) + 
                        PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                      data=dat.no.punct, REML=FALSE)
summary(lm.klm2gram.3)

lm.klm1gram.3 <- lmer(FPASSD ~ kenlm1gram.total.prob * log(WLEN) + 
                        k1gram.prev * log(wlen.prev) + 
                        PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                      data=dat.no.punct, REML=FALSE)
summary(lm.klm1gram.3)

##### interpolated model ######

lm.interp.curr.0 <- lmer(FPASSD ~ interp.total.prob + 
                           (1|SUBJ) + (1|word_id), 
                         data=dat.no.punct, REML=FALSE)
summary(lm.interp.curr.0)


lm.interp.curr.1 <- lmer(FPASSD ~ interp.total.prob + 
                           kenlm1gram.total.prob * log(WLEN) + 
                           PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                         data=dat.no.punct, REML=FALSE)
summary(lm.interp.curr.1)

# lm.interp.prev.0 <- lmer(FPASSD ~ interp.total.prob + interp.prev +
#                            (1|SUBJ) + (1|word_id), 
#                          data=dat.no.punct, REML=FALSE)
# summary(lm.interp.prev.0)

lm.interp.prev.1 <- lmer(FPASSD ~ interp.total.prob + interp.prev +
                           kenlm1gram.total.prob * log(WLEN) + 
                           k1gram.prev * log(wlen.prev) + 
                           PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                         data=dat.no.punct, REML=FALSE)
summary(lm.interp.prev.1)

lm.interp.plus.rnn.curr.1 <- lmer(FPASSD ~ interp.total.prob + rnn.total.prob +
                                    kenlm1gram.total.prob * log(WLEN) + 
                                    PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                  data=dat.no.punct, REML=FALSE)
summary(lm.interp.plus.rnn.curr.1)

lm.interp.plus.rnn.prev.1 <- lmer(FPASSD ~ interp.total.prob + interp.prev +
                                    rnn.total.prob + rnn.prev +
                                    kenlm1gram.total.prob * log(WLEN) + 
                                    k1gram.prev * log(wlen.prev) + 
                                    PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                  data=dat.no.punct, REML=FALSE)
summary(lm.interp.plus.rnn.prev.1)

lm.interp.plus.5gram.curr.1 <- lmer(FPASSD ~ interp.total.prob +
                                      kenlm5gram.total.prob + 
                                      kenlm1gram.total.prob * log(WLEN) + 
                                      PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                    data=dat.no.punct, REML=FALSE)
summary(lm.interp.plus.5gram.curr.1)


lm.interp.plus.5gram.prev.1 <- lmer(FPASSD ~ interp.total.prob + interp.prev +
                                      kenlm5gram.total.prob + k5gram.prev +
                                      kenlm1gram.total.prob * log(WLEN) + 
                                      k1gram.prev * log(wlen.prev) + 
                                      PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                    data=dat.no.punct, REML=FALSE)
summary(lm.interp.plus.5gram.prev.1)

