library(mgcv)

# centering function
ct <- function(x) scale(x, scale=FALSE)

gam.acl.unigram.fitted <- bam(FPASSD ~ 
                         ct(k1gram.curr) +
                         ct(k1gram.prev) +
                         s(interp.curr, bs='cr', k=40) +
                         s(interp.prev, bs='cr', k=40) +
                         s(log(WLEN)) +
                         s(log(wlen.prev)) +
                         te(k1gram.curr, log(WLEN), bs='tp') +
                         te(k1gram.prev, log(wlen.prev), bs='tp') +
                         PREVFIX + 
                         s(log(WNUM), bs = 'cr') +
                         s(k1gram.curr, SUBJ, bs = 're') + 
                         s(k1gram.prev, SUBJ, bs = 're') + 
                         s(SUBJ, bs='re'),
                       data=dat.no.punct)
summary(gam.acl.unigram.fitted)

  gam.acl.bigram.fitted <- bam(FPASSD ~ 
                         ct(k2gram.curr) +
                         ct(k2gram.prev) +
                         s(interp.curr, bs='cr', k=40) +
                         s(interp.prev, bs='cr', k=40) +
                         te(k1gram.curr, log(WLEN), bs='tp') +
                         te(k1gram.prev, log(wlen.prev), bs='tp') +
                         PREVFIX + 
                         s(log(WNUM), bs = 'cr') +
                         s(k2gram.curr, SUBJ, bs='re') + 
                         s(k2gram.prev, SUBJ, bs = 're') + 
                         s(k1gram.curr, SUBJ, bs = 're') + 
                         s(k1gram.prev, SUBJ, bs = 're') + 
                         s(SUBJ, bs='re'),
                       data=dat.no.punct)
  summary(gam.acl.bigram)

gam.acl.trigram.fitted <- bam(FPASSD ~ 
                        ct(k3gram.curr) +
                        ct(k3gram.prev) +
                        s(interp.curr, bs='cr', k=40) +
                        s(interp.prev, bs='cr', k=40) +
                        te(k1gram.curr, log(WLEN), bs='tp') +
                        te(k1gram.prev, log(wlen.prev), bs='tp') +
                        s(k2gram.curr, bs='cr') +
                        s(k2gram.prev, bs='cr') +
                        PREVFIX + 
                        s(log(WNUM), bs = 'cr') +
                        s(k3gram.curr, SUBJ, bs='re') + 
                        s(k3gram.prev, SUBJ, bs = 're') +
                        s(k2gram.curr, SUBJ, bs='re') + 
                        s(k2gram.prev, SUBJ, bs = 're') + 
                        s(k1gram.curr, SUBJ, bs = 're') + 
                        s(k1gram.prev, SUBJ, bs = 're') + 
                        s(SUBJ, bs='re'),
                      data=dat.no.punct)
summary(gam.acl.trigram)

gam.acl.unigram.balanced <- bam(FPASSD ~ 
                                ct(k1gram.curr) +
                                ct(k1gram.prev) +
                                s(interp.balanced.curr, bs='cr', k=40) +
                                s(interp.balanced.prev, bs='cr', k=40) +
                                s(log(WLEN)) +
                                s(log(wlen.prev)) +
                                ti(k1gram.curr, log(WLEN), bs='tp') +
                                ti(k1gram.prev, log(wlen.prev), bs='tp') +
                                PREVFIX + 
                                s(log(WNUM), bs = 'cr') +
                                s(k1gram.curr, SUBJ, bs = 're') + 
                                s(k1gram.prev, SUBJ, bs = 're') + 
                                s(SUBJ, bs='re'),
                              data=dat.no.punct)
summary(gam.acl.unigram.balanced)

gam.acl.bigram.balanced <- bam(FPASSD ~ 
                               ct(k2gram.curr) +
                               ct(k2gram.prev) +
                               s(interp.balanced.curr, bs='cr', k=40) +
                               s(interp.balanced.prev, bs='cr', k=40) +
                               te(k1gram.curr, log(WLEN), bs='tp') +
                               te(k1gram.prev, log(wlen.prev), bs='tp') +
                               PREVFIX + 
                               s(log(WNUM), bs = 'cr') +
                               s(k2gram.curr, SUBJ, bs='re') + 
                               s(k2gram.prev, SUBJ, bs = 're') + 
                               s(k1gram.curr, SUBJ, bs = 're') + 
                               s(k1gram.prev, SUBJ, bs = 're') + 
                               s(SUBJ, bs='re'),
                             data=dat.no.punct)
summary(gam.acl.bigram.balanced)

gam.acl.trigram.balanced <- bam(FPASSD ~ 
                                ct(k3gram.curr) +
                                ct(k3gram.prev) +
                                s(interp.balanced.curr, bs='cr', k=40) +
                                s(interp.balanced.prev, bs='cr', k=40) +
                                te(k1gram.curr, log(WLEN), bs='tp') +
                                te(k1gram.prev, log(wlen.prev), bs='tp') +
                                s(k2gram.curr, bs='cr') +
                                s(k2gram.prev, bs='cr') +
                                PREVFIX + 
                                s(log(WNUM), bs = 'cr') +
                                s(k3gram.curr, SUBJ, bs='re') + 
                                s(k3gram.prev, SUBJ, bs = 're') +
                                s(k2gram.curr, SUBJ, bs='re') + 
                                s(k2gram.prev, SUBJ, bs = 're') + 
                                s(k1gram.curr, SUBJ, bs = 're') + 
                                s(k1gram.prev, SUBJ, bs = 're') + 
                                s(SUBJ, bs='re'),
                              data=dat.no.punct)
summary(gam.acl.trigram.balanced)

### exploratory. no bigram, just trigram
gam.acl.trigram.nobigramME.nobigramRE.fitted <- bam(FPASSD ~ 
                                ct(k3gram.curr) +
                                ct(k3gram.prev) +
                                s(interp.curr, bs='cr', k=40) +
                                s(interp.prev, bs='cr', k=40) +
                                te(k1gram.curr, log(WLEN), bs='tp') +
                                te(k1gram.prev, log(wlen.prev), bs='tp') +
                                # s(k2gram.curr, bs='cr') +
                                # s(k2gram.prev, bs='cr') +
                                PREVFIX + 
                                s(log(WNUM), bs = 'cr') +
                                s(k3gram.curr, SUBJ, bs='re') + 
                                s(k3gram.prev, SUBJ, bs = 're') +
                                # s(k2gram.curr, SUBJ, bs='re') + 
                                # s(k2gram.prev, SUBJ, bs = 're') + 
                                s(k1gram.curr, SUBJ, bs = 're') + 
                                s(k1gram.prev, SUBJ, bs = 're') + 
                                s(SUBJ, bs='re'),
                              data=dat.no.punct)
summary(gam.acl.trigram.nobigramME.nobigramRE.fitted)

gam.acl.trigram.nobigramME.yesbigramRE.fitted <- bam(FPASSD ~ 
                                ct(k3gram.curr) +
                                ct(k3gram.prev) +
                                s(interp.curr, bs='cr', k=40) +
                                s(interp.prev, bs='cr', k=40) +
                                te(k1gram.curr, log(WLEN), bs='tp') +
                                te(k1gram.prev, log(wlen.prev), bs='tp') +
                                # s(k2gram.curr, bs='cr') +
                                # s(k2gram.prev, bs='cr') +
                                PREVFIX + 
                                s(log(WNUM), bs = 'cr') +
                                s(k3gram.curr, SUBJ, bs='re') + 
                                s(k3gram.prev, SUBJ, bs = 're') +
                                s(k2gram.curr, SUBJ, bs='re') +
                                s(k2gram.prev, SUBJ, bs = 're') +
                                s(k1gram.curr, SUBJ, bs = 're') + 
                                s(k1gram.prev, SUBJ, bs = 're') + 
                                s(SUBJ, bs='re'),
                              data=dat.no.punct)
summary(gam.acl.trigram.nobigramME.yesbigramRE.fitted)

gam.acl.trigram.nobigramME.nobigramRE.balanced <- bam(FPASSD ~ 
                                ct(k3gram.curr) +
                                ct(k3gram.prev) +
                                s(interp.balanced.curr, bs='cr', k=40) +
                                s(interp.balanced.prev, bs='cr', k=40) +
                                te(k1gram.curr, log(WLEN), bs='tp') +
                                te(k1gram.prev, log(wlen.prev), bs='tp') +
                                # s(k2gram.curr, bs='cr') +
                                # s(k2gram.prev, bs='cr') +
                                PREVFIX + 
                                s(log(WNUM), bs = 'cr') +
                                s(k3gram.curr, SUBJ, bs='re') + 
                                s(k3gram.prev, SUBJ, bs = 're') +
                                # s(k2gram.curr, SUBJ, bs='re') + 
                                # s(k2gram.prev, SUBJ, bs = 're') + 
                                s(k1gram.curr, SUBJ, bs = 're') + 
                                s(k1gram.prev, SUBJ, bs = 're') + 
                                s(SUBJ, bs='re'),
                              data=dat.no.punct)
summary(gam.acl.trigram.nobigramME.nobigramRE.balanced)

gam.acl.trigram.nobigramME.yesbigramRE.balanced <- bam(FPASSD ~ 
                               ct(k3gram.curr) +
                               ct(k3gram.prev) +
                               s(interp.balanced.curr, bs='cr', k=40) +
                               s(interp.balanced.prev, bs='cr', k=40) +
                               te(k1gram.curr, log(WLEN), bs='tp') +
                               te(k1gram.prev, log(wlen.prev), bs='tp') +
                               # s(k2gram.curr, bs='cr') +
                               # s(k2gram.prev, bs='cr') +
                               PREVFIX + 
                               s(log(WNUM), bs = 'cr') +
                               s(k3gram.curr, SUBJ, bs='re') + 
                               s(k3gram.prev, SUBJ, bs = 're') +
                               s(k2gram.curr, SUBJ, bs='re') +
                               s(k2gram.prev, SUBJ, bs = 're') +
                               s(k1gram.curr, SUBJ, bs = 're') + 
                               s(k1gram.prev, SUBJ, bs = 're') + 
                               s(SUBJ, bs='re'),
                             data=dat.no.punct)
summary(gam.acl.trigram.nobigramME.yesbigramRE.balanced)
