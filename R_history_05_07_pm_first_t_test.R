# performing our first t-test

# loading the FEV dataset
setwd("/home/jbde/Trainings/Biostats_and_R_bixcop_github/module2_R_biostats/")
fev_dat=read.table("fev_dataset.txt", header=T)
str(fev_dat)

# with subset(), we extract the vector of heights of people aged 6 to 10 inclusive
heights = subset(fev_dat, Age <= 10 & Age >= 6)$Ht
heights = subset(fev_dat, Age <= 10 & Age >= 6)[["Ht"]] # same

# Now we perform the two-tailed test corresponding to H_0 being "the true mean of the distribution is equal to 80".
t.test(x = heights) # wrong test, testing H_0 == "mu = 0"

# exercises:
# (1) calculate the test statistic "manually"
# (2) give the critical values for the t distribution under a Type I error rate of 0.01
# (3) give the R expression you would use to calculate the p-value associated with this test
# (4) reproduce (1) to (3) for the two tests corresponding to mu=80 and mu=60.