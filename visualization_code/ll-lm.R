library(tidyverse)
library(ggrepel)

ll.lm.linear <- read_csv('ll-perplex-linear.csv')
ll.lm.nonlinear <- read_csv('ll-perplex-nonlinear.csv')
lm.linear <- lm(Delta.LogLik~Perplexity, data=ll.lm.linear)
summary(lm.linear)
confint(lm.linear)
lm.nonlinear <- lm(Delta.LogLik~Perplexity, data=ll.lm.nonlinear)
summary(lm.nonlinear)
confint(lm.nonlinear)


ggplot(ll.lm.linear, aes(x=Perplexity, y=Delta.LogLik)) +
  geom_point() +
  # geom_line(size=0.5, alpha=0.4) +
  geom_text_repel(aes(label=Language.Model),
                  force=5, point.padding=unit(1,'lines'),
                  angle=0) +
  geom_smooth(method='lm') +
  labs(y=expression(Delta~LogLik)) +
  scale_x_reverse()

ggplot(ll.lm.nonlinear, aes(x=Perplexity, y=Delta.LogLik)) +
  geom_point() +
  geom_text_repel(aes(label=Language.Model),
                  force=1, point.padding=unit(1,'lines'),
                  hjust=1,
                  direction='y',
                  nudge_y=1.5,
                  nudge_x=1.5,
                  segment.size=0.2) +
  geom_smooth(method='lm') +
  labs(y=expression(Delta~LogLik)) +
  scale_x_reverse()

################## coefficients (linear) ###############
ggplot(ll.lm.linear, aes(Perplexity, Current.Word.Coefficient)) +
  geom_point() +
  geom_text_repel(aes(label=Language.Model),
                  force=1, point.padding=unit(1.5,'lines')) +
  geom_smooth(method='lm', se=FALSE) +
  scale_x_reverse() +
  scale_y_reverse()

ggplot(ll.lm.linear, aes(Perplexity, Previous.Word.Coefficient)) +
  geom_point() + 
  geom_text_repel(aes(label=Language.Model),
                  force=1, point.padding=unit(1.5,'lines')) +
  geom_smooth(method='lm', se=FALSE)+
  scale_x_reverse() +
  scale_y_reverse()

lm.linear.curr.coef <- lm(Current.Word.Coefficient~Perplexity, data=ll.lm.linear)
summary(lm.linear.curr.coef)
confint(lm.linear.curr.coef)
lm.linear.prev.coef <- lm(Previous.Word.Coefficient~Perplexity, data=ll.lm.linear)
summary(lm.linear.prev.coef)
confint(lm.linear.prev.coef)

######## Stdized Coef ##############
ggplot(ll.lm.linear, aes(Perplexity, Standardized.Current.Word.Coefficient)) +
  geom_point() +
  geom_text_repel(aes(label=Language.Model),
                  force=2, point.padding=unit(1.,'lines')) +
  geom_smooth(method='lm', se=FALSE)

ggplot(ll.lm.linear, aes(Perplexity, Standardized.Previous.Word.Coefficient)) +
  geom_point() + 
  geom_text_repel(aes(label=Language.Model),
                  force=2, point.padding=unit(1.,'lines')) +
  geom_smooth(method='lm', se=FALSE)

lm.linear.std.curr.coef <- lm(Standardized.Current.Word.Coefficient~Perplexity, data=ll.lm.linear)
summary(lm.linear.std.curr.coef)
confint(lm.linear.std.curr.coef)
lm.linear.std.prev.coef <- lm(Standardized.Previous.Word.Coefficient~Perplexity, data=ll.lm.linear)
summary(lm.linear.std.prev.coef)
confint(lm.linear.std.prev.coef)

######## F scores (nonlinear) ###########
ggplot(ll.lm.nonlinear, aes(Perplexity, Current.Word.F)) +
  geom_point() +
  geom_text_repel(aes(label=Language.Model),
                  force=2, point.padding=unit(1,'lines')) +
  geom_smooth(method='lm', se=FALSE)

ggplot(ll.lm.nonlinear, aes(Perplexity, Previous.Word.F)) +
  geom_point() + 
  geom_text_repel(aes(label=Language.Model),
                  force=2, point.padding=unit(1,'lines')) +
  geom_smooth(method='lm', se=FALSE)

lm.nonlinear.curr.f <- lm(Current.Word.F~Perplexity, data=ll.lm.nonlinear)
summary(lm.nonlinear.curr.f)
confint(lm.nonlinear.curr.f)
lm.nonlinear.prev.f <- lm(Previous.Word.F~Perplexity, data=ll.lm.nonlinear)
summary(lm.nonlinear.prev.f)
confint(lm.nonlinear.prev.f)
