# to load a package already installed:
library(magrittr)
library(dplyr) # or library(tidyverse)
# to install a package:
install.packages("magrittr")

c(1,3,4,5,89) %>% mean() %>% as.integer() # the pipe operator in R (from magrittr)
c(1,3,4,5,89) %>% 5 # nonsense: a non-functional object follows the pipe operator
c(1,3,4,5,89) %>% mean(1:10) # 1:10 is actually the *second* argument of the function call to mean()
?mean
mtcars
# subsetting mtcars to get only the cars with 6 cylinders:
mtcars %>% subset(cyl==6) %>% getElement(name="drat") -> myhappyvar 
# let's write this without pipes:
mean(mtcars[mtcars$cyl==6,"drat"])
install.packages("tidyverse")
library(readxl)
cookingdat = read_xlsx("Biostats_and_R_bixcop_github/module2_R_biostats/Cooking Time Data.xlsx", na=c("","."," "))
str(cookingdat) # a data.frame but also a tbl_df object
cookingdat # pretty display of a tibble
dim(cookingdat)
ncol(cookingdat)
names(cookingdat)

# different values in country of origin? With counts:
table(cookingdat$`Country of Origin`)
# beware! table() silently ignores the NAs!

# without counts:
unique(cookingdat$`Country of Origin`) # oh! we have NAs!
# how many NA's in that column?
sum(is.na(cookingdat$`Country of Origin`))

# we want to change all the "N America" into "N. Am"
cookingdat$`Country of Origin`[cookingdat$`Country of Origin`=="N America"]  <- "N. Am"

# now transforming into a factor:
cookingdat$`Country of Origin` = factor(cookingdat$`Country of Origin`)
str(cookingdat)

# means of cooking time per country
cookingdat %>% group_by(`Country of Origin`) %>% summarise(mean_cook_time = mean(`Cook time (min)`)) # naming my new column. All other columns have been silently dropped.

# verifying:
mean(cookingdat$`Cook time (min)`[cookingdat[3]=="N. Am"], na.rm=T)

# we can have simultaneously different levels of grouping:
cookingdat %>% group_by(`Country of Origin`, `Seed type`) %>% summarise(mean_cook_time = mean(`Cook time (min)`))
# at the end of the operation, the grouping by seed type has been dropped. Remains one level of grouping: Country of Origin.

# Remark:
cookingdat %>% group_by(`Country of Origin`, `Seed type`)
# is strictly not equivalent to:
cookingdat %>% group_by(`Country of Origin`) %>% group_by(`Seed type`)
# because a group_by() removes any previously existing grouping info in the object. So the first instance is equivalent to:
cookingdat %>% group_by(`Country of Origin`) %>% group_by(`Seed type`, add=T)


# now we want to create a new column populated with values calculated as (soaked_wt - dry_wt) / soaked_wt, to verify if it correlates with the water intake values

# in between, we rename some columns just because it will be more convenient:
cookingdat %>% rename(dry_wt=`25 seed weight (g)`, soaked_wt=`25 soak weight (g)`) %>% mutate(water_uptake_check = soaked_wt / dry_wt ) -> new_df

new_df %>% filter(water_uptake_check < 10 ) %>% select(`Water uptake`,water_uptake_check) -> subset_df# selecting the last 2 columns but also removing the observations with a check larger than 10

# plot our checks against the values in "Water update"

plot(water_uptake_check ~ `Water uptake`, data=subset_df)
