lm.interp.balanced.curr.0 <- lmer(FPASSD ~ interp.balanced.total.prob + 
                                    (1|SUBJ) + (1|word_id), 
                                  data=dat.no.punct, REML=FALSE)
summary(lm.interp.balanced.curr.0)

lm.interp.balanced.curr.1 <- lmer(FPASSD ~ interp.balanced.total.prob + 
                                    kenlm1gram.total.prob * log(WLEN) + 
                                    PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                  data=dat.no.punct, REML=FALSE)
summary(lm.interp.balanced.curr.1)

lm.interp.balanced.prev.1 <- lmer(FPASSD ~ interp.balanced.total.prob + interp.balanced.prev +
                                    kenlm1gram.total.prob * log(WLEN) + 
                                    k1gram.prev * log(wlen.prev) + 
                                    PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                  data=dat.no.punct, REML=FALSE)
summary(lm.interp.balanced.prev.1)

lm.interp.balanced.plus.rnn.curr.1 <- lmer(FPASSD ~ interp.balanced.total.prob + rnn.total.prob +
                                             kenlm1gram.total.prob * log(WLEN) + 
                                             PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                           data=dat.no.punct, REML=FALSE)
summary(lm.interp.balanced.plus.rnn.curr.1)

lm.interp.balanced.plus.rnn.prev.1 <- lmer(FPASSD ~ interp.balanced.total.prob + interp.balanced.prev +
                                             rnn.total.prob + rnn.prev +
                                             kenlm1gram.total.prob * log(WLEN) + 
                                             k1gram.prev * log(wlen.prev) + 
                                             PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                           data=dat.no.punct, REML=FALSE)
summary(lm.interp.balanced.plus.rnn.prev.1)

lm.interp.balanced.plus.5gram.curr.1 <- lmer(FPASSD ~ interp.balanced.total.prob +
                                               kenlm5gram.total.prob + 
                                               kenlm1gram.total.prob * log(WLEN) + 
                                               PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                             data=dat.no.punct, REML=FALSE)
summary(lm.interp.balanced.plus.5gram.curr.1)

lm.interp.balanced.plus.5gram.prev.1 <- lmer(FPASSD ~ interp.balanced.total.prob + interp.balanced.prev +
                                               kenlm5gram.total.prob + k5gram.prev +
                                               kenlm1gram.total.prob * log(WLEN) + 
                                               k1gram.prev * log(wlen.prev) + 
                                               PREVFIX + log(WNUM) + (1|SUBJ) + (1|word_id), 
                                             data=dat.no.punct, REML=FALSE)
summary(lm.interp.plus.5gram.prev.1)
