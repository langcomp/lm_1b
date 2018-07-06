library(mgcv)

# centering function
ct <- function(x) scale(x, scale=FALSE)

# Test fixed num of knots GAMs with incorporation of bigram models as controlling factor
gam.interp.fixed.k.unigramControl <- bam(FPASSD ~ 
                   s(interp.curr, bs = 'cr', k=40) + # smoothed term
                   s(interp.prev, bs='cr', k=40) + # smoothed term
                   te(k1gram.curr, log(WLEN)) + # interaction
                   te(k1gram.prev, log(wlen.prev)) + # interaction
                   PREVFIX + # linear term
                   s(log(WNUM), bs = 'cr') + # smoothed term
                   s(SUBJ, bs='re'), # 're' == random effect
                 data=dat.no.punct)

gam.interp.fixed.k.bigramControl <- bam(FPASSD ~ 
                  s(interp.curr, bs='cr', k=40) + 
                  s(interp.prev, bs='cr', k=40) +
                  k2gram.curr + 
                  k2gram.prev +
                  te(k1gram.curr, log(WLEN)) + 
                  te(k1gram.prev, log(wlen.prev)) +
                  PREVFIX + s(log(WNUM), bs = 'cr') + 
                  s(SUBJ, bs='re'),
                 data=dat.no.punct)

logLik.gam(gam.interp.fixedDF.unigramControl)
logLik.gam(gam.interp.fixedDF.bigramControl)

summary(gam.interp.fixedDF.unigramControl)
summary(gam.interp.fixedDF.bigramControl)

# balanced interpolated
gam.interp.balanced.fixed.k.unigramControl <- bam(FPASSD ~ s(interp.balanced.curr, bs = 'cr', k=40) + 
                                           s(interp.balanced.prev, bs='cr', k=40) +
                                           te(k1gram.curr, log(WLEN)) + 
                                           te(k1gram.prev, log(wlen.prev)) +
                                           PREVFIX + s(log(WNUM), bs = 'cr') + 
                                           s(SUBJ, bs='re'),
                                         data=dat.no.punct)

gam.interp.balanced.fixed.k.bigramControl <- bam(FPASSD ~ s(interp.balanced.curr, bs = 'cr', k=40) + 
                                          s(interp.balanced.prev, bs='cr', k=40) +
                                          k2gram.curr + 
                                          k2gram.prev +
                                          te(k1gram.curr, log(WLEN)) + 
                                          te(k1gram.prev, log(wlen.prev)) +
                                          PREVFIX + s(log(WNUM), bs = 'cr') + 
                                          s(SUBJ, bs='re'),
                                        data=dat.no.punct)

logLik.gam(gam.interp.fixedDF.unigramControl)
logLik.gam(gam.interp.fixedDF.bigramControl)

summary(gam.interp.balanced.fixedDF.unigramControl)
summary(gam.interp.balanced.fixedDF.bigramControl)

#########################
gam.bigram.rand.slope.curr.prev <- bam(FPASSD ~ s(interp.curr, bs = 'cr', k=40) + 
                              s(interp.prev, bs='cr', k=40) +
                              te(k1gram.curr, log(WLEN), bs='tp') +
                              te(k1gram.prev, log(wlen.prev), bs='tp') +
                              ct(k2gram.curr) +
                              ct(k2gram.prev) +
                              PREVFIX + s(log(WNUM), bs = 'cr') + 
                              ti(k2gram.curr, SUBJ, bs = c('tp', 're')) + 
                              ti(k2gram.prev, SUBJ, bs = c('tp', 're')) + 
                              s(SUBJ, bs='re'),
                             data=dat.no.punct)
summary(gam.bigram.rand.slope.curr.prev)

gam.bigram.rand.slope.k1k2.curr.prev <- bam(FPASSD ~ 
                s(interp.curr, bs='cr', k=40) + 
                s(interp.prev, bs='cr', k=40) +
                te(k1gram.curr, log(WLEN), bs='tp') +
                te(k1gram.prev, log(wlen.prev), bs='tp') +
                ct(k2gram.curr) +
                ct(k2gram.prev) +
                PREVFIX + s(log(WNUM), bs = 'cr') + 
                ti(k2gram.curr, SUBJ, bs = c('tp', 're')) + 
                ti(k2gram.prev, SUBJ, bs = c('tp', 're')) + 
                ti(k1gram.curr, SUBJ, bs = c('tp', 're')) + 
                ti(k1gram.prev, SUBJ, bs = c('tp', 're')) + 
                s(SUBJ, bs='re'),
              data=dat.no.punct)
summary(gam.bigram.rand.slope.k1k2.curr.prev)

## trying to get same CI and coef as lmer
gam.bigram.rand.slope.STND.k1k2.curr.prev <- bam(FPASSD ~ 
                s(interp.curr, bs='cr', k=40) + 
                s(interp.prev, bs='cr', k=40) +
                te(k1gram.curr, log(WLEN), bs='tp') +
                te(k1gram.prev, log(wlen.prev), bs='tp') +
                ct(k2gram.curr) +
                ct(k2gram.prev) +
                PREVFIX + s(log(WNUM), bs = 'cr') + # changed all to s()
                s(k2gram.curr, SUBJ, bs='re') + 
                s(k2gram.prev, SUBJ, bs = 're') + 
                s(k1gram.curr, SUBJ, bs = 're') + 
                s(k1gram.prev, SUBJ, bs = 're') + 
                s(SUBJ, bs='re'),
              data=dat.no.punct)
summary(gam.bigram.rand.slope.STND.k1k2.curr.prev)

gam.bigram.rand.slope.STND.k1k2.curr.prev <- bam(FPASSD ~ 
                     s(interp.curr, bs='cr', k=40) +
                       # ct(interp.curr) +
                     s(interp.prev, bs='cr', k=40) +
                     # ct(interp.prev) +
                     # te(k1gram.curr, log(WLEN), bs='tp') +
                       ct(k1gram.curr)*log(WLEN) +
                     te(k1gram.prev, log(wlen.prev), bs='tp') +
                       # ct(k1gram.prev)*log(wlen.prev) +
                     ct(k2gram.curr) +
                     ct(k2gram.prev) +
                     PREVFIX + s(log(WNUM), bs = 'cr') + # changed all to s()
                     s(k2gram.curr, SUBJ, bs='re') + 
                     s(k2gram.prev, SUBJ, bs = 're') + 
                     s(k1gram.curr, SUBJ, bs = 're') + 
                     s(k1gram.prev, SUBJ, bs = 're') + 
                     s(SUBJ, bs='re'),
                   data=dat.no.punct)
summary(gam.bigram.rand.slope.STND.k1k2.curr.prev)


##### from likelihood-ratio-tests.R, may be duplicates of above

# Test fixed df GAMs with incorporation of bigram models as controlling factor
gam.bigram.full.model.fixed.df <- bam(FPASSD ~ 
                                        s(interp.curr, bs='cr', k=40, fx=TRUE) + 
                                        s(interp.prev, bs='cr', k=40, fx=TRUE) +
                                        te(k1gram.curr, log(WLEN), bs='tp', fx=TRUE) +
                                        te(k1gram.prev, log(wlen.prev), bs='tp', fx=TRUE) +
                                        ct(k2gram.curr) +
                                        ct(k2gram.prev) +
                                        PREVFIX + 
                                        s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
                                        s(k2gram.curr, SUBJ, bs = 're', k=40) + 
                                        s(k2gram.prev, SUBJ, bs = 're', k=40) + 
                                        s(k1gram.curr, SUBJ, bs = 're', k=40) + 
                                        s(k1gram.prev, SUBJ, bs = 're', k=40) +
                                        s(SUBJ, bs='re', k=3),
                                      method='ML',
                                      data=dat.no.punct)

gam.bigram.no.k2gram.curr.fixed.df <- bam(FPASSD ~ 
                                            s(interp.curr, bs='cr', k=40, fx=TRUE) + 
                                            s(interp.prev, bs='cr', k=40, fx=TRUE) +
                                            te(k1gram.curr, log(WLEN), bs='tp', fx=TRUE) +
                                            te(k1gram.prev, log(wlen.prev), bs='tp', fx=TRUE) +
                                            # ct(k2gram.curr) +
                                            ct(k2gram.prev) +
                                            PREVFIX + 
                                            s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
                                            s(k2gram.curr, SUBJ, bs = 're', k=40) + 
                                            s(k2gram.prev, SUBJ, bs = 're', k=40) + 
                                            s(k1gram.curr, SUBJ, bs = 're', k=40) + 
                                            s(k1gram.prev, SUBJ, bs = 're', k=40) +
                                            s(SUBJ, bs='re', k=3),
                                          method='ML',
                                          data=dat.no.punct)

gam.bigram.no.k2gram.prev.fixed.df <- bam(FPASSD ~ 
                                            s(interp.curr, bs='cr', k=40, fx=TRUE) + 
                                            s(interp.prev, bs='cr', k=40, fx=TRUE) +
                                            te(k1gram.curr, log(WLEN), bs='tp', fx=TRUE) +
                                            te(k1gram.prev, log(wlen.prev), bs='tp', fx=TRUE) +
                                            ct(k2gram.curr) +
                                            # ct(k2gram.prev) +
                                            PREVFIX + 
                                            s(log(WNUM), bs = 'cr', k=3, fx=TRUE) + 
                                            s(k2gram.curr, SUBJ, bs = 're', k=40) + 
                                            s(k2gram.prev, SUBJ, bs = 're', k=40) + 
                                            s(k1gram.curr, SUBJ, bs = 're', k=40) + 
                                            s(k1gram.prev, SUBJ, bs = 're', k=40) +
                                            s(SUBJ, bs='re', k=3),
                                          method='ML',
                                          data=dat.no.punct)

logLik.gam(gam.bigram.full.model.fixed.df)
logLik.gam(gam.bigram.no.k2gram.curr.fixed.df)
logLik.gam(gam.bigram.no.k2gram.prev.fixed.df)

summary(gam.bigram.full.model.fixed.df)
summary(gam.bigram.no.k2gram.curr.fixed.df)
summary(gam.bigram.no.k2gram.prev.fixed.df)
