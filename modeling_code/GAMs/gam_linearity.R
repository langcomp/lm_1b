# 
# gam.test.plot <- plot(gam.rnn.0)
# 
# gam.test.x <- gam.test.plot[[1]]$x
# gam.test.y <- gam.test.plot[[1]]$fit
# 
# gam.lm.test <- lm(gam.test.y ~ gam.test.x)
# summary(gam.lm.test)
# 
# klm2.plot <- plot(gam.kenlm2gram.0)
# klm2.lm <- lm(klm2.plot[[1]]$fit ~ klm2.plot[[1]]$x)
# summary(klm2.lm)
# 
# summary(gam.rnn.0)

gam.interp.prev.plot <- plot(gam.interp.prev)
gam.interp.balanced.prev.plot <- plot(gam.interp.balanced.prev)
gam.rnn.1.plot <- plot(gam.rnn.1)
gam.klm5gram.1.plot <- plot(gam.klm5gram.1)
gam.klm4gram.1.plot <- plot(gam.klm4gram.1)
gam.klm3gram.1.plot <- plot(gam.klm3gram.1)
gam.klm2gram.1.plot <- plot(gam.klm2gram.1)


gam.interp.prev.lm <- lm(gam.interp.prev.plot[[1]]$fit ~ gam.interp.prev.plot[[1]]$x)
gam.interp.balanced.prev.lm <- lm(gam.interp.balanced.prev.plot[[1]]$fit ~ gam.interp.balanced.prev.plot[[1]]$x)
gam.rnn.1.lm <- lm(gam.rnn.1.plot[[1]]$fit ~ gam.rnn.1.plot[[1]]$x)
gam.klm5gram.1.lm <- lm(gam.klm5gram.1.plot[[1]]$fit ~ gam.klm5gram.1.plot[[1]]$x)
gam.klm4gram.1.lm <- lm(gam.klm4gram.1.plot[[1]]$fit ~ gam.klm4gram.1.plot[[1]]$x)
gam.klm3gram.1.lm <- lm(gam.klm3gram.1.plot[[1]]$fit ~ gam.klm3gram.1.plot[[1]]$x)
gam.klm2gram.1.lm <- lm(gam.klm2gram.1.plot[[1]]$fit ~ gam.klm2gram.1.plot[[1]]$x)

gam.interp.prev.prev.lm <- lm(gam.interp.prev.plot[[2]]$fit ~ gam.interp.prev.plot[[2]]$x)
gam.interp.balanced.prev.prev.lm <- lm(gam.interp.balanced.prev.plot[[2]]$fit ~ gam.interp.balanced.prev.plot[[2]]$x)
gam.rnn.1.prev.lm <- lm(gam.rnn.1.plot[[2]]$fit ~ gam.rnn.1.plot[[2]]$x)
gam.klm5gram.1.prev.lm <- lm(gam.klm5gram.1.plot[[2]]$fit ~ gam.klm5gram.1.plot[[2]]$x)
gam.klm4gram.1.prev.lm <- lm(gam.klm4gram.1.plot[[2]]$fit ~ gam.klm4gram.1.plot[[2]]$x)
gam.klm3gram.1.prev.lm <- lm(gam.klm3gram.1.plot[[2]]$fit ~ gam.klm3gram.1.plot[[2]]$x)
gam.klm2gram.1.prev.lm <- lm(gam.klm2gram.1.plot[[2]]$fit ~ gam.klm2gram.1.plot[[2]]$x)


summary(gam.interp.prev.lm)$r.squared
summary(gam.interp.balanced.prev.lm)$r.squared
summary(gam.rnn.1.lm)$r.squared
summary(gam.klm5gram.1.lm)$r.squared
summary(gam.klm4gram.1.lm)$r.squared
summary(gam.klm3gram.1.lm)$r.squared
summary(gam.klm2gram.1.lm)$r.squared

summary(gam.interp.prev.prev.lm)$r.squared
summary(gam.interp.balanced.prev.prev.lm)$r.squared
summary(gam.rnn.1.prev.lm)$r.squared
summary(gam.klm5gram.1.prev.lm)$r.squared
summary(gam.klm4gram.1.prev.lm)$r.squared
summary(gam.klm3gram.1.prev.lm)$r.squared
summary(gam.klm2gram.1.prev.lm)$r.squared
