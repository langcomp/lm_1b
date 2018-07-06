gam.interp.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(interp.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(interp.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.interp.nonlinear.fitteddf)
summary(gam.interp.nonlinear.fitteddf)

gam.interp.balanced.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(interp.balanced.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(interp.balanced.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.interp.balanced.nonlinear.fitteddf)

gam.rnn.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(rnn.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(rnn.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.rnn.nonlinear.fitteddf)

gam.klm5gram.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(kenlm5gram.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(k5gram.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.klm5gram.nonlinear.fitteddf)

gam.klm4gram.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(kenlm4gram.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(k4gram.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.klm4gram.nonlinear.fitteddf)

gam.klm3gram.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(kenlm3gram.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(k3gram.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.klm3gram.nonlinear.fitteddf)

gam.klm2gram.nonlinear.fitteddf <- bam(FPASSD ~ 
    s(kenlm2gram.total.prob, bs = 'cr', k=9, fx=TRUE) + 
    s(k2gram.prev, bs='cr', k=7, fx=TRUE) +
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) + 
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX + 
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
    s(SUBJ, bs='re', k=10),
method='ML',
data=dat.no.punct)
logLik.gam(gam.klm2gram.nonlinear.fitteddf)

gam.klm1gram.nonlinear.fitteddf <- bam(FPASSD ~
    te(kenlm1gram.total.prob, log(WLEN), k=5, fx=TRUE) +
    te(k1gram.prev, log(wlen.prev), k=5, fx=TRUE) +
    PREVFIX +
    s(log(WNUM), bs = 'cr', k=3, fx=TRUE) +
    s(SUBJ, bs='re', k=10),
data=dat.no.punct)
logLik.gam(gam.klm1gram.nonlinear.fitteddf)

logLik.gam(gam.interp.nonlinear.fitteddf)
logLik.gam(gam.interp.balanced.nonlinear.fitteddf)
logLik.gam(gam.rnn.nonlinear.fitteddf)
logLik.gam(gam.klm5gram.nonlinear.fitteddf)
logLik.gam(gam.klm4gram.nonlinear.fitteddf)
logLik.gam(gam.klm3gram.nonlinear.fitteddf)
logLik.gam(gam.klm2gram.nonlinear.fitteddf)
# logLik.gam(gam.klm1gram.nonlinear.fitteddf)

summary(gam.interp.nonlinear.fitteddf)
summary(gam.interp.balanced.nonlinear.fitteddf)
summary(gam.rnn.nonlinear.fitteddf)
summary(gam.klm5gram.nonlinear.fitteddf)
summary(gam.klm4gram.nonlinear.fitteddf)
summary(gam.klm3gram.nonlinear.fitteddf)
summary(gam.klm2gram.nonlinear.fitteddf)
