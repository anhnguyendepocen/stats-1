## Session 5

## Remember what a normal PDF and CDF look like
par(mfrow = c(2,1)) # this sets the graphical parameters, specifically we want multiple plots arranged with 2 rows and 1 column
curve(dnorm(x), xlim = c(-5,5), lwd = 2, xlab = "x", ylab = "f(x)",
      main = "Standard Normal PDF",bty="n")
abline(v=0, lty = 3, col = "grey", lwd = 2)
curve(pnorm(x), xlim = c(-5,5), lwd = 2, xlab = "x", ylab = "F(x)",
      main = "Standard Normal CDF",bty="n")
abline(v=0, lty = 3, col = "grey", lwd = 2)
abline(h=.5, lty = 3, col = "grey", lwd = 2)

# Loops ============================================================
# For loops do something a set number of times
short_vec <- 1:10
new_vec <- c()
for (i in 1:10){ # do something 10 times, call the iteration i
  new_vec[i] <- short_vec[i] + 1 # for each element in short_vec, create a corresponding element in new_vec equal to that value + 1
}
cbind(short_vec, new_vec) # look at the two next to each other to see what happened
rm(short_vec, new_vec, i) # remove objects from environment - not necessary, but it'll keep things cleaner


##########################################################
##  MEAN OF INDEPENDENT DRAWS FROM UNIFORM DISTRIBUTION ##
##########################################################

unif.sims1 <- c() # create an empty vector to store the simulations
unif.sims2 <- c()
unif.sims3 <- c()
unif.sims5 <- c()
unif.sims10 <- c()
unif.sims30 <- c()
for(i in 1:10000){
  unif.sims1[i] <- mean(runif(1))
  unif.sims2[i] <- mean(runif(2))
  unif.sims3[i] <- mean(runif(3))
  unif.sims5[i] <- mean(runif(5))
  unif.sims10[i] <- mean(runif(10))
  unif.sims30[i] <- mean(runif(30))
}

# plotting draws and averages
par(mfrow = c(2,3))
# plotting dist of 1 draw from U(0,1)
hist(unif.sims1, freq = FALSE, main = "Mean of 1 Draw from U(0,1)")
# plotting dist of mean of 2 draws from U(0,1)
hist(unif.sims2, freq = FALSE, main = "Mean of 2 Draws from U(0,1)")
# plotting dist of mean of 3 draws from U(0,1)
hist(unif.sims3, freq = FALSE, main = "Mean of 3 Draws from U(0,1)")
# plotting dist of mean of 5 draws from U(0,1)
hist(unif.sims5, freq = FALSE, main = "Mean of 5 Draws from U(0,1)")
# plotting dist of mean of 10 draws from U(0,1)
hist(unif.sims10, freq = FALSE, main = "Mean of 10 Draws from U(0,1)")
# plotting dist of mean of 30 draws from U(0,1)
hist(unif.sims30, freq = FALSE, main = "Mean of 30 Draws from U(0,1)")
#dev.off()

# what are the expected value and variance of the distribution of
# the mean of 30 independent draws from a U(0,1) distribution?

curve(dnorm(x, mean = , sd = ), col = "green", add = TRUE, lwd = 2)



# now using Bernoulli(.5) dist
# (which is very non-normal)

bern.sims1 <- c()
bern.sims2 <- c()
bern.sims3 <- c()
bern.sims5 <- c()
bern.sims10 <- c()
bern.sims30 <- c()
for(i in 1:10000){
  bern.sims1[i] <- mean(rbinom(1, size=1, prob=.5))
  bern.sims2[i] <- mean(rbinom(2, size=1, prob=.5))
  bern.sims3[i] <- mean(rbinom(3, size=1, prob=.5))
  bern.sims5[i] <- mean(rbinom(5, size=1, prob=.5))
  bern.sims10[i] <- mean(rbinom(10, size=1, prob=.5))
  bern.sims30[i] <- mean(rbinom(30, size=1, prob=.5))
}

# plotting draws and averages
par(mfrow = c(2,3))
# plotting dist of 1 draw from Bern(.5)
hist(bern.sims1, freq = FALSE, main = "Mean of 1 Draw from Bern(.5)")
# plotting dist of mean of 2 draws from Bern(.5)
hist(bern.sims2, freq = FALSE, main = "Mean of 2 Draws from Bern(.5)")
# plotting dist of mean of 3 draws from Bern(.5)
hist(bern.sims3, freq = FALSE, main = "Mean of 3 Draws from Bern(.5)")
# plotting dist of mean of 5 draws from Bern(.5)
hist(bern.sims5, freq = FALSE, main = "Mean of 5 Draws from Bern(.5)")
# plotting dist of mean of 10 draws from Bern(.5)
hist(bern.sims10, freq = FALSE, main = "Mean of 10 Draws from Bern(.5)")
# plotting dist of mean of 30 draws from Bern(.5)
hist(bern.sims30, freq = FALSE, main = "Mean of 30 Draws from Bern(.5)",
     breaks=((0:30)+.5)/30)
#dev.off()
# what are mean and sd of average of 30 Bern(.5)s?
curve(dnorm(x, mean= , sd= , add=TRUE, col="green", lwd = 2)




# a really hard case: Bernoulli(.01)

bern.sims1 <- c()
bern.sims2 <- c()
bern.sims3 <- c()
bern.sims5 <- c()
bern.sims10 <- c()
bern.sims30 <- c()
for(i in 1:10000){
  bern.sims1[i] <- mean(rbinom(1, size=1, prob=.01))
  bern.sims2[i] <- mean(rbinom(2, size=1, prob=.01))
  bern.sims3[i] <- mean(rbinom(3, size=1, prob=.01))
  bern.sims5[i] <- mean(rbinom(5, size=1, prob=.01))
  bern.sims10[i] <- mean(rbinom(10, size=1, prob=.01))
  bern.sims30[i] <- mean(rbinom(30, size=1, prob=.01))
}

# plotting draws and averages
par(mfrow = c(2,3))
# plotting dist of 1 draw from Bern(.5)
hist(bern.sims1, freq = FALSE, main = "Mean of 1 Draw from Bern(.01)")
# plotting dist of mean of 2 draws from Bern(.5)
hist(bern.sims2, freq = FALSE, main = "Mean of 2 Draws from Bern(.01)")
# plotting dist of mean of 3 draws from Bern(.5)
hist(bern.sims3, freq = FALSE, main = "Mean of 3 Draws from Bern(.01)")
# plotting dist of mean of 5 draws from Bern(.5)
hist(bern.sims5, freq = FALSE, main = "Mean of 5 Draws from Bern(.01)")
# plotting dist of mean of 10 draws from Bern(.5)
hist(bern.sims10, freq = FALSE, main = "Mean of 10 Draws from Bern(.01)")
# plotting dist of mean of 30 draws from Bern(.5)
hist(bern.sims30, freq = FALSE, main = "Mean of 30 Draws from Bern(.01)")
#dev.off()

## NOT SO GREAT...

# what about the mean of 1000 Bern(.01) draws?
bern.sims1000 <- c()
for(i in 1:10000){
  bern.sims1000[i] <- mean(rbinom(1000, size=1, prob=.01))
}
dev.off() # getting rid of old plots
hist(bern.sims1000, freq=FALSE, main="Mean of 1000 draws from Bern(.01)")

# what are mean and sd of average of 1000 Bern(.01)s?
curve(dnorm(x, mean= , sd= ), add=TRUE, col="green", lwd = 2)
