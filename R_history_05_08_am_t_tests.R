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

# (1) test statistic
test_stat = (mean(heights)-0)/(sd(heights)/sqrt(length(heights)))
# (2) critical values under alpha = 0.01
alpha = 0.01
crit_val_minus = qt(alpha/2, df = length(heights)-1)
# and the other one is (- crit_val_minus)

# (3) p-value calculation
# because of the symmetry around the y-axis, the p-value is equal to twice the AUC on the right of the test statistic:
2 * (1-pt(test_stat,df=350)) # approximated to 0

# (4a) with H_0 == "mu = 80"
test_stat = (mean(heights)-80)/(sd(heights)/sqrt(length(heights)))
# same critical values -2.59 and +2.59
# p-value:
2 * pt(test_stat,df=350) # because test_stat is now negative
# p-val around 5e-249: REJECTION

# now performing the t-test with R
# H_0 is now "the true mean of the distribution is equal to 80".
t.test(x = heights, mu=80)
# we reject H_0

# (4b) testing H_0 == "true mean equal to 60"
test_stat = (mean(heights)-60)/(sd(heights)/sqrt(length(heights)))
# critical values still the same since we keep the same alpha
# we are still in the rejection region, but the p-value is significantly larger:
2 * pt(test_stat,df=350)

# performing the test with R:
t.test(x = heights, mu=60, conf.level = 0.99)

# on smaller samples, we wouldn't be so sure about rejecting H_0:
t.test(x = heights[1:30], mu=60, conf.level = 0.99)


## Two-sample t-tests: test true difference in means between the heights of boys and girls aged between 6 and 10 (incl.), under alpha = 0.05

ht_boys = fev_dat[fev_dat$Age >= 6 & fev_dat$Age <= 10 & fev_dat$Gender == 1,"Ht"]
# other way:
ht_boys = subset(fev_dat, subset = Age >= 6 & Age <= 10 & Gender == 1)[["Ht"]]

ht_girls = subset(fev_dat, subset = Age >= 6 & Age <= 10 & Gender == 0)[["Ht"]]

t.test(ht_boys, ht_girls, var.equal=T)
length(ht_boys)+ length(ht_girls)-2
# p-value = 0.9766, so we are in the acceptance region, i.e. we fail to reject H_0. We way that there is no significant difference between the true means of the heights of boys and girls.