getwd()
fevdat= read.table("Datasets/fev_dataset.txt",header=T)

## FIRST SECTION: CORRELATION COEFFICIENTS

plot(Ht ~ Age, data=fevdat)
# correlation calculation
# by hand:
m_x = mean(fevdat$Ht)
m_y = mean(fevdat$Age)
numerator = sum((fevdat$Ht - m_x)*(fevdat$Age - m_y))
ss_x = sum((fevdat$Ht - m_x)^2)
ss_y = sum((fevdat$Age - m_y)^2)
pearson_cor = numerator / sqrt(ss_x) / sqrt(ss_y)

# now using the R function:
cor(fevdat$Ht, fevdat$Age)
# it is symmetric:
cor(fevdat$Age, fevdat$Ht)

# there is an associated test with H_0 being "pearson_cor between underlying populations == 0":
cor.test(fevdat$Age, fevdat$Ht)
# since the p-value is so low (below 2.2e-16), we reject H_0

# we want to create artificially a situation where there is null correlation:

# we will create an artificial vector of values drawn uniformly between 1e-2 and 0:
randomvec = runif(n = nrow(fevdat), min = -1e-2, max = 0)
# plot the absence of correlation:
plot(x=fevdat$Age,y=randomvec)
# then perform the test:
cor.test(x=fevdat$Age,y=randomvec)
# we don't reject H_0

# the Pearson correlation test assumes normality. There is another correlation measure well suited for samples departing from that assumption, and calculated based on comparisons between within-vector ranks: the Spearman correlation coefficient.

# the default in cor() and in cor.test() is to use Pearson correlations, but one can specify Spearman instead:
cor(fevdat$Age,fevdat$Ht)
cor(fevdat$Age,fevdat$Ht,method = "pearson") # same
cor(fevdat$Age,fevdat$Ht,method = "spearman")

# same for the tests:
cor.test(fevdat$Age,fevdat$Ht,method = "spearman")
cor.test(randomvec,fevdat$Ht,method = "spearman")
# Spearman correlation should be preferred when at least one of the two vectors originates from a distribution thought *not to be* normal


# WARNING! sample correlation equal to 0, or even true correlation equal to 0, DOES NOT ENTAIL independence of the variables.

# Logical implications:
# X and Y independent => cor(X,Y) = 0
# BUT _NOT_:
# cor(X,Y) = 0 => X and Y independent # THIS ASSERTION IS FALSE

# exercise 1: see what is the correlation between X and Y=X^2, for X values at random between -2 and 2. Test also when X ranges between -1 and 1.

# exercise 2: try to have (X,Y) values describing the unit circle centered in (0,0), and test the correlation between X and Y



## SECOND SECTION: TESTING NORMALITY

# how can we assess how likely it is that a given sample originates from a normal population (i.e. a normal distribution)?

# Shapiro-Wilk or Wilk-Shapiro normality test:
# H_0 is "the underlying population is normal"

# a low p-value is an indication to REJECT H_0
hist(fevdat$FEV)
shapiro.test(fevdat$FEV) # rejection of H_0 here.
# by construction, the S-W test is know to be very strict on the hypothesis of normality: it tends to reject H_0 as soon as it sees even a faint signal of non-normality.

# we create artificially a situation where W-S should accept H_0:
shapiro.test(rnorm(10,3,10)) # high p-values: acceptance of H_0

shapiro.test(fevdat$Age) # rejection again
shapiro.test(fevdat$Ht) # rejection again, even though a bit weaker
hist(fevdat$Ht)

#other tests are not so strict

# TESTING THE SIMILARITY BETWEEN TWO DISTRIBUTIONS:

# The Kolmogorov-Smirnov test is based on the comparison between two probability functions
# to test normality on one sample, we test with ks.test against the pnorm function with parameters given by the sample estimates (mean and sd) on our sample of interest:
ks.test(fevdat$Ht, "pnorm", mean(fevdat$Ht), sd(fevdat$Ht)) # accpetance
ks.test(randomvec, "pnorm", mean(randomvec), sd(randomvec)) # rejection

# Kolmogorov-Smirnov is less "picky" on what it accepts as a sample possibly coming from a normal distribution.


# QQ-plots are a nice way to visually compare two distributions
# each point in a quantile-quantile plot is (x,y) with x being a given quantile value for the first population and y being the *same* quantile for the other sample.

# We are now comparing distributions. Samples can have different sizes.

sample1 = rnorm(n=10000, mean=10, sd=2) # normal distrib
sample2 = runif(n=200000, min=20, max=200) # uniform distrib

# for each I will calculate all the quantiles separated by 1%:
# the min, the 0.01 quantile, the 0.02 quantile, etc until the 0.99 quantile and the max

quantiles_sample1 = quantile(x=sample1, probs = seq(0,1,0.01))
quantiles_sample2 = quantile(x=sample2, probs = seq(0,1,0.01))


# check the median:
quantiles_sample1["50%"]
quantiles_sample1[51]

# my happy manual quantile-versus-quantile plotting:
plot(quantiles_sample1,quantiles_sample2, xlab= "Quantiles of a norm. dist. (10,2)", ylab = "Quantiles of a unif. (20,200)")

# now we compare two normal distributions:
sample3 = rnorm(n=200000, mean=20, sd=0.200) # uniform
quantiles_sample3 = quantile(sample3,seq(0,1,0.01))
# my happy manual quantile-versus-quantile plotting:
plot(quantiles_sample1,quantiles_sample3, xlab= "Quantiles of a norm. dist. (10,2)", ylab = "Quantiles of a norm (20,0.2)")

# We can obtain these automatically with R:
qqplot(quantiles_sample1,quantiles_sample3)

# a straight line in a quantile-quantile plot indicates samples originating from the same type of distribution (e.g. either both normal or both uniform, etc)

# We can use qqnorm with only one sample to test visually the departure from normality:
qqnorm(quantiles_sample1) # a normal sample
qqnorm(quantiles_sample2) # not normal but uniform
qqnorm(fevdat$Ht)
