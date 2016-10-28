##############################
##     Merging Data in R    ##
##############################

# There are a lot of things that might go wrong when you try to merge data
# Here we'll focus on the following:
#   1. Country names (or some other ID variable) not equal
#   2. One dataset has observations the other doesn't
#   3. Incompatible data types

### ============================ Data
# load the data (change this depending on where you saved the file)
load("My Code/Data/merge_data.Rdata")

# Let's take a quick look at what we're dealing with
str(polity)
str(wb_wide)

# It looks like we have country-year observations and 1, 4 variables for each observation

### ============================ Issue 1
# It's possible that the country names are different

pol_countries <- levels(as.factor(polity$country)) # create a vector with the names of the polity countries
wb_countries <- levels(as.factor(wb_wide$country)) # and with the world bank countries

length(pol_countries)
length(wb_countries)

# We need to compare the two lists
pol_countries
wb_countries
# that's really inefficient, let's do something a little better
pol_countries %in% wb_countries
wb_countries %in% pol_countries
# okay, that showed that the two lists are not identical, but we can do better still
# create a vector of the pol_countries that don't appear in wb_countries
bad_pol_countries <- pol_countries[which(pol_countries %in% wb_countries == FALSE)]
# and one for wb_countries that don't appear in pol_countries
bad_wb_countries <- wb_countries[which(wb_countries %in% pol_countries == FALSE)]
# let's take a look at those lists
bad_pol_countries
bad_wb_countries

# The names for polity seem easier to work with, so let's go with those
# In other words, we'll change the names for the wb_wide dataset to match polity

wb_wide$country[which(wb_wide$country == "Bosnia and Herzegovina")] <- "Bosnia"
wb_wide$country[which(wb_wide$country == "Cote D'Ivoire")] <- "Ivory Coast"
wb_wide$country[which(wb_wide$country == "Egypt, Arab Rep.")] <- "Egypt"
wb_wide$country[which(wb_wide$country == "Iran, Islamic Rep.")] <- "Iran"
wb_wide$country[which(wb_wide$country == "Korea, Dem. People’s Rep.")] <- "Korea North"
wb_wide$country[which(wb_wide$country == "Korea, Rep.")] <- "Korea South"
wb_wide$country[which(wb_wide$country == "Russian Federation")] <- "Russia"
wb_wide$country[which(wb_wide$country == "Syrian Arab Republic")] <- "Syria"
wb_wide$country[which(wb_wide$country == "United Arab Emirates")] <- "UAE"
wb_wide$country[which(wb_wide$country == "Venezuela, RB")] <- "Venezuela"
wb_wide$country[which(wb_wide$country == "Yemen, Rep.")] <- "Yemen"

# Our two lists won't match complete because there are still some countries only contained in one dataset...

### ============================ Issue 2
# What should we do about data that only appears in one dataset?
# This is a bit of a judgment call
# In general, it's probably best to keep everything
# But if you'll require all variables in what you're doing, then maybe save yourself an NA headache
# and delete the observations that appear in only one dataset

# which countries only appear in polity now?
wb_countries <- levels(as.factor(wb_wide$country)) # since we made changes, we have to update (we'll just overwrite the vector)
bad_pol_countries <- pol_countries[which(pol_countries %in% wb_countries == FALSE)]
bad_pol_countries

# and which ones in wb only?
bad_wb_countries <- wb_countries[which(wb_countries %in% pol_countries == FALSE)]
bad_wb_countries

# Subset option 1 (base R)
polity_new <- subset(polity, country != "East Timor" & country != "Gambia" & country != "Kyrgyzstan" & country != "Laos")
polity_new <- subset(polity_new, !country %in% c("Macedonia", "Sudan-North", "USSR", "Yugoslavia"))

# Subset option 2 (dplyr)
library(dplyr)
wb_new <- wb_wide %>% 
  filter(country != "Belize")

# Subset option 3
# Just let the merge do it!
# We'll actually do this in a minute, but let's consider why that might be better
# Hint: note the number of observations in our new datasets

### ============================ Issue 3
# Let's try to merge with the smaller datasets using base R
full_dataset <- merge(polity_new, wb_new, by.x = c("country", "year"), by.y = c("country", "date"))
# This works well and we could tweak the settings if we wanted to keep the values that we dropped earlier
all_observations <- merge(polity, wb_wide, by.x = c("country", "year"), by.y = c("country", "date"), all.x = T, all.y = T)

# Another option for merging involves dplyr
# Advantage is that the language is a little more intuitive (I think)
# Disadvantage is that (surprisingly) it's a little pickier in one way

dpmerger <- inner_join(polity_new, wb_new, by = c("country" = "country", "year" = "date"))

# what went wrong?
str(wb_new)
str(polity_new)

# We can fix that quickly
wb_new$date <- as.numeric(wb_new$date)

# And try again
dpmerger <- inner_join(polity_new, wb_new, by = c("country" = "country", "year" = "date"))

# Other dplyr merge options are left_join, right_join, and full_join