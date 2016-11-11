## Code for Discussion Section 11/11/16


#################################################
## Simulating Estimates of the Mean of a Normal
## and 95% confidence intervals

# true model is iid N(5,3)
# (we don't know the mean, only var=3)
# we observe 100 data points

# setting values of true mu, sigma2, n
mu.true <- 5
sigma2.true <- 3
n <- 100

# setting up vector to store simulated mean estimates
xbar <- c()
# setting up matrix to store simulated 95% CIs
CI.95 <- matrix(NA, nrow = 10000, ncol = 2)

# running loop to estimate these things
for (i in 1:10000){
  simulated.data <- rnorm(n, mean=mu.true, sd=sqrt(sigma2.true))
  xbar[i] <- mean(simulated.data)
  CI.95[i, ] <- c(mean(simulated.data) - 1.96 * sqrt(3 / 100),
                  mean(simulated.data) + 1.96 * sqrt(3 / 100))
}

# what is the sampling distribution for xbar?
# (work this out before looking at the sims)
mean(xbar)
var(xbar)
sd(xbar)

# plotting histogram of simulated xbars
hist(xbar, freq=FALSE)
# overlaying curve of true sampling distribution for xbar
curve(dnorm(x, mean = mu.true, sd = sqrt(sigma2.true / n)), add=TRUE)

# creating a variable that says whether each
# CI contains true mu
mu_in_ci <- CI.95[ , 1] < mu.true & CI.95[ , 2] > mu.true

# plotting the first 100 CIs 
# and whether they conatin mu
plot(-99,xlim=c(4,6), ylim=c(0,100), bty="n",
     xlab="mu", ylab="sample", yaxt="n")
for (i in 1:100){
  segments(CI.95[i, 1], i, CI.95[i, 2], i,
           col=ifelse(mu_in_ci[i], "green", "red"))
  points(xbar[i], i, pch=19, cex=.2)
}
abline(v=mu.true, lty=3)

# calculating how many of the 95% CIs
# contain the true mean of 5
table(mu_in_ci)
mean(mu_in_ci)



## comparing estimates of sigma2
## using s^2 (which divides by n-1) and MLE (which divides by n)

# setting values of true mu, sigma2, n
mu.true <- 5
sigma2.true <- 3
n <- 5

# setting up vectors to hold simulated values
s2 <- c()
s.mle <- c()

# running loop to simulate
for (i in 1:10000){
  simulated.data <- rnorm(n, mean=mu.true, sd=sqrt(sigma2.true))
  s2[i] <- sum((simulated.data - mean(simulated.data))^2)/ (n-1)
  s.mle[i] <- sum((simulated.data - mean(simulated.data))^2)/ n
}

par(mfrow=c(2,1))
hist(s2, xlim=c(0,15), breaks=seq(0,25,length=100))
abline(v=sigma2.true, col="green")
abline(v=mean(s2), lty=2)
hist(s.mle, xlim=c(0,15), breaks=seq(0,25,length=100))
abline(v=sigma2.true, col="green")
abline(v=mean(s.mle), lty=2)
legend(9,800, c("true value", "average estimate"), 
       lty=c(1,2), col=c("green", "black"), cex=.6)

# do they appear unbiased?
mean(s2)
mean(s.mle)

# which has lower variance?
var(s2)
var(s.mle)

# comparing mean squared error (MSE) for two estimators
mean((s2 - sigma2.true)^2)
mean((s.mle - sigma2.true)^2)

# NOTE: MSE = Variance + Bias^2
# (not exact here b/c of simulation error)
var(s2) + (mean(s2) - sigma2.true)^2
var(s.mle) + (mean(s.mle) - sigma2.true)^2
