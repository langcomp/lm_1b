library(lme4)

# centering function
ct <- function(x) scale(x, scale=FALSE)


# Test LMER with bigram model controls
# model fails to converge without removing random correlations
lm.bigram.full.model <- lmer(FPASSD ~ 
        ct(interp.curr) + 
        ct(interp.prev) + 
        ct(k1gram.curr)*ct(log(WLEN)) +
        ct(k1gram.prev)*ct(log(wlen.prev)) +
        ct(k2gram.curr) +
        ct(k2gram.prev) +
        PREVFIX + 
        log(WNUM) + 
        (k2gram.curr + k2gram.prev + 
           k1gram.curr + k1gram.prev||SUBJ),
      REML=FALSE,
      data=dat.no.punct)

logLik(lm.bigram.full.model)

### balanced interpolation
lm.balanced.bigram.full.model <- lmer(FPASSD ~ 
       ct(interp.balanced.curr) + 
       ct(interp.balanced.prev) + 
       ct(k1gram.curr)*ct(log(WLEN)) +
       ct(k1gram.prev)*ct(log(wlen.prev)) +
       ct(k2gram.curr) +
       ct(k2gram.prev) +
       PREVFIX + 
       log(WNUM) + 
       (k2gram.curr + k2gram.prev + 
          k1gram.curr + k1gram.prev||SUBJ),
     REML=FALSE,
     data=dat.no.punct)

# overwight 5gram
lm.overweight.bigram.full.model <- lmer(FPASSD ~ 
        ct(interp.overweight.curr) + 
        ct(interp.overweight.prev) + 
        ct(k1gram.curr)*ct(log(WLEN)) +
        ct(k1gram.prev)*ct(log(wlen.prev)) +
        ct(k2gram.curr) +
        ct(k2gram.prev) +
        PREVFIX + 
        log(WNUM) + 
        (k2gram.curr + k2gram.prev + 
           k1gram.curr + k1gram.prev||SUBJ),
      REML=FALSE,
      data=dat.no.punct)

#### for table in CUNY abstract
summary(lm.bigram.full.model)
summary(lm.balanced.bigram.full.model)

drop1(lm.bigram.full.model, scope='ct(k1gram.curr)', test='Chisq')
drop1(lm.bigram.full.model, scope='ct(k2gram.curr)', test='Chisq')
drop1(lm.bigram.full.model, scope='ct(k1gram.prev)', test='Chisq')
drop1(lm.bigram.full.model, scope='ct(k2gram.prev)', test='Chisq')

drop1(lm.balanced.bigram.full.model, scope='ct(k1gram.curr)', test='Chisq')
drop1(lm.balanced.bigram.full.model, scope='ct(k2gram.curr)', test='Chisq')
drop1(lm.balanced.bigram.full.model, scope='ct(k1gram.prev)', test='Chisq')
drop1(lm.balanced.bigram.full.model, scope='ct(k2gram.prev)', test='Chisq')
######################################
summary(lm.overweight.bigram.full.model)

drop1(lm.overweight.bigram.full.model, scope='ct(k1gram.curr)', test='Chisq')
drop1(lm.overweight.bigram.full.model, scope='ct(k2gram.curr)', test='Chisq')
drop1(lm.overweight.bigram.full.model, scope='ct(k1gram.prev)', test='Chisq')
drop1(lm.overweight.bigram.full.model, scope='ct(k2gram.prev)', test='Chisq')
