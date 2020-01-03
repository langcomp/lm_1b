perplexity <- function(x) {
  pplx <- 10 ** (-1. * ((sum(x, na.rm=TRUE) / 
                          length(!is.na(x)))))
  return(pplx)
}

perplexity(token.surprisal$interp_logprob)

perplexity(token.surprisal.all$interp_logprob)
perplexity(token.surprisal.all$interp.balanced_logprob)
perplexity(token.surprisal.all$rnn_prob)
perplexity(token.surprisal.all$kenlm5gram_prob)
perplexity(token.surprisal.all$kenlm4gram_prob)
perplexity(token.surprisal.all$kenlm3gram_prob)
perplexity(token.surprisal.all$kenlm2gram_prob)
perplexity(lm_1b.tokens$kenlm1gram.total.prob)

# create token df that includes </s> and excludes OOV
# use initial token list combined with lm.1b tokens
# NAs will be token to token no match
# eliminate tokens with 1gram prob of NA

token.surprisal.all.invocab <- left_join(token.surprisal.all, lm_1b.tokens, by="WORD")
token.surprisal.all.oov <- token.surprisal.all.invocab[is.na(token.surprisal.all.invocab$kenlm1gram.total.prob) , ]
token.surprisal.all.invocab <- token.surprisal.all.invocab[!is.na(token.surprisal.all.invocab$kenlm1gram.total.prob) , ]

perplexity(token.surprisal.all.invocab$interp_logprob)
perplexity(token.surprisal.all.invocab$interp.balanced_logprob)
perplexity(token.surprisal.all.invocab$rnn_prob)
perplexity(token.surprisal.all.invocab$kenlm5gram_prob)
perplexity(token.surprisal.all.invocab$kenlm4gram_prob)
perplexity(token.surprisal.all.invocab$kenlm3gram_prob)
perplexity(token.surprisal.all.invocab$kenlm2gram_prob)

