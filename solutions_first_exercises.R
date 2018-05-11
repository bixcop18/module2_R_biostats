dat = read.table("Datasets/fev_dataset.txt", header=T)
str(dat)
# Q1
summary(dat$Ht)
quantile(dat$Ht)
?quantile
q = quantile(dat$Ht,probs=c(0.1,0.9))
q
names(q)
# there are 10% of the sample datapoints below the 0.1 quantile, and 10% of the sample datapoints above the 0.9 quantile

# Let's verify:
length(dat$Ht)
# number of heights below the value 53.0:
sum(dat$Ht<53)
sum(dat$Ht<=53)
# 90% quantile:
sum(dat$Ht>68.5)
sum(dat$Ht>=68.5)

# Q2: boxplots

subset(dat, Age >= 6 & Age <= 10) -> subdat
boxplot(Ht ~ Age, data = subdat, xlab='Age', ylab='Height (in)')
# OR, all in one function call:
boxplot(Ht ~ Age, data = dat, subset = Age >= 6 & Age <= 10, xlab='Age', ylab='Height (in)')

# Q3

# remark: one can add a new column very simply:
dat$NewCol
dat$NewCol = 1
str(dat)

# so:
dat$Gender2 = "Girl"
# now, replace the value in the column Gender2 to "Boy" in all rows where Gender == 1
dat[dat$Gender==1,"Gender2"] = "Boy"

# checking the result:
dat[c("Gender","Gender2")]

# solution to Q3 involving a function
# Let's define a conversion function:
gender_conversion_func = function(genderCode) if (genderCode==1) "Boy" else "Girl"
# "return" statements are implicit (see help on "function")
gender_conversion_func(0)
gender_conversion_func(1)
# default value:
gender_conversion_func('gfgf')
# careful with the size of the objects given as input:
gender_conversion_func(c(1,1,4,3,1,0,1))
?apply
# sapply ("simple apply") is used to apply the same function to all elements of a vector

# now we can have a one-liner solution for our Q3:
dat$Gender3 = sapply(dat$Gender, gender_conversion_func) # creating a new column

# solution involving a factor
dat$Gender4 = factor(dat$Gender)
levels(dat$Gender4) # ALWAYS CHECK THE ORDER OF LEVELS FIRST
levels(dat$Gender4) = c("Girl","Boy")


# Last solution to Q3: using dplyr::mutate()
library(dplyr)
dat %>% mutate(Gender5 = sapply(Gender,gender_conversion_func))

# a functional version of the "if" is "ifelse":
?ifelse
if (4==5) print("a") else print("b")
ifelse(c(1,4,23,5,4,2,5,6,2,6)==5,  yes="happy", no="unhappy")

# I encourage you to use ifelse rather than if.
# redefine the conversion function:
gender_conversion_func = function(genderCode) ifelse(genderCode==1, "Boy", "Girl")

# works on vectors:
gender_conversion_func(dat$Gender)

# we could even do without defining a function:
dat$Gender10 = ifelse(dat$Gender=="1", "Boy", "Girl")
dat[c("Gender","Gender10")]

# now the solution with mutate() will be:
dat %>% mutate(Gender2 = gender_conversion_func(Gender))


# moving to Q4 and the dataset on SSR values:
library(readxl)
read_xlsx("Datasets/ssr_data.xlsx") -> ssr_dat
str(ssr_dat)
ssr_dat %>% select(-starts_with("X__")) -> tempdat

# Q5
colnames(tempdat)
paste0("P", c(1,1,1,1,2,2,2,2), "_Allele", 1:4)
# function rep() has two forms:
# (1) rep(obj, times=n): n times the whole object obj
rep(1:2, times=4)
# (2) rep(obj, each=n): replication of each element of obj n times
rep(1:2, each=4)

markers = c(1:6,8:13,15:16)
length(markers)
colnames(tempdat)[2:(length(markers)*4+1)] <- paste0("P", rep(markers, each=4), "_Allele", 1:4)
# OR:
colnames(tempdat) <- c("ID", paste0("P", rep(markers, each=4), "_Allele", 1:4))

# WARNING! FAULTY IS:
colnames(tempdat[2:(length(markers)*4+1)]) <- paste0("P", rep(markers, each=4), "_Allele", 1:4)
# since it modifies the column names of a temporary object created as a subset of tempdat by "tempdat[...]". The temporary object is then discarded.

library(tidyr)
tempdat
# creating a small subset to demonstrate tidyr functions: 6 random samples on P11 only
tempdat %>% select(ID,starts_with("P11_")) %>% sample_frac(0.1, replace=F) -> minidat 


# let's try and use gather()
minidat %>% gather(key="Allele_num", value="Allele_length", 2:5) -> minidat_tidy
# gather() uses the column names of columns 2 to 5 to populate the new column whose name is given to the argument "key". The argument "value" gives the name of the column that will receive all the values.

# gather() GATHERS the content of several columns into a single new one.

# we quickly want to get the allele numbers as integers:
?substr
l = nchar("P11_Allele1")
minidat_tidy$Allele_num = as.integer(substr(minidat_tidy$Allele_num,start=l,stop=l))

# to rename a column:
colnames(minidat_tidy)[1] = "Sample" # modifies the data frame
minidat_tidy %>% rename(Sample=ID) -> minidat_tidy 
