
############## current word ########################
# par(mfrow=c(4,2), mar=c(1,1,1,1))
m <- matrix(c(1,2,3,4,5,6,7,8), nrow=4, ncol=2, byrow=TRUE)
layout(mat=m)
par(cex = 0.6)
par(oma = c(4, 4, 3, 1)) 
par(mar = c(0, 0, 0, 0)) # make the plots be closer together
par(tcl = -0.25)
par(mgp = c(2, 0.6, 0))

plot(gam.interp.nonlinear.fitteddf, select=1,
     xlim=c(-8,0), ylim=c(-15,35), axes=FALSE)
title("Interpolated - Optimal", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
plot(gam.interp.balanced.nonlinear.fitteddf, select=1,
     xlim=c(-6,0), ylim=c(-15,20), axes=FALSE)
title("Interpolated - Balanced", line=-1)
box()

plot(gam.rnn.nonlinear.fitteddf, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("RNN with LSTM", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
plot(gam.klm5gram.nonlinear.fitteddf, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("5-gram", line=-1)
box()

plot(gam.klm4gram.nonlinear.fitteddf, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("4-gram", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
plot(gam.klm3gram.nonlinear.fitteddf, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("3-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm2gram.nonlinear.fitteddf, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("2-gram", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
axis(1, col='grey40', col.axis = "grey20")
box()

# plot(1, type = "n", axes=FALSE, xlab="", ylab="")
# legend(x='bottom',
#        c('a','b'), lty=c(1,2), lwd=c(1,1))
mtext("Current Word", side = 3, outer = TRUE, cex = 1.0, line = 1., 
      col = "black")
mtext("Log Probability of Current Word (Base 10)", side = 1, outer = TRUE, cex = 0.7, line = 2.2, 
      col = "grey20")
mtext("Eye Gaze Slowdown (ms)", side = 2, outer = TRUE, cex = 0.7, line = 2.2,
      col = "grey20")

############## previous word ########################
# par(mfrow=c(4,2), mar=c(1,1,1,1))
m <- matrix(c(1,2,3,4,5,6,7,8), nrow=4, ncol=2, byrow=TRUE)
layout(mat=m)
par(cex = 0.6)
par(oma = c(4, 4, 3, 1)) 
par(mar = c(0, 0, 0, 0)) # make the plots be closer together
par(tcl = -0.25)
par(mgp = c(2, 0.6, 0))

plot(gam.interp.nonlinear.fitteddf, select=2,
     xlim=c(-8,0), ylim=c(-15,35), axes=FALSE)
title("Interpolated - Optimal", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
plot(gam.interp.balanced.nonlinear.fitteddf, select=2,
     xlim=c(-6,0), ylim=c(-15,20), axes=FALSE)
title("Interpolated - Balanced", line=-1)
box()

plot(gam.rnn.nonlinear.fitteddf, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("RNN with LSTM", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
plot(gam.klm5gram.nonlinear.fitteddf, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("5-gram", line=-1)
box()

plot(gam.klm4gram.nonlinear.fitteddf, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("4-gram", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
plot(gam.klm3gram.nonlinear.fitteddf, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("3-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm2gram.nonlinear.fitteddf, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("2-gram", line=-1)
axis(2, col='grey40', col.axis = "grey20")
box()
axis(1, col='grey40', col.axis = "grey20")
box()

# plot(1, type = "n", axes=FALSE, xlab="", ylab="")
# legend(x='bottom',
#        c('a','b'), lty=c(1,2), lwd=c(1,1))

mtext("Previous Word", side = 3, outer = TRUE, cex = 1.0, line = 1., 
      col = "black")
mtext("Log Probability of Previous Word (Base 10)", side = 1, outer = TRUE, cex = 0.7, line = 2.2, 
      col = "grey20")
mtext("Eye Gaze Slowdown (ms)", side = 2, outer = TRUE, cex = 0.7, line = 2.2,
      col = "grey20")

############## normal est - current word ########################
m <- matrix(c(1,2,3,4,5,6,7,8), nrow=2, ncol=4, byrow=TRUE)
layout(mat=m)
par(cex = 0.6)
par(oma = c(4, 4, 3, 1)) 
par(mar = c(0.5, 0.5, 0.5, 0.5)) # make the plots be closer together
par(tcl = -0.25)
par(mgp = c(2, 0.6, 0))

plot(gam.interp.normal, select=1,
     xlim=c(-8,0), ylim=c(-15,35), axes=FALSE)
title("Interpolated\nOptimal", line=-2.2)
axis(2, col='grey40', col.axis = "grey20")
box()

plot(gam.interp.balanced.normal, select=1,
     xlim=c(-6,0), ylim=c(-15,20), axes=FALSE)
title("Interpolated \n Balanced", line=-2.2)
box()

plot(gam.rnn.normal, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("LSTM", line=-1)
box()

plot(1, type = "n", axes=FALSE, xlab="", ylab="")

plot(gam.klm5gram.normal, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("5-gram", line=-1)
axis(2, col='grey40', col.axis = "grey20")
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm4gram.normal, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("4-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm3gram.normal, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("3-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm2gram.normal, select=1,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("2-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

mtext("Normal Estimation - Current Word", side = 3, outer = TRUE, cex = 1.0, line = 1., 
      col = "black")
mtext("Log Probability of Current Word (Base 10)", side = 1, outer = TRUE, cex = 0.7, line = 2.2, 
      col = "grey20")
mtext("Eye Gaze Slowdown (ms)", side = 2, outer = TRUE, cex = 0.7, line = 2.2,
      col = "grey20")

############## normal est - previous word ########################

m <- matrix(c(1,2,3,4,5,6,7,8), nrow=2, ncol=4, byrow=TRUE)
layout(mat=m)
par(cex = 0.6)
par(oma = c(4, 4, 3, 1)) 
par(mar = c(0.5, 0.5, 0.5, 0.5)) # make the plots be closer together
par(tcl = -0.25)
par(mgp = c(2, 0.6, 0))

plot(gam.interp.normal, select=2,
     xlim=c(-8,0), ylim=c(-15,35), axes=FALSE)
title("Interpolated\nOptimal", line=-2.2)
axis(2, col='grey40', col.axis = "grey20")
box()

plot(gam.interp.balanced.normal, select=2,
     xlim=c(-6,0), ylim=c(-15,20), axes=FALSE)
title("Interpolated \n Balanced", line=-2.2)
box()

plot(gam.rnn.normal, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("LSTM", line=-1)
box()

plot(1, type = "n", axes=FALSE, xlab="", ylab="")

plot(gam.klm5gram.normal, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("5-gram", line=-1)
axis(2, col='grey40', col.axis = "grey20")
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm4gram.normal, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("4-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm3gram.normal, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("3-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

plot(gam.klm2gram.normal, select=2,
     xlim=c(-6,0), ylim=c(-15,35), axes=FALSE)
title("2-gram", line=-1)
axis(1, col='grey40', col.axis = "grey20")
box()

mtext("Normal Estimation - Previous Word", side = 3, outer = TRUE, cex = 1.0, line = 1., 
      col = "black")
mtext("Log Probability of Previous Word (Base 10)", side = 1, outer = TRUE, cex = 0.7, line = 2.2, 
      col = "grey20")
mtext("Eye Gaze Slowdown (ms)", side = 2, outer = TRUE, cex = 0.7, line = 2.2,
      col = "grey20")
