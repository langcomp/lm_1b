library(lme4)
library(stargazer)

# centering function
ct <- function(x) scale(x, scale=FALSE)

# baseline model - optimal
lm.unigram.control <- lmer(FPASSD ~ interp.curr + interp.prev + 
                    ct(k1gram.curr)*ct(log(WLEN)) +
                    ct(k1gram.prev)*ct(log(wlen.prev)) +
                    PREVFIX + log(WNUM) + (1|SUBJ),
                  data=dat.no.punct)

lm.bigram.control <- lmer(FPASSD ~ interp.curr + interp.prev + 
                   ct(k1gram.curr)*ct(log(WLEN)) +
                   ct(k1gram.prev)*ct(log(wlen.prev)) +
                     ct(k2gram.curr) +
                     ct(k2gram.prev) +
                   PREVFIX + log(WNUM) + (1|SUBJ),
                 data=dat.no.punct)

lm.trigram.control <- lmer(FPASSD ~ interp.curr + interp.prev + 
                            ct(k1gram.curr)*ct(log(WLEN)) +
                            ct(k1gram.prev)*ct(log(wlen.prev)) +
                            ct(k2gram.curr) +
                            ct(k2gram.prev) +
                             ct(k3gram.curr) +
                             ct(k3gram.prev) +
                            PREVFIX + log(WNUM) + (1|SUBJ),
                          data=dat.no.punct)

summary(lm.trigram.control)

# baseline model - balanced
lm.unigram.balanced.control <- lmer(FPASSD ~ interp.balanced.curr + interp.balanced.prev + 
                             ct(k1gram.curr)*ct(log(WLEN)) +
                             ct(k1gram.prev)*ct(log(wlen.prev)) +
                             PREVFIX + log(WNUM) + (1|SUBJ),
                           data=dat.no.punct)

lm.bigram.balanced.control <- lmer(FPASSD ~ interp.balanced.curr + interp.balanced.prev + 
                            ct(k1gram.curr)*ct(log(WLEN)) +
                            ct(k1gram.prev)*ct(log(wlen.prev)) +
                            ct(k2gram.curr) +
                            ct(k2gram.prev) +
                            PREVFIX + log(WNUM) + (1|SUBJ),
                          data=dat.no.punct)

lm.trigram.balanced.control <- lmer(FPASSD ~ interp.balanced.curr + interp.balanced.prev + 
                            ct(k1gram.curr)*ct(log(WLEN)) +
                            ct(k1gram.prev)*ct(log(wlen.prev)) +
                            ct(k2gram.curr) +
                            ct(k2gram.prev) +
                              ct(k3gram.curr) +
                              ct(k3gram.prev) +
                            PREVFIX + log(WNUM) + (1|SUBJ),
                            data=dat.no.punct)

summary(lm.unigram.balanced.control)
summary(lm.bigram.balanced.control)
summary(lm.trigram.balanced.control)

# random slopes by subject for ngram terms model
# interp - optimal
lm.unigram.rand.slope <- lmer(FPASSD ~ interp.curr + interp.prev + 
                             ct(k1gram.curr)*ct(log(WLEN)) +
                             ct(k1gram.prev)*ct(log(wlen.prev)) +
                             PREVFIX + log(WNUM) + (k1gram.curr|SUBJ),
                           data=dat.no.punct)

lm.bigram.rand.slope <- lmer(FPASSD ~ interp.curr + interp.prev + 
                            ct(k1gram.curr)*ct(log(WLEN)) +
                            ct(k1gram.prev)*ct(log(wlen.prev)) +
                            ct(k2gram.curr) +
                            ct(k2gram.prev) +
                            PREVFIX + log(WNUM) + (k2gram.curr|SUBJ),
                          data=dat.no.punct)

lm.bigram.rand.slope.k1k2 <- lmer(FPASSD ~ interp.curr + interp.prev + 
                               ct(k1gram.curr)*ct(log(WLEN)) +
                               ct(k1gram.prev)*ct(log(wlen.prev)) +
                               ct(k2gram.curr) +
                               ct(k2gram.prev) +
                               PREVFIX + log(WNUM) + 
                              (k1gram.curr+k2gram.curr|SUBJ),
                             data=dat.no.punct)

lm.trigram.rand.slope.v2 <- lmer(FPASSD ~ interp.curr + interp.prev + 
                               ct(k1gram.curr)*ct(log(WLEN)) +
                               ct(k1gram.prev)*ct(log(wlen.prev)) +
                               ct(k2gram.curr) +
                               ct(k2gram.prev) +
                                ct(k3gram.curr) +
                                ct(k3gram.prev) +
                               PREVFIX + log(WNUM) + 
                                (k1gram.curr + k2gram.curr + k3gram.curr|SUBJ),
                             data=dat.no.punct)

summary(lm.unigram.rand.slope)
summary(lm.bigram.rand.slope)
summary(lm.trigram.rand.slope)
stargazer(lm.unigram.rand.slope, lm.bigram.rand.slope, lm.trigram.rand.slope,
          type='text', column.labels=c('unigram', 'bigram', 'trigram'))

stargazer(lm.trigram.control, lm.trigram.rand.slope, lm.trigram.rand.slope.v2,
          type='text', column.labels=c('1','k3','k3,k2,k1'))

stargazer(lm.bigram.control, lm.bigram.rand.slope, lm.bigram.rand.slope.k1k2,
          type='text', column.labels=c('1','k2','k2 + k1'))

# interp - balanced
lm.unigram.balanced.rand.slope <- lmer(FPASSD ~ interp.balanced.curr + interp.balanced.prev + 
                                ct(k1gram.curr)*ct(log(WLEN)) +
                                ct(k1gram.prev)*ct(log(wlen.prev)) +
                                PREVFIX + log(WNUM) + (k1gram.curr|SUBJ),
                              data=dat.no.punct)

lm.bigram.balanced.rand.slope <- lmer(FPASSD ~ interp.balanced.curr + interp.balanced.prev + 
                               ct(k1gram.curr)*ct(log(WLEN)) +
                               ct(k1gram.prev)*ct(log(wlen.prev)) +
                               ct(k2gram.curr) +
                               ct(k2gram.prev) +
                               PREVFIX + log(WNUM) + (k2gram.curr|SUBJ),
                             data=dat.no.punct)

lm.trigram.balanced.rand.slope <- lmer(FPASSD ~ interp.balanced.curr + interp.balanced.prev + 
                                ct(k1gram.curr)*ct(log(WLEN)) +
                                ct(k1gram.prev)*ct(log(wlen.prev)) +
                                ct(k2gram.curr) +
                                ct(k2gram.prev) +
                                ct(k3gram.curr) +
                                ct(k3gram.prev) +
                                PREVFIX + log(WNUM) + (k3gram.curr|SUBJ),
                              data=dat.no.punct)

summary(lm.unigram.balanced.rand.slope)
summary(lm.bigram.balanced.rand.slope)
summary(lm.trigram.balanced.rand.slope)
stargazer(lm.unigram.balanced.rand.slope, lm.bigram.balanced.rand.slope, lm.trigram.balanced.rand.slope,
          type='text', column.labels=c('unigram.bal', 'bigram.bal', 'trigram.bal'))
