##############################
## Intro to R demonstration ##
## for Stats 1 Fall 2016    ##
##       Bonus Code         ##
##############################

# Loops ============================================================
# For loops do something a set number of times
x <- 1:5
for (i in 1:10){ # do something 10 times, call the iteration i
  x <- x + 1 # reassign x adding 1 to each element
  print(x) # print the result --- loops only return something if you tell them to!
}

# Useful R package of the week - dplyr =============================
# dply is for data manipulation 
library(dplyr)
names(mtcars) # what are the names of the vars in mtcars
table(mtcars$cyl) # 4, 6, and 8 cyls

# What is the average mpg for each level of cyl?
mtcars %>% # mtcars 'then'
  group_by(cyl) %>% # group by this var, "then"
  summarize(meanmpg = mean(mpg)) # summarize, returning mean mpg

# What if we don't want cars over 4 tons?
# e.g. we need to subset by row
mtcars %>% 
  filter(wt < 4) %>% # select only rows where wt < 4
  group_by(cyl) %>% 
  summarize(meanmpg = mean(mpg))

# We can also subset by column:
head(mtcars) # just a reminder of what it looks like before
mtcars %>% 
  select(mpg, cyl, wt) %>% # select only the mpg, cyl, and wt columns
  head()

# We can make new vars with "mutate": 
mtcars <- mtcars %>% 
  mutate(mpg_per_cyl = mpg/cyl) # create a new column called mpg_per_cyl that is equal to mpg/cyl

mean(mtcars$mpg_per_cyl)

# dplyr has a lot of other useful functions 
# check them out in documentation
# cheatsheet available on rstudio's website 


# Linear Regression ================================================
# running a linear regression of y on x
reg1 <- lm(y ~ x ) 
reg1 # print estimates from regression
summary(reg1) # full report on regression

# a second regression
library(car)
plot(Duncan$income, Duncan$prestige)

duncan.model <- lm(prestige ~ income, data=Duncan)
summary(duncan.model)
abline(duncan.model, col="orange", lwd=3, lty=4)