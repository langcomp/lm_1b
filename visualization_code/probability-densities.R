library(tidyverse)
library(reshape2)

probabilities.curr <- select(dat.no.punct, rnn.total.prob:interp.balanced.total.prob)
probabilities.curr <- probabilities.curr[ , c(6,7,1,2,3,4,5)] #reorder for perplexity
probabilities.curr <- dplyr::rename(probabilities.curr,
          `Interpolated - Optimal` = interp.total.prob,
         `Interpolated - Balanced` = interp.balanced.total.prob,
         `RNN with LSTMs` = rnn.total.prob,
         `5-gram` = kenlm5gram.total.prob,
         `4-gram` = kenlm4gram.total.prob,
         `3-gram` = kenlm3gram.total.prob,
         `2-gram` = kenlm2gram.total.prob)
probabilities.curr.melt <- melt(probabilities.curr)

probabilities.curr.melt <- probabilities.curr.melt %>%
  group_by(variable) %>%
  mutate(mean.value = mean(value),
         median.value = median(value)) %>%
  ungroup()

ggplot(probabilities.curr.melt, aes(value)) +
  geom_density() + coord_cartesian(xlim = c(-6,0)) +
  labs(x = "Surprisal") +
  facet_wrap(~variable, ncol=2) +
  theme_minimal() +
  theme(panel.spacing=unit(0.1, 'lines')) +
  geom_vline(aes(xintercept=mean.value), colour='blue') +
  geom_vline(aes(xintercept=median.value), colour='red')

probabilities.prev <- select(dat.no.punct, rnn.prev:interp.balanced.prev, -k1gram.prev)
probabilities.prev <- probabilities.prev[ , c(6,7,1,2,3,4,5)]

probabilities.prev <- dplyr::rename(probabilities.prev,
        `Interpolated - Optimal` = interp.prev,
        `Interpolated - Balanced` = interp.balanced.prev,
        `RNN with LSTMs` = rnn.prev,
        `5-gram` = k5gram.prev,
        `4-gram` = k4gram.prev,
        `3-gram` = k3gram.prev,
        `2-gram` = k2gram.prev)
probabilities.prev.melt <- melt(probabilities.prev)

probabilities.prev.melt <- probabilities.prev.melt %>%
  group_by(variable) %>%
  mutate(mean.value = mean(value),
         median.value = median(value)) %>%
  ungroup()

ggplot(probabilities.prev.melt, aes(value)) +
  geom_density() + coord_cartesian(xlim = c(-6,0)) +
  labs(x = "Surprisal") +
  facet_wrap(~variable, ncol=2) +
  theme_minimal() +
  theme(panel.spacing=unit(0, 'lines')) +
  geom_vline(aes(xintercept=mean.value), colour='blue') +
  geom_vline(aes(xintercept=median.value), colour='red')

#######################
std <- function(x) sd(x)/sqrt(length(x))
apply(probabilities.curr, 2, std)

