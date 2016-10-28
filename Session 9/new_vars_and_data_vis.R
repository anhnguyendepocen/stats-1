##############################
##    Creating Variables    ##
##     and Plotting Data    ##
##############################

### ============================ Data & Packages
data("Affairs", package = "AER") 
# If you don't have the AER package, run install.packages("AER")
load("My Code/Data/merge_data.Rdata")
library(tidyverse) # this will load both dplyr and ggplot2, which we'll use later

### ============================ Creating New Variables
# We've seen how to make new variables in a very simple way
# E.g.
Affairs$var1 <- as.factor(Affairs$education) # we create a new variable that's a copy of an old one, but a different type of data
Affairs$v2 <- Affairs$age + 10 # We create a new variable using a simple function

# But what if we want to make a new variable conditional on some other values?
# Two ways (easy and clear but ugly vs harder and less clear but "elegant")
# Method 1
Affairs$affairs_high <- 0
Affairs$affairs_high[which(Affairs$affairs >= 3)] <- 1

# Method 2
Affairs$affairs_high_2 <- ifelse(Affairs$affairs >=3, 1, 0)

# We can see that the two methods produced the same thing:
summary(Affairs$affairs_high == Affairs$affairs_high_2)

# Bonus Method 3 (using dplyr)
Affairs <- Affairs %>% 
  mutate(affairs_high_3 = ifelse(affairs >=3, 1, 0))

summary(Affairs$affairs_high_3 == Affairs$affairs_high)

### ============================ Data Vis
# Let's go back to our merged data to do some plotting:
# Remerge the data (in case you opened this file on its own)
all_observations <- merge(polity, wb_wide, by.x = c("country", "year"), by.y = c("country", "date"), all.x = T, all.y = T)
plot(x = log(all_observations$gdp_per_capita), 
     y = all_observations$rural_pop_pct_total, 
     xlab = "Log GDP per Capita",
     ylab = "Rural Population (% of Total Population)",
     main = "Rural Pop. Vs. Log GDP/capita"
)

# How about some bonus ggplot2?
# The same thing using a (better) different way...
ggplot(all_observations) +
  geom_point(aes(x = log(gdp_per_capita), y = rural_pop_pct_total)) +
  labs(x = "Log GDP per Capita", y = "Rural op (% of Total)", title = "Rural Pop vs. Log GDP/cap")

# But we can do so much more (and so easily!)
ggplot(all_observations) +
  geom_point(aes(x = log(gdp_per_capita), y = rural_pop_pct_total, color = polity2), alpha = .5) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(x = "Log GDP per Capita", y = "Rural op (% of Total)", title = "Rural Pop vs. Log GDP/cap")

# Oh, and it plays nice with dplyr...
wb_wide %>% 
  filter(country != "Belize") %>% 
  mutate(year = as.numeric(date)) %>% 
  inner_join(polity) %>% 
  filter(!is.na(gdp_per_capita) | !is.na(rural_pop_pct_total)) %>% 
  ggplot() +
    geom_point(aes(x = log(gdp_per_capita), y = rural_pop_pct_total, color = polity2), alpha = .5) +
    scale_color_gradient(low = "blue", high = "red") +
    labs(x = "Log GDP per Capita", y = "Rural op (% of Total)", title = "Rural Pop vs. Log GDP/cap")

# Or how about this!
wb_wide %>% 
  mutate(year = as.numeric(date)) %>% 
  filter(year >= 2000) %>% 
  inner_join(polity) %>% 
  filter(!is.na(gdp_per_capita) & !is.na(rural_pop_pct_total)) %>% 
  group_by(year) %>% 
  ggplot() +
    geom_point(aes(x = log(gdp_per_capita), y = rural_pop_pct_total, color = polity2)) +
    scale_color_gradient(low = "blue", high = "gold") +
    facet_wrap(~ year) +
    labs(x = "Log GDP per Capita", y = "Rural op (% of Total)", title = "Rural Pop vs. Log GDP/cap")