library(mgcv)

set.seed(3)
dat <- gamSim(1,n=25000,dist="normal",scale=20)
bs <- "cr";k <- 12
b <- bam(y ~ s(x0,bs=bs)+s(x1,bs=bs)+s(x2,bs=bs,k=k)+
           s(x3,bs=bs),data=dat)
summary(b)
tidy(b)
glance(b)

s <- summary(gam.rnn.0)
str(s)
s$p.table
s$s.table

plot(gam.rnn.0)

gam.check(gam.rnn.0)
qq.gam(gam.rnn.0, type='pearson')
