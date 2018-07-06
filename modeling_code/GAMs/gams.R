library(broom)
library(mgcv)
library(gamm4)

######### GAMs with only current word ################
gam.rnn.0 <- bam(FPASSD ~ s(rnn.total.prob, bs = 'cr', k=40) + 
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'),
                 data=dat.no.punct)
summary(gam.rnn.0)
logLik.gam(gam.rnn.0)

gam.kenlm5gram.0 <- bam(FPASSD ~ s(kenlm5gram.total.prob, bs = 'cr', k=40) + 
                          te(kenlm1gram.total.prob, log(WLEN)) + 
                          PREVFIX + s(log(WNUM), bs = 'cr') + 
                          s(SUBJ, bs='re'),
                        data=dat.no.punct)
summary(gam.kenlm5gram.0)
logLik.gam(gam.kenlm5gram.0)

gam.kenlm4gram.0 <- bam(FPASSD ~ s(kenlm4gram.total.prob, bs = 'cr', k=40) + 
                          te(kenlm1gram.total.prob, log(WLEN)) + 
                          PREVFIX + s(log(WNUM), bs = 'cr') + 
                          s(SUBJ, bs='re'),
                        data=dat.no.punct)
summary(gam.kenlm4gram.0)
logLik.gam(gam.kenlm4gram.0)

gam.kenlm3gram.0 <- bam(FPASSD ~ s(kenlm3gram.total.prob, bs = 'cr', k=40) + 
                          te(kenlm1gram.total.prob, log(WLEN)) + 
                          PREVFIX + s(log(WNUM), bs = 'cr') + 
                          s(SUBJ, bs='re'),
                        data=dat.no.punct)
summary(gam.kenlm3gram.0)
logLik.gam(gam.kenlm3gram.0)

gam.kenlm2gram.0 <- bam(FPASSD ~ s(kenlm2gram.total.prob, bs = 'cr', k=40) + 
                          te(kenlm1gram.total.prob, log(WLEN)) + 
                          PREVFIX + s(log(WNUM), bs = 'cr') + 
                          s(SUBJ, bs='re'),
                        data=dat.no.punct)
summary(gam.kenlm2gram.0)
logLik.gam(gam.kenlm2gram.0)

gam.kenlm1gram.0 <- bam(FPASSD ~ te(kenlm1gram.total.prob, log(WLEN)) + 
                          PREVFIX + s(log(WNUM), bs = 'cr') + 
                          s(SUBJ, bs='re'),
                        data=dat.no.punct)
summary(gam.kenlm1gram.0)
logLik.gam(gam.kenlm1gram.0)

plot(gam.rnn.0, select=1)
plot(gam.kenlm5gram.0, select=1)
plot(gam.kenlm4gram.0, select=1)
plot(gam.kenlm3gram.0, select=1)
plot(gam.kenlm2gram.0, select=1)
plot(gam.kenlm1gram.0, select=1)

################# GAMs with previous word ###############

gam.rnn.1 <- bam(FPASSD ~ s(rnn.total.prob, bs = 'cr', k=40) + 
                   s(rnn.prev, bs='cr', k=40) +
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   te(k1gram.prev, log(wlen.prev)) +
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'),
                 data=dat.no.punct)
summary(gam.rnn.1)
logLik.gam(gam.rnn.1)

gam.rnn.prev.linear <- bam(FPASSD ~ rnn.total.prob + 
                   rnn.prev +
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   te(k1gram.prev, log(wlen.prev)) +
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'),
                 data=dat.no.punct)
logLik.gam(gam.rnn.prev.linear)

gam.klm5gram.1 <- bam(FPASSD ~ s(kenlm5gram.total.prob, bs = 'cr', k=40) + 
                        s(k5gram.prev, bs='cr', k=40) +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
summary(gam.klm5gram.1)
logLik.gam(gam.klm5gram.1)

gam.klm5gram.prev.linear <- bam(FPASSD ~ kenlm5gram.total.prob + 
                        k5gram.prev +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
logLik.gam(gam.klm5gram.prev.linear)

gam.klm4gram.1 <- bam(FPASSD ~ s(kenlm4gram.total.prob, bs = 'cr', k=40) + 
                        s(k4gram.prev, bs='cr', k=40) +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
summary(gam.klm4gram.1)
logLik.gam(gam.klm4gram.1)

gam.klm4gram.prev.linear <- bam(FPASSD ~ kenlm4gram.total.prob + 
                        k4gram.prev +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
logLik.gam(gam.klm4gram.prev.linear)

gam.klm3gram.1 <- bam(FPASSD ~ s(kenlm3gram.total.prob, bs = 'cr', k=40) + 
                        s(k3gram.prev, bs='cr', k=40) +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
summary(gam.klm3gram.1)
logLik.gam(gam.klm3gram.1)

gam.klm3gram.prev.linear <- bam(FPASSD ~ kenlm3gram.total.prob + 
                        k3gram.prev +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
logLik.gam(gam.klm3gram.prev.linear)

gam.klm2gram.1 <- bam(FPASSD ~ s(kenlm2gram.total.prob, bs = 'cr', k=40) + 
                        s(k2gram.prev, bs='cr', k=40) +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
summary(gam.klm2gram.1)
logLik.gam(gam.klm2gram.1)

gam.klm2gram.prev.linear <- bam(FPASSD ~ kenlm2gram.total.prob + 
                        k2gram.prev +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
logLik.gam(gam.klm2gram.prev.linear)

gam.klm1gram.1 <- bam(FPASSD ~ te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
summary(gam.klm1gram.1)
logLik.gam(gam.klm1gram.1)

gam.klm1gram.prev.nonlinear <- bam(FPASSD ~ te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)


plot(gam.rnn.1, select=1)
plot(gam.rnn.1, select=2)
plot(gam.klm5gram.1, select=1)
plot(gam.klm5gram.1, select=2)
plot(gam.klm4gram.1, select=1)
plot(gam.klm4gram.1, select=2)
plot(gam.klm3gram.1, select=1)
plot(gam.klm3gram.1, select=2)
plot(gam.klm2gram.1, select=1)
plot(gam.klm2gram.1, select=2)
plot(gam.klm1gram.1, select=1)
plot(gam.klm1gram.1, select=2)

########### unsmoothed logprob #############
gam.rnn.2 <- bam(FPASSD ~ rnn.total.prob + 
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   te(k1gram.prev, log(wlen.prev)) +
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'), method='ML',
                 data=dat.no.punct)
summary(gam.rnn.2)

gam.rnn.3 <- bam(FPASSD ~ rnn.total.prob + 
                   rnn.prev +
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   te(k1gram.prev, log(wlen.prev)) +
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'), method='ML',
                 data=dat.no.punct)
summary(gam.rnn.3)

gam.klm5gram.2 <- bam(FPASSD ~ kenlm5gram.total.prob + 
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'), method='ML',
                      data=dat.no.punct)
summary(gam.klm5gram.2)

gam.klm5gram.3 <- bam(FPASSD ~ kenlm5gram.total.prob + 
                        k5gram.prev +
                        te(kenlm1gram.total.prob, log(WLEN)) + 
                        te(k1gram.prev, log(wlen.prev)) +
                        PREVFIX + s(log(WNUM), bs = 'cr') + 
                        s(SUBJ, bs='re'), method='ML',
                      data=dat.no.punct)
summary(gam.klm5gram.3)
logLik.gam(gam.rnn.2)
logLik.gam(gam.rnn.3)
logLik.gam(gam.klm5gram.2)
logLik.gam(gam.klm5gram.3)

#### rnn + 5-gram ###############
gam.rnn.5gram.curr.word <- bam(FPASSD ~ rnn.total.prob + 
                                 kenlm5gram.total.prob + 
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   te(k1gram.prev, log(wlen.prev)) +
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'), method='ML',
                 data=dat.no.punct)
summary(gam.rnn.5gram.curr.word)

gam.rnn.5gram.prev.word <- bam(FPASSD ~ rnn.total.prob + 
                   rnn.prev +
                     kenlm5gram.total.prob + 
                     k5gram.prev +
                   te(kenlm1gram.total.prob, log(WLEN)) + 
                   te(k1gram.prev, log(wlen.prev)) +
                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                   s(SUBJ, bs='re'), method='ML',
                 data=dat.no.punct)
summary(gam.rnn.5gram.prev.word)

logLik.gam(gam.rnn.5gram.curr.word)
logLik.gam(gam.rnn.5gram.prev.word)

############ interpolated model #################

gam.interp.curr <- bam(FPASSD ~ s(interp.total.prob, bs = 'cr', k=40) + 
                              # interp.total.prob + 
                              # interp.prev +
                              te(kenlm1gram.total.prob, log(WLEN)) + 
                              # te(k1gram.prev, log(wlen.prev)) +
                              PREVFIX + s(log(WNUM), bs = 'cr') + 
                              s(SUBJ, bs='re'), method='ML',
                            data=dat.no.punct)

summary(gam.interp.curr)
logLik.gam(gam.interp.curr)

gam.interp.prev <- bam(FPASSD ~ s(interp.total.prob, bs = 'cr', k=40) + 
                                   s(interp.prev, bs = 'cr', k=40) + 
                                   te(kenlm1gram.total.prob, log(WLEN)) + 
                                   te(k1gram.prev, log(wlen.prev)) +
                                   PREVFIX + s(log(WNUM), bs = 'cr') + 
                                   s(SUBJ, bs='re'), method='ML',
                                 data=dat.no.punct)
summary(gam.interp.prev)
logLik.gam(gam.interp.prev)

gam.interp.prev.linear <- bam(FPASSD ~ interp.total.prob + 
                         interp.prev + 
                         te(kenlm1gram.total.prob, log(WLEN)) + 
                         te(k1gram.prev, log(wlen.prev)) +
                         PREVFIX + s(log(WNUM), bs = 'cr') + 
                         s(SUBJ, bs='re'), method='ML',
                       data=dat.no.punct)
summary(gam.interp.prev.linear)
logLik.gam(gam.interp.prev.linear)

plot(gam.interp.curr, select=1)
plot(gam.interp.prev, select=1)
plot(gam.interp.prev, select=2)

logLik.gam(gam.interp.curr)
logLik.gam(gam.interp.prev)

############ equal weight interpolation

gam.interp.balanced.curr <- bam(FPASSD ~ s(interp.balanced.total.prob, bs = 'cr', k=40) + 
                                  # interp.total.prob + 
                                  te(kenlm1gram.total.prob, log(WLEN)) + 
                                  PREVFIX + s(log(WNUM), bs = 'cr') + 
                                  s(SUBJ, bs='re'), method='ML',
                                data=dat.no.punct)

summary(gam.interp.balanced.curr)

gam.interp.balanced.prev <- bam(FPASSD ~ s(interp.balanced.total.prob, bs = 'cr', k=40) + 
                                  s(interp.balanced.prev, bs = 'cr', k=40) + 
                                  te(kenlm1gram.total.prob, log(WLEN)) + 
                                  te(k1gram.prev, log(wlen.prev)) +
                                  PREVFIX + s(log(WNUM), bs = 'cr') + 
                                  s(SUBJ, bs='re'), method='ML',
                                data=dat.no.punct)
summary(gam.interp.balanced.prev)

logLik.gam(gam.interp.balanced.curr)
logLik.gam(gam.interp.balanced.prev)

gam.interp.balanced.prev.linear <- bam(FPASSD ~ interp.balanced.total.prob + 
                                  interp.balanced.prev + 
                                  te(kenlm1gram.total.prob, log(WLEN)) + 
                                  te(k1gram.prev, log(wlen.prev)) +
                                  PREVFIX + s(log(WNUM), bs = 'cr') + 
                                  s(SUBJ, bs='re'), method='ML',
                                data=dat.no.punct)
logLik.gam(gam.interp.balanced.prev.linear)
