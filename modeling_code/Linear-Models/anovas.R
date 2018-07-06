anova(lm.interp.curr.1, lm.interp.plus.rnn.curr.1)
anova(lm.rnn.2, lm.interp.plus.rnn.curr.1)
anova(lm.interp.curr.1, lm.interp.plus.5gram.curr.1)
anova(lm.klm5gram.2, lm.interp.plus.5gram.curr.1)

anova(lm.interp.prev.1, lm.interp.plus.rnn.prev.1)
anova(lm.rnn.3, lm.interp.plus.rnn.prev.1)
anova(lm.interp.prev.1, lm.interp.plus.5gram.prev.1)
anova(lm.klm5gram.3, lm.interp.plus.5gram.prev.1)

########## balanced interpolation

anova(lm.interp.balanced.curr.1, lm.interp.balanced.plus.rnn.curr.1)
anova(lm.rnn.2, lm.interp.balanced.plus.rnn.curr.1)
anova(lm.interp.balanced.curr.1, lm.interp.balanced.plus.5gram.curr.1)
anova(lm.klm5gram.2, lm.interp.balanced.plus.5gram.curr.1)
anova(lm.interp.balanced.curr.1, lm.interp.curr.1)

anova(lm.interp.balanced.prev.1, lm.interp.balanced.plus.rnn.prev.1)
anova(lm.rnn.3, lm.interp.balanced.plus.rnn.prev.1)
anova(lm.interp.balanced.prev.1, lm.interp.balanced.plus.5gram.prev.1)
anova(lm.klm5gram.3, lm.interp.balanced.plus.5gram.prev.1)
anova(lm.interp.balanced.prev.1, lm.interp.prev.1)
