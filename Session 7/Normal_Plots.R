##############################
##       Basic Plots        ##
##############################

# Graphing some normal distributions
x_vec <- seq(-4, 4, length = 500) # create a vector x from -4 to 4 that we'll input into our function

plot(x = x_vec, y = dnorm(x_vec, mean = 0, sd = 1), type = 'l', lwd = 2) # create a plot where the x values are defined by our x vector and y values are the standard normal pdf values for those x
curve(dnorm(x, mean = 0, sd = 0.5), col = "green", add = TRUE, lwd = 2) # add another normal curve with different parameters; we use curve() not plot() in order to add this new line; note that this is NOT the same x as above
curve(dnorm(x, mean = 0, sd = .1), col = "red", add = T, lwd = 2)

# same thing as above, but here we'll set set the y limit so we can see all three curves
plot(x, dnorm(x, mean = 0, sd = 1), type = 'l', lwd = 2, ylim = c(0, 3.75))
curve(dnorm(x, mean = 0, sd = 0.5), col = "green", add = TRUE, lwd = 2) # note, this is NOT the same x as above
curve(dnorm(x, mean = 0, sd = .1), col = "red", add = T, lwd = 2)

# Another way to solve this problem
library(ggplot2) # the ggplot package makes beautiful graphics
x_data_frame <- data.frame(x_axis_variable = c(-4, 4)) # ggplot only uses data frames, so let's make a really simple one
x_data_frame # take a quick look
ggplot(x_data_frame, aes(x_axis_variable)) + # start the ggplot telling it that our data is the x_data_frame and we want to plot the x_axis_variable as x; note that the line ends in a + 
  stat_function(fun = dnorm) + # add the first layer, a line whose function is dnorm(x_axis_variable, 0, 1); ggplot knows we don't only want the values for -4 and 4, but that we want to plot a line between those two points with that function; again, we end the line with a +
  stat_function(fun = dnorm, args = list(mean = 0, sd = .5), linetype = "dotted", size = 1) + # add the second layer; this one we specify arguments for our function and change the line type and size
  stat_function(fun = dnorm, args = list(mean = 0, sd = .1), color = "red", linetype = "dashed")  # add the third layer; change arguments, line type, and color