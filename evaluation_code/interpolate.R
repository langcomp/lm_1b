library(tidyverse)
library(cowplot)

### functions

perplexity <- function(x) {
  pplx <- 10 ** (-1. * ((sum(x, na.rm=TRUE) / 
                           length(!is.na(x)))))
  return(pplx)
}

log10sumexp <- function(a, b) {
  # modeled on scipy.misc.logsumexp
  # https://docs.scipy.org/doc/scipy-0.14.0/reference/generated/scipy.misc.logsumexp.html
  # see there for argument meaning
  a_max <- max(a)
  log10(sum(b * 10^(a - a_max))) + a_max
}

interpolate <- function(lp1, lp2, b) {
  # interpolates two log probabilities with mixing weight b
  log10sumexp(c(lp1, lp2), c(b, 1-b))
}

#### blending

interpolate.blend.pplx <- function(all.models, model1, model2) {
  perplexity_val = c()
  interp.seq <- seq(from=0.91, to=0.93, by=0.001)

  for (i in seq_along(interp.seq)) {
    word.surprisal <- all.models %>%
      mutate(newlogprob = interpolate(all.models[[model1]], all.models[[model2]],
                                      interp.seq[[i]]))
      # ungroup()
    perplexity_val[i] <- perplexity(word.surprisal$newlogprob)
  }
  return(perplexity_val)
}

perplexity_val = c()
interp.seq <- seq(from=0.91, to=0.93, by=0.001)

for (i in seq_along(interp.seq)) {
  word.surprisal <- word.surprisal %>%
    rowwise() %>%
    mutate(newlogprob = interpolate(interp.curr, k3gram.curr, interp.seq[[i]])) %>%
    ungroup()
  perplexity_val[i] <- perplexity(word.surprisal$newlogprob)  
}

(pplx.df <- data.frame(interp.seq, perplexity_val))

test <- interpolate.blend.pplx(word.surprisal, "interp.curr", "k3gram.curr")

fitted.curr.unigram.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.curr.pplx <- plot(fitted.curr.unigram.pplx.values, main="",
                         xlab="Surprisal Model Proportion",
                         ylab="Perplexity")

balanced.curr.unigram.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.curr.pplx <- plot(balanced.curr.unigram.pplx.values, main="",
                         xlab="Surprisal Model Proportion",
                         ylab="Perplexity")


fitted.curr.bigram.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.curr.bigram.pplx <- plot(fitted.curr.bigram.pplx.values, main="Fitted vs Current Bigram",
                  xlab="Surprisal Model Proportion",
                  ylab="Perplexity")

fitted.prev.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.prev.pplx <- plot(fitted.prev.pplx.values, main="Fitted vs Previous Bigram",
                         xlab="Surprisal Model Proportion",
                         ylab="Perplexity")

balanced.curr.bigram.pplx.values <- data.frame(interp.seq, perplexity_val)
balanced.curr.bigram.pplx <- plot(balanced.curr.pplx.values, main="Balanced vs Current Bigram",
                         xlab="Surprisal Model Proportion",
                         ylab="Perplexity")

balanced.prev.pplx.values <- data.frame(interp.seq, perplexity_val)
balanced.prev.pplx <- plot(balanced.prev.pplx.values, main="Balanced vs Previous Bigram",
                           xlab="Surprisal Model Proportion",
                           ylab="Perplexity")

fitted.curr.trigram.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.curr.trigram <- plot(fitted.curr.trigram.pplx.values, 
                           main="Fitted vs Current Trigram",
                           xlab="Surprisal Model Proportion",
                           ylab="Perplexity")

fitted.prev.trigram.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.prev.trigram <- plot(fitted.prev.trigram.pplx.values, 
                            main="Fitted vs Previous Trigram",
                            xlab="Surprisal Model Proportion",
                            ylab="Perplexity")

balanced.curr.trigram.pplx.values <- data.frame(interp.seq, perplexity_val)
balanced.curr.trigram <- plot(balanced.curr.trigram.pplx.values, 
                            main="Balanced vs Current Trigram",
                            xlab="Surprisal Model Proportion",
                            ylab="Perplexity")

balanced.prev.trigram.pplx.values <- data.frame(interp.seq, perplexity_val)
balanced.prev.trigram <- plot(balanced.prev.trigram.pplx.values, 
                              main="Balanced vs Previous Trigram",
                              xlab="Surprisal Model Proportion",
                              ylab="Perplexity")

fitted.curr.fourgram.pplx.values <- data.frame(interp.seq, perplexity_val)
fitted.curr.pplx <- plot(fitted.curr.fourgram.pplx.values, main="",
                         xlab="Surprisal Model Proportion",
                         ylab="Perplexity")

########### ggplot #########
fit.curr.plot <- ggplot(fitted.curr.pplx.values, aes(x=interp.seq, y=perplexity_val)) +
  geom_point(shape=1) +
  labs(title="Fitted vs Current Bigram",
       x="Surprisal Model Proportion",
       y="Perplexity")

fit.prev.plot <- ggplot(fitted.prev.pplx.values, aes(x=interp.seq, y=perplexity_val)) +
  geom_point(shape=1) +
  labs(title="Fitted vs Previous Bigram",
       x="Surprisal Model Proportion",
       y="Perplexity")

bal.curr.plot <- ggplot(balanced.curr.pplx.values, aes(x=interp.seq, y=perplexity_val)) +
  geom_point(shape=1) +
  labs(title="Balanced vs Current Bigram",
       x="Surprisal Model Proportion",
       y="Perplexity")

bal.prev.plot <- ggplot(balanced.prev.pplx.values, aes(x=interp.seq, y=perplexity_val)) +
  geom_point(shape=1) +
  labs(title="Balanced vs Previous Bigram",
       x="Surprisal Model Proportion",
       y="Perplexity")



plot_grid(fit.curr.plot, fit.prev.plot, bal.curr.plot, bal.prev.plot,
          ncol=2,
          labels=c("(a)", "(b)"))
 
############## master df
fitted.curr.bigram.pplx.values$Surprisal <- rep("Fitted", 101)
fitted.curr.bigram.pplx.values$`n-gram` <- rep("Bigram", 101)
fitted.prev.pplx.values$Surprisal <- rep("Fitted", 101)
fitted.prev.pplx.values$`n-gram` <- rep("Previous Bigram", 101)

balanced.curr.bigram.pplx.values$Surprisal <- rep("Balanced", 101)
balanced.curr.bigram.pplx.values$`n-gram` <- rep("Bigram", 101)
balanced.prev.pplx.values$Surprisal <- rep("Balanced", 101)
balanced.prev.pplx.values$`n-gram` <- rep("Previous Bigram", 101)

fitted.curr.trigram.pplx.values$Surprisal <- rep("Fitted", 101)
fitted.curr.trigram.pplx.values$`n-gram` <- rep("Trigram", 101)
fitted.prev.trigram.pplx.values$Surprisal <- rep("Fitted", 101)
fitted.prev.trigram.pplx.values$`n-gram` <- rep("Previous Trigram", 101)

balanced.curr.trigram.pplx.values$Surprisal <- rep("Balanced", 101)
balanced.curr.trigram.pplx.values$`n-gram` <- rep("Trigram", 101)
balanced.prev.trigram.pplx.values$Surprisal <- rep("Balanced", 101)
balanced.prev.trigram.pplx.values$`n-gram` <- rep("Previous Trigram", 101)

fitted.curr.unigram.pplx.values$Surprisal <- rep("Fitted", 101)
fitted.curr.unigram.pplx.values$`n-gram` <- rep("Unigram", 101)
balanced.curr.unigram.pplx.values$Surprisal <- rep("Balanced", 101)
balanced.curr.unigram.pplx.values$`n-gram` <- rep("Unigram", 101)


all.pplx.interp <- rbind(fitted.curr.pplx.values,
                         fitted.prev.pplx.values,
                         balanced.curr.pplx.values,
                         balanced.prev.pplx.values,
                         fitted.curr.trigram.pplx.values,
                         fitted.prev.trigram.pplx.values,
                         balanced.curr.trigram.pplx.values,
                         balanced.prev.trigram.pplx.values)

all.pplx.interp.curr <- rbind(fitted.curr.bigram.pplx.values,
                         balanced.curr.bigram.pplx.values,
                         fitted.curr.trigram.pplx.values,
                         balanced.curr.trigram.pplx.values,
                         balanced.curr.unigram.pplx.values,
                         fitted.curr.unigram.pplx.values)

all.pplx.interp.curr$`n-gram` <- factor(all.pplx.interp.curr$`n-gram`,
                                        levels=c("Unigram",
                                                 "Bigram",
                                                 "Trigram"))

# ggplot(all.pplx.interp.curr, aes(x=interp.seq, y=perplexity_val)) +
#          geom_line() +
#         facet_grid(Surprisal ~ `n-gram`) +
#         scale_y_log10() +
#          labs(title="",
#               x="Surprisal Model Proportion",
#               y="Perplexity") +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#   ggsave('cuny-exp1.pdf', device='pdf')

# for CUNY poster
ggplot(subset(all.pplx.interp.curr, Surprisal=="Fitted"), aes(x=interp.seq, y=perplexity_val)) +
  geom_line(aes(color=`n-gram`)) +
  scale_y_log10() +
  scale_x_reverse() +
  labs(title="Interpolating surprisal with n-grams",
       x=expression("Proportion of Surprisal Model ("*gamma*")"),
       y="Perplexity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=12),
        axis.text.y = element_text(hjust = 1, size=12),
        axis.title.x = element_text(size=14,face="bold"),
        axis.title.y = element_text(size=14),
        plot.title = element_text(hjust = 0.5, size=15),
        legend.position = c(0.15, 0.8), 
        legend.background = element_rect(color = "black", 
                                   fill = "grey90", 
                                   size = .2, 
                                   linetype = "solid")) +
  ggsave('cuny-exp1.pdf', device='pdf')

# for EMNLP paper
ggplot(subset(all.pplx.interp.curr, Surprisal=="Fitted"), aes(x=interp.seq, y=perplexity_val)) +
  geom_line(aes(color=`n-gram`)) +
  scale_y_log10() +
  scale_x_reverse() +
  labs(title="", #labs(title="Fitted Model",
       x=expression("Proportion of Surprisal Model ("*gamma*")"),
       y="Perplexity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=12),
        axis.text.y = element_text(hjust = 1, size=12),
        axis.title.x = element_text(size=14,face="bold"),
        axis.title.y = element_text(size=14),
        plot.title = element_text(hjust = 0.5, size=15),
        legend.position = c(0.15, 0.7), 
        legend.background = element_rect(color = "black", 
                                         fill = "grey90", 
                                         size = .2, 
                                         linetype = "solid")) +
  ggsave('cuny-exp1.pdf', device='pdf')

ggplot(subset(all.pplx.interp.curr), aes(x=interp.seq, y=perplexity_val)) +
  geom_line(aes(color=`n-gram`)) +
  scale_y_log10() +
  scale_x_reverse() +
  labs(title="",
       x=expression("Proportion of Surprisal Model ("*gamma*")"),
       y="Perplexity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=12),
        axis.text.y = element_text(hjust = 1, size=12),
        axis.title.x = element_text(size=12,face="bold"),
        axis.title.y = element_text(size=12),
        plot.title = element_text(hjust = 0.5, size=12),
        legend.position = c(0.15, 0.7), 
        legend.background = element_rect(color = "black", 
                                         fill = "grey90", 
                                         size = .2, 
                                         linetype = "solid")) +
  facet_grid(. ~ Surprisal) +
  ggsave('emnlp-exp1.pdf', device='pdf')
