# Linear Regression in R
# Brendan Apfeld

data("mtcars")
str(mtcars)

# Maybe we have a theory about the relationship between fuel efficiency
# and the weight of the vehicle

# We can take a look at the relationship
plot(mtcars$wt, mtcars$mpg, xlab = "Weight in tons", ylab = "Miles per gallon", main = "Fuel Ecnomy vs Weight")

# But what we really want to do is use math!
# This next line creats an object to store the results of our Linear Model (hence lm)
# You write the model as DV ~ IVs
reg1 <- lm(mpg ~ wt, data = mtcars)

# Let's take a look at the results
summary(reg1)

# Let's add our regression line to the plot
# First argument is the intercept, second argument is the slope
abline(reg1$coefficients[1], reg1$coefficients[2], col = "green", lwd = 2)

# Of course many times we want to "control" for other factors
reg2 <- lm(mpg ~ wt + hp, data = mtcars)
summary(reg2)

# What about binary dependent variables?
# This relies on data from Pippa Norris's Dataset
norris <- rio::import("My Code/Data/norris.dta")
dim(norris)

# Note that this is not a linear relationship
plot(norris$Voice2003, norris$Catholic)

# So we'll need to use a non-linear approach: logit
binary_reg1 <- glm(Catholic ~ Voice2003, family = binomial(link = "logit"), data = norris)
summary(binary_reg1)

# A second model with additional covariates
binary_reg2 <- glm(Catholic ~ Voice2003 + HeadofState + pr76, family = binomial(link = "logit"), data = norris)
summary(binary_reg2)


# Bonus: If you're used to marginal plots in stata, you can now easily make them in R using the margins package
margins::cplot(binary_reg2, what = "prediction")
margins::cplot(binary_reg2, what = "effect")
