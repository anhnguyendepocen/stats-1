##############################
##   Getting Data into R    ##
##############################

## Note ##
# The code on this page won't run unless you change the paths for all local files
# Alternatively, it should work if you put the Data folder (from github) into your working directory

# The most useful package I've found is rio, which will handle just about any data you throw at it
# If you don't already have it installed, run the following line (you'll have to uncomment it first)

# install.packages("rio")

# Rio can natively import just about anything you have on disk; it is less friendly toward online sources
rio::import("yourfile.extension")

# we can use the package_name::function() way of calling the import function, but becuase we're going to use it several times in a row, let's just load the package

library(rio)

# Example using data directly from the internet
wunderground <- read.csv("https://www.wunderground.com/history/airport/ZBAA/2013/1/1/DailyHistory.html?format=1") #rio not working for reasons unknown
stata_cars <- import("http://www.stata-press.com/data/r13/auto.dta") # rio works here without any problems...

# Example using .Rdata
save(wunderground, stata_cars, file = "Data/example_rdata_file.Rdata") # let's save our previous two data frames into a single rdata file
rm(list = ls()) # clear all the data we have loaded
load("Data/example_rdata_file.Rdata")

# Example using a stata file
ajr <- import("Data/AcemogluJohnsonRobinson2001.dta")

# Example using a csv
sample_gradebook <- import("Data/gradebook.csv")

############################################################

# Some basic things you might want to do with your data

# Finding the mean and variance

mean(wunderground$TemperatureF) # mean
var(wunderground$TemperatureF) # variance
sd(wunderground$TemperatureF) # standard deviation

sqrt(var(wunderground$TemperatureF)) == sd(wunderground$TemperatureF) # let's check that the sqrt of the var is actually equal to the sd

# But sometimes there are issues...

mean(sample_gradebook$Quiz.1)

# let's look at the data to identify problems
View(sample_gradebook)

sample_gradebook <- sample_gradebook[3:nrow(sample_gradebook),] # this says take rows 3 - total number of rows from the gradebook and all columns (note the ,)

# okay's let's try again
mean(sample_gradebook$Quiz.1)

# still something wrong here...
str(sample_gradebook)
summary(sample_gradebook$Quiz.1)

# okay, so to take care of the NAs
mean(sample_gradebook$Quiz.1, na.rm = T) # this says, drop the NAs

# what about a graphical view of the data?
hist(sample_gradebook$Quiz.1) # the histogram function knows not to count NAs
plot(density(sample_gradebook$Quiz.1, na.rm = T)) # but plotting the density doesn't

