library(gamm4)

# use same random effect structure as lme4, which can handle random correlations

gam.bigram.rand.correl.slope.k1k2.curr.prev <- gamm4(FPASSD ~ 
                      s(interp.curr, bs='cr', k=40) + 
                      s(interp.prev, bs='cr', k=40) +
                      t2(k1gram.curr, log(WLEN), bs='tp') +
                      t2(k1gram.prev, log(wlen.prev), bs='tp') +
                      ct(k2gram.curr) +
                      ct(k2gram.prev) +
                      PREVFIX + s(log(WNUM), bs = 'cr') + 
                      s(SUBJ, bs='re'),
                    random = ~(1+k2gram.curr+k2gram.prev+k1gram.curr+k1gram.prev|SUBJ),
                    data=dat.no.punct)
summary(gam.bigram.rand.correl.slope.k1k2.curr.prev)
