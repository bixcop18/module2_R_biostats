getwd()
setwd("~/Trainings/Biostats_and_R_bixcop_github/module2_R_biostats/")
# Fisher's distribution
?df
# plotting the density of a F(5,1000) between 0 and 10
curve(df(x,5,1000), from = 0, to = 10, n=1001, col='red')
# we zoom in:
curve(df(x,5,1000), from = 0, to = 5, n=1001, col='red')
# vertical line at x=1:
abline(v=1,lty=2,col='grey')
# a different F distribution:
curve(df(x,5,6), from = 0, to = 5, n=1001, col='red')
# probability to have a random value larger than 3?
1 - pf(3,df1=5,df2=6000)

# perform an ANOVA with R: aov()
# on the dataset on FEV
dat = read.table('Datasets/fev_dataset.txt', header=T)
str(dat)
dat_reduced = subset(dat, Age >= 6 & Age <= 10)
# it is important to make "Age" a FACTOR so that we can use it to delimitate groups of observations
dat_reduced$Age = factor(dat_reduced$Age)
aov(data=dat_reduced, formula = Ht ~ Age) -> aov_obj
summary(aov_obj) # outputs meaningful info
aov_obj
