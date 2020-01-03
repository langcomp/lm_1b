library(tidyverse)

# functions for performing multiplicative interpolation
perplexity <- function(x) {
  pplx <- 10 ** (-1. * ((sum(x, na.rm=TRUE) / 
                           length(!is.na(x)))))
  return(pplx)
}

mult_interpolate <- function(lp1, lp2, b) {
  b * lp1 + (1-b) * lp2
}

## get 'improper' perplexity

perplexity_val = c()
interp.seq <- seq(from=0.92, to=0.939, by=0.001)

for (i in seq_along(interp.seq)) {
  word.surprisal <- word.surprisal %>%
    rowwise() %>%
    mutate(newlogprob = mult_interpolate(interp.curr, 
                                         k2gram.curr, interp.seq[[i]])) %>%
    ungroup()
  perplexity_val[i] <- perplexity(word.surprisal$newlogprob)  
}
(pplx.df <- data.frame(interp.seq, perplexity_val))

# load mean logsumexp from tokens for dundee corpus
# logprobs_Z <- read_csv('proprietary_processed_files/logsumexp_mean_by_surprisal_weight.csv')

# multiply 'improper' perplexities x exp(logprob)
mult_perplexity <- logprob_weight_means %>%
  mutate(pplx = perplexity_val * exp(logprob_weight_means$mean_sum))

mult_perplexity

ggplot(mult_perplexity, aes(x=weight, y=pplx)) +
  geom_point()

# add new data to logprob_Z
logprob_base <- read_csv('proprietary_processed_files/logprob-700tokens-20weights.csv')

logprob_means <- logprob_base %>%
  group_by(lstm_weight) %>%
  (logsumexp_mean = mean(mult_logprob, na.rm=TRUE))

# get df of whole column of logprobs
df_list <- list()
for (i in seq_along(interp.seq)) {
  word.surprisal <- word.surprisal %>%
    rowwise() %>%
    mutate(newlogprob = mult_interpolate(interp.curr, 
                                         k2gram.curr, interp.seq[[i]])) %>%
    ungroup()
  df_list[[i]] <- word.surprisal %>% 
    mutate(w = interp.seq[[i]]) %>% 
    select(newlogprob, word_id, w)
  # perplexity_val[i] <- perplexity(word.surprisal$newlogprob)  
}
df_unlist <- bind_rows(df_list)
write_csv(df_unlist, 'df_unlist.csv')
