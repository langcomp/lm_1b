library(lme4)

lm.unigram.iter <- lmer(FPASSD ~ 
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
                   (k1gram.curr + k1gram.prev||SUBJ),
                 data=dat.no.punct)
summary(lm.unigram.iter)

lm.bigram.iter <- lmer(FPASSD ~
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
                data=dat.no.punct)
summary(lm.bigram.iter)

lm.trigram.iter <- lmer(FPASSD ~
                   ct(k3gram.curr) +
                   ct(k3gram.prev) +
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
                   (k3gram.curr + k3gram.prev +
                     k2gram.curr + k2gram.prev +
                      k1gram.curr + k1gram.prev||SUBJ),
                 data=dat.no.punct)
summary(lm.trigram.iter)

lm.trigram.nobigram.iter <- lmer(FPASSD ~
                          ct(k3gram.curr) +
                          ct(k3gram.prev) +
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
                          (k3gram.curr + k3gram.prev +
                             # k2gram.curr + k2gram.prev +
                             k1gram.curr + k1gram.prev||SUBJ),
                        data=dat.no.punct)
summary(lm.trigram.nobigram.iter)


######## drop 1 tests #########
uni.drop.k1gram.curr <- drop1(lm.unigram.iter, scope='ct(k1gram.curr)', test='Chisq')
uni.drop.k1gram.prev <- drop1(lm.unigram.iter, scope='ct(k1gram.prev)', test='Chisq')
bi.drop.k2gram.curr <- drop1(lm.bigram.iter, scope='ct(k2gram.curr)', test='Chisq')
bi.drop.k2gram.prev <- drop1(lm.bigram.iter, scope='ct(k2gram.prev)', test='Chisq')
tri.drop.k3gram.curr <- drop1(lm.trigram.iter, scope='ct(k3gram.curr)', test='Chisq')
tri.drop.k3gram.prev <- drop1(lm.trigram.iter, scope='ct(k3gram.prev)', test='Chisq')

tri.nobigram.drop.k3gram.curr <- drop1(lm.trigram.nobigram.iter, scope='ct(k3gram.curr)', test='Chisq')
tri.nobigram.drop.k3gram.prev <- drop1(lm.trigram.nobigram.iter, scope='ct(k3gram.prev)', test='Chisq')
######## BALANCED #############

lm.unigram.balanced.iter <- lmer(FPASSD ~ 
                                   ct(k1gram.curr) +
                                   ct(k1gram.prev) +
                                   ct(interp.balanced.curr) + 
                                   ct(interp.balanced.prev) + 
                                   ct(log(WLEN)) +
                                   ct(log(wlen.prev)) +
                                   ct(k1gram.curr):ct(log(WLEN)) +
                                   ct(k1gram.prev):ct(log(wlen.prev)) +
                                   PREVFIX + 
                                   log(WNUM) + 
                                   (k1gram.curr + k1gram.prev||SUBJ),
                                 data=dat.no.punct)
summary(lm.unigram.balanced.iter)

lm.bigram.balanced.iter <- lmer(FPASSD ~
                                  ct(k2gram.curr) +
                                  ct(k2gram.prev) +
                                  ct(k1gram.curr) +
                                  ct(k1gram.prev) +
                                  ct(interp.balanced.curr) + 
                                  ct(interp.balanced.prev) + 
                                  ct(log(WLEN)) +
                                  ct(log(wlen.prev)) +
                                  ct(k1gram.curr):ct(log(WLEN)) +
                                  ct(k1gram.prev):ct(log(wlen.prev)) +
                                  PREVFIX + 
                                  log(WNUM) + 
                                  (k2gram.curr + k2gram.prev +
                                     k1gram.curr + k1gram.prev||SUBJ),
                                data=dat.no.punct)
summary(lm.bigram.balanced.iter)

lm.trigram.balanced.iter <- lmer(FPASSD ~
                                   ct(k3gram.curr) +
                                   ct(k3gram.prev) +
                                   ct(k2gram.curr) +
                                   ct(k2gram.prev) +
                                   ct(k1gram.curr) +
                                   ct(k1gram.prev) +
                                   ct(interp.balanced.curr) + 
                                   ct(interp.balanced.prev) + 
                                   ct(log(WLEN)) +
                                   ct(log(wlen.prev)) +
                                   ct(k1gram.curr):ct(log(WLEN)) +
                                   ct(k1gram.prev):ct(log(wlen.prev)) +
                                   PREVFIX + 
                                   log(WNUM) + 
                                   (k3gram.curr + k3gram.prev +
                                      k2gram.curr + k2gram.prev +
                                      k1gram.curr + k1gram.prev||SUBJ),
                                 data=dat.no.punct)
summary(lm.trigram.balanced.iter)

lm.trigram.balanced.nobigram.iter <- lmer(FPASSD ~
                                   ct(k3gram.curr) +
                                   ct(k3gram.prev) +
                                   # ct(k2gram.curr) +
                                   # ct(k2gram.prev) +
                                   ct(k1gram.curr) +
                                   ct(k1gram.prev) +
                                   ct(interp.balanced.curr) + 
                                   ct(interp.balanced.prev) + 
                                   ct(log(WLEN)) +
                                   ct(log(wlen.prev)) +
                                   ct(k1gram.curr):ct(log(WLEN)) +
                                   ct(k1gram.prev):ct(log(wlen.prev)) +
                                   PREVFIX + 
                                   log(WNUM) + 
                                   (k3gram.curr + k3gram.prev +
                                      # k2gram.curr + k2gram.prev +
                                      k1gram.curr + k1gram.prev||SUBJ),
                                 data=dat.no.punct)
summary(lm.trigram.balanced.nobigram.iter)

######## drop 1 tests #########
uni.bal.drop.k1gram.curr <- drop1(lm.unigram.balanced.iter, scope='ct(k1gram.curr)', test='Chisq')
uni.bal.drop.k1gram.prev <- drop1(lm.unigram.balanced.iter, scope='ct(k1gram.prev)', test='Chisq')
bi.bal.drop.k2gram.curr <- drop1(lm.bigram.balanced.iter, scope='ct(k2gram.curr)', test='Chisq')
bi.bal.drop.k2gram.prev <- drop1(lm.bigram.balanced.iter, scope='ct(k2gram.prev)', test='Chisq')
tri.bal.drop.k3gram.curr <- drop1(lm.trigram.balanced.iter, scope='ct(k3gram.curr)', test='Chisq')
tri.bal.drop.k3gram.prev <- drop1(lm.trigram.balanced.iter, scope='ct(k3gram.prev)', test='Chisq')

# only in EMNLP
tri.nobigram.bal.drop.k3gram.curr <- drop1(lm.trigram.balanced.nobigram.iter, scope='ct(k3gram.curr)', test='Chisq')
tri.nobigram.bal.drop.k3gram.prev <- drop1(lm.trigram.balanced.nobigram.iter, scope='ct(k3gram.prev)', test='Chisq')
#### results for acl table
uni.drop.k1gram.curr$`Pr(Chi)`[[2]]
uni.drop.k1gram.prev$`Pr(Chi)`[[2]]
bi.drop.k2gram.curr$`Pr(Chi)`[[2]]
bi.drop.k2gram.prev$`Pr(Chi)`[[2]]
tri.drop.k3gram.curr$`Pr(Chi)`[[2]]
tri.drop.k3gram.prev$`Pr(Chi)`[[2]]
uni.bal.drop.k1gram.curr$`Pr(Chi)`[[2]]
uni.bal.drop.k1gram.prev$`Pr(Chi)`[[2]]
bi.bal.drop.k2gram.curr$`Pr(Chi)`[[2]]
bi.bal.drop.k2gram.prev$`Pr(Chi)`[[2]]
tri.bal.drop.k3gram.curr$`Pr(Chi)`[[2]]
tri.bal.drop.k3gram.prev$`Pr(Chi)`[[2]]
# for EMNLP
tri.nobigram.drop.k3gram.curr$`Pr(Chi)`[[2]]
tri.nobigram.drop.k3gram.prev$`Pr(Chi)`[[2]]
tri.nobigram.bal.drop.k3gram.curr$`Pr(Chi)`[[2]]
tri.nobigram.bal.drop.k3gram.prev$`Pr(Chi)`[[2]]
