##############################
## Intro to R demonstration ##
## for Stats 1 Fall 2016    ##
##############################

# Useful Shortcuts ==================================================
# <- is alt+- on Win or ctl+- on Mac
# Run a line with ctl+enter on Win or command+return on Mac
# tab will help with context-dependent autocomplete
# note that in Rstudio you can see all keyboard shortcuts 
# Windows and Linux: alt+shift+K
# Mac: option+shift+K


# Basic operations ==================================================
1 + 1
3 * 2
9 ^ .5
23.257 + 52 / (345 ^ 5)

# Functions in R ====================================================
sqrt(9) # square root
exp(3)  # raise e to some power
log(11)

# Getting Help ======================================================
args(log) # seeing what arguments (options) the log function has
?log # seeing a more extensive manual entry for a function
# ...or try google or rseek.org

# So if we want base 10, we could do:
log(11, base=10)
log10(11)

# Types of Data and Storing Data ====================================
# Pretty much everything in R is an object
# Objects have names
# R uses <- to assign names to objects

# Numbers
3.2
class(3.2)

# Characters
"Welcome to Stats!"
class("Welcome to Stats")

# Logical
TRUE
class(TRUE)

# Factor (they're like labeled categories)
my_factor <- factor(c("green", "yellow", "blue"))
my_factor
class(my_factor)

# Coercing one class to another
# use as.x to coerce one class into another
as.numeric(my_factor)
as.character(my_factor)

# vectors
c(1, 2, 3) #one way to make a vector of the numbers 1, 2, and 3
1:3 # another way
seq(from = 1, to = 3, by = 1) # and a third way!
seq(1, 3, by = 0.5) # seq() can be used with other step values
seq(1, 3, length.out = 22) # seq() can also create a sequence with a given output length
c(9, 11, -2) 

# storing vectors
x <- c(1, 2, 3) # define a vector called x
x # print x in the console
print(x) # another way to print values
x2 <- c(6, 2, 7) # creating another x2
x + 1  # doing arithmetic with x
x <- x + 1

# matrices
# matrices can have only one type of data in them
my_matrix <- matrix(1:10, ncol = 2)
my_matrix

# dataframes
# like a matrix but can have multiple types of data
my_df <- data.frame(num = c(1:3, 9.234), char = c("a", "b", "c", "hooray for dataframes"), logical = c(T, F, T, T), factor = factor(c("methods", "methods", "comparative", "theory")))
my_df

# Visualizing Data ==================================================
# visualizing datasets
mtcars <- mtcars #mtcars is a built-in dataset, but we'll assign it to an object with the same name to avoid confusion
mtcars # a lot of times this is too much for the console
View(mtcars) # RStudio's viewer is pretty terrible
str(mtcars) # look at the structure of the data
names(mtcars) # get the names of the varibles in the dataframe
head(mtcars) # print the first 6 lines

# plotting
plot(x, x2)  # scatterplot of x vs x2
abline(0, 1) # add line to plot with intercept 0, slope 1
abline(2, 2, col = "green", lwd = 5, lty = "dashed") # add a green dashed line to plot with intercept 2, slope 2, and width 5


# Packages =========================================================
# R has a lot of functionality built-in, but you can extend that with packages
# Packages are basically collections of functions, documentation on those functions, and often some sample data
# Install packages using install.packages("package_name")
# You must load packages in each session before you can use them
# Load a package using library()

library(car) 
names(Duncan)
head(Duncan)
income
Duncan$income

plot(Duncan$income, Duncan$prestige)


# Syntax ==========================================================
# There are some good practices for writing your R code to make it easier to follow
# 1. Always comment your work!
# 2. Use meaningful names
# 3. Use spaces after commas and around the following symbols: = + - / * ^  <- %>% 
# 4. () for order of operations and functions, [ ], for indexing, {} for loops
# http://adv-r.had.co.nz/Style.html has a more complete set of recommendations