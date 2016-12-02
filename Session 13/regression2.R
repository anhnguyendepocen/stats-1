## Regression Part 2
## Brendan Apfeld

# load packaegs and data
# vdem data is available online at v-dem.net
library(tidyverse)
load("~/Documents/UT/Datasets/V-Dem/vdem.Rdata")

# only select desired variables then
# create a categorical variable based on oil reserves then
# select only LA countries
vds <- vdem %>% 
  select(country_name, year, v2x_polyarchy, e_peaveduc, e_migdppc, e_reserves_billions) %>% 
  mutate(oil = ifelse(!is.na(e_reserves_billions), 
                      ifelse(e_reserves_billions >= 100, 3, 
                             ifelse(e_reserves_billions >= 10, 2, 
                                    ifelse(e_reserves_billions >= 1, 1, 0))), 
                      0)) %>% 
  filter(country_name %in% c("Argentina", "Brazil", "Bolivia", "Chile", "Costa Rica", "Ecuador", "El Salvador",
                             "Guatemala", "Honduras", "Mexico", "Nicragua", "Peru", "Paraguay", "Panama", "Uruguay", "Venezuela"))
# rename the variables to make them more intelligible and change scale of polyarchy
names(vds) <- c("country", "year", "polyarchy", "education", "gdppc", "reserves", "oil")
vds$polyarchy <- vds$polyarchy*100
# I saved the data at this point to distribute so you can replicate easily
# load the file from github into R using load (as in line #7 above)
# save(vds, file = "My Code/Data/vdem_edited.Rdata")

# plain vanilla regression
reg1 <- lm(polyarchy ~ education + gdppc, data = vds)
summary(reg1)

# with a dummy variable
summary(as.factor(vds$oil))
vds$oil <- factor(vds$oil, labels = c("none", "low", "high"))
summary(vds$oil)

reg2 <- lm(polyarchy ~ education + gdppc + oil, data = vds)
summary(reg2)

# with an interaction (and no dummy)
reg3 <- lm(polyarchy ~ education + gdppc + education*gdppc, data = vds)
summary(reg3)
# because we've used two continuous variables for the interaction, interpretation is a little more difficult
# but we can still plot it:
plot_df <- data.frame(x = c(0, 12))
low_line <- function(x){(reg3$coefficients[1] + reg3$coefficients[3]*600) + (reg3$coefficients[2] + reg3$coefficients[4]*600)*x}
mid_line <- function(x){(reg3$coefficients[1] + reg3$coefficients[3]*3000) + (reg3$coefficients[2] + reg3$coefficients[4]*3000)*x}
hi_line <- function(x){(reg3$coefficients[1] + reg3$coefficients[3]*13000) + (reg3$coefficients[2] + reg3$coefficients[4]*13000)*x}
ggplot(plot_df, aes(x = x)) +
  stat_function(fun = low_line, color = "red") +
  stat_function(fun = mid_line, color = "blue") + 
  stat_function(fun = hi_line) +
  labs(x = "Education", y = "Polyarchy")

# with fixed effects (and an interaction and a dummy)
reg4 <- lm(polyarchy ~ education + gdppc + oil + education*gdppc + country, data = vds)
summary(reg4)

