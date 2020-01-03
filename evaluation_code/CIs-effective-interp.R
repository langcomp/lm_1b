library(MASS)

# compute a 95% confidence interval on the effective interpolation weight
# coef1 - estimated values of ngram coefficient
# sd1 - SD of ngram coefficient
# coef2 - surprisal coefficient
# sd2 - SD of surprisal coefficient
# corr - correlation coefficient between ngram and surprisal coefficients
sample_ratios <- function(coef1, sd1, coef2, sd2, corr, n=1e6) {
  # print(c(coef1, sd1, coef2, sd2, corr, n))
  corr_matrix <- matrix(c(1,corr,corr,1), nrow=2)
  sd_vector <- c(sd1,sd2)
  sd_matrix <- diag(sd_vector)
  cov_matrix <- sd_matrix %*% corr_matrix %*% sd_matrix
  coef_samples <- mvrnorm(n, c(coef1, coef2), cov_matrix)
  samples1 <- coef_samples[, 1]
  samples2 <- coef_samples[, 2]
  ratios <- samples1/(samples1+samples2)
  # interval95 <- quantile(ratios, c(0.025, 0.975))
  # interval99 <- quantile(ratios, c(0.005, 0.995))
  interval975 <- quantile(ratios, c(0.0125, 0.9875))
  return(interval975)
}

# coef1 <- -1.49	# ct(k2gram.curr)
# sd1 <- 0.67
# coef2 <- -2.3 	# ct(interp.curr)
# sd2 <- 0.31
# corr <- -0.07609866
# sample_ratios(-1.49, 0.67, -2.3, 0.31, -0.076)

get_ci_params <- function(model.name, coef1.name, coef2.name) {
  coef1 <- coef(summary(model.name))[coef1.name,1]
  sd1 <- (coef(summary(model.name))[coef1.name,2])
  coef2 <- coef(summary(model.name))[coef2.name,1]
  sd2 <- (coef(summary(model.name))[coef2.name,2])
  corr <- vcov(model.name)[coef1.name, coef2.name]
  # print(c(coef1, sd1, coef2, sd2, corr))
  print(sample_ratios(coef1, sd1, coef2, sd2, corr))
  # return(list(coef1, sd1, coef2, sd2, corr))
}

# current ngram
uni.surp.CIs <- get_ci_params(lm.unigram.iter.ACL2020,
                                 'ct(k1gram.curr)',
                                 'ct(interp.curr)')
bi.surp.CIs <- get_ci_params(lm.bigram.iter.ACL2020, 
                                'ct(k2gram.curr)', 
                                'ct(interp.curr)')
tri.surp.CIs <- get_ci_params(lm.trigram.nobigram.iter.ACL2020, 
                                'ct(k3gram.curr)', 
                                'ct(interp.curr)')

tri.noprev.surp.CIs <- get_ci_params(lm.trigram.nobigram.iter.ACL2020.noprev, 
                              'ct(k3gram.curr)', 
                              'ct(interp.curr)')

do.call(sample_ratios, uni.surp.params)
do.call(sample_ratios, bi.surp.params)
do.call(sample_ratios, tri.surp.params)

# previous ngram
uni.prev.surp.params <- get_ci_params(lm.unigram.iter.ACL2020,
                                 'ct(k1gram.prev)',
                                 'ct(interp.prev)')
bi.prev.surp.params <- get_ci_params(lm.bigram.iter.ACL2020, 
                                'ct(k2gram.prev)', 
                                'ct(interp.prev)')
tri.prev.surp.params <- get_ci_params(lm.trigram.nobigram.iter.ACL2020, 
                                 'ct(k3gram.prev)', 
                                 'ct(interp.prev)')

do.call(sample_ratios, uni.prev.surp.params)
do.call(sample_ratios, bi.prev.surp.params)
do.call(sample_ratios, tri.prev.surp.params)
