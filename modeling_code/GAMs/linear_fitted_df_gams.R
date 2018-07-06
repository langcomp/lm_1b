library(mgcv)

gam.interp.linear.fitteddf <- bam(FPASSD ~ 
    interp.total.prob + 
    interp.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.interp.linear.fitteddf)
logLik.gam(gam.interp.linear.fitteddf)

gam.interp.balanced.linear.fitteddf <- bam(FPASSD ~ 
    interp.balanced.total.prob + 
    interp.balanced.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.interp.balanced.linear.fitteddf)
logLik.gam(gam.interp.balanced.linear.fitteddf)

gam.rnn.linear.fitteddf <- bam(FPASSD ~ 
    rnn.total.prob + 
    rnn.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.rnn.linear.fitteddf)
logLik.gam(gam.rnn.linear.fitteddf)

gam.klm5gram.linear.fitteddf <- bam(FPASSD ~ 
    kenlm5gram.total.prob + 
    k5gram.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.klm5gram.linear.fitteddf)
logLik.gam(gam.klm5gram.linear.fitteddf)

gam.klm4gram.linear.fitteddf <- bam(FPASSD ~ 
    kenlm4gram.total.prob + 
    k4gram.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.klm4gram.linear.fitteddf)
logLik.gam(gam.klm4gram.linear.fitteddf)

gam.klm3gram.linear.fitteddf <- bam(FPASSD ~ 
    kenlm3gram.total.prob + 
    k3gram.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.klm3gram.linear.fitteddf)
logLik.gam(gam.klm3gram.linear.fitteddf)

gam.klm2gram.linear.fitteddf <- bam(FPASSD ~ 
    kenlm2gram.total.prob + 
    k2gram.prev +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
summary(gam.klm2gram.linear.fitteddf)
logLik.gam(gam.klm2gram.linear.fitteddf)

gam.klm1gram.linear.fitteddf <- bam(FPASSD ~ 
      te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
      te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
      PREVFIX + 
      s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
      s(SUBJ, bs='re', k=10),
    method='ML',
    data=dat.no.punct)
summary(gam.klm1gram.linear.fitteddf)
logLik.gam(gam.klm1gram.linear.fitteddf)

logLik.gam(gam.interp.linear.fitteddf)
logLik.gam(gam.interp.balanced.linear.fitteddf)
logLik.gam(gam.rnn.linear.fitteddf)
logLik.gam(gam.klm5gram.linear.fitteddf)
logLik.gam(gam.klm4gram.linear.fitteddf)
logLik.gam(gam.klm3gram.linear.fitteddf)
logLik.gam(gam.klm2gram.linear.fitteddf)

summary(gam.interp.linear.fitteddf)
summary(gam.interp.balanced.linear.fitteddf)
summary(gam.rnn.linear.fitteddf)
summary(gam.klm5gram.linear.fitteddf)
summary(gam.klm4gram.linear.fitteddf)
summary(gam.klm3gram.linear.fitteddf)
summary(gam.klm2gram.linear.fitteddf)
