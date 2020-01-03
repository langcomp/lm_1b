corpus_size <- 283396
null_ppl <- 74.47440813
opt_ppl <- 73.19155714
perplexities <- c(null_ppl, opt_ppl)
per_word_logprobs <- -log(perplexities)
total_logprobs <- per_word_logprobs * corpus_size
lrt_stat <- -2 * (total_logprobs[1] - total_logprobs[2])
lrt_stat
