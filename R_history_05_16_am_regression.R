getwd()

# REGRESSION ANALYSIS

fevdat = read.table("Datasets/fev_dataset.txt",header=T)
str(fevdat)

# first model: analyse association between height and age
plot(y=fevdat$Ht, x=fevdat$Age)
# another way to plot the same:
# using what is called a formula:
plot(Ht ~ Age, data = fevdat)
# same as when we want to do boxplots of subgroups of a given population:
boxplot(Ht ~ Age, data = fevdat)

# to get a linear model: function lm()
lm(Ht ~ Age, data = fevdat)

# output model is:
# Ht = 45.958 + 1.529 * Age
abline(a= 45.958, b=1.529, col='purple')

# lm() produces much more than the values of the best estimates for the regression parameters:
model1 = lm(Ht ~ Age, data = fevdat)
class(model1)
str(model1)
model1$coefficients # to access the model parameter estimates

# abline also accepts to get as input an lm object:
abline(model1,col='red')

summary(model1)
# cehck that the mean residual is equal to 0:
mean(model1$residuals)
hist(model1$residuals)
# the framework of the least squares regression is such that in most datasets the residuals are normally distributed when the number of observations is large enough

# the (multiple) R-squared value represents the fraction of the total variance that is explained by the model: it's equal to the ratio between the variance of the predicted outcomes ("fitted.values" slot in an lm object) and the variance of the set of observed outcomes:
var(model1$fitted.values)/var(fevdat$Ht)


# To show a "very wrong" model, let us add a column to our dataframe that will be made of gaussian noise (centered on 100 and with standard deviation equal to 8) and I will try to explain the same outcome (height) as a function of this preposterous predictor.

fevdat$absurd_predictor = rnorm(nrow(fevdat),mean=100,sd=8)

plot(Ht ~ absurd_predictor, data=fevdat)
lm(Ht ~ absurd_predictor, data=fevdat) -> absurd_model
abline(absurd_model,lty=2)
summary(absurd_model)
plot(Ht ~ absurd_predictor, data=fevdat,xlim=c(0,140))
# that was a very bad regression model
mean(fevdat$Ht)

# influence of adding predictors:
colnames(fevdat)

# we have a new model with two independent variables (aka predictors), Age and Smoke:
model2 = lm(Ht ~ Age + Smoke, data = fevdat)
# this model is: Ht = beta_0 + (beta_1 * Age) + (beta_2 * Smoke)
model2


# zero-predictor model:
model0 = lm(Ht ~ 1, data=fevdat)
model0
mean(fevdat$Ht)


summary(model2) # two-predictor model
# Multiple R-squared:  0.6291,	Adjusted R-squared:  0.6279
summary(model1) # one-predictor model
# Multiple R-squared:  0.6272,	Adjusted R-squared:  0.6266
summary(model0) # zero-predictor model Ht = beta_0
# Multiple R-squared:  0.0000


# if we try to predict the growth between 4 and 10, we will have a better linear model:
fevdat_agerange = subset(fevdat, Age >= 4 & Age <= 10)
model_agerange = lm(Ht ~ Age, data = fevdat_agerange)
plot(Ht ~ Age, data=fevdat_agerange)
abline(model_agerange,col="red")
summary(model_agerange)


# EXERCISE:
# Using the tutorial_dataset, try and predict the outcome DIABETES out of predictors being:
#  (1) all the other variables in the dataset
#  (2) SYSBP and CURSMOKE
#  (3) age and education level
# Compare the three models above, optionally try other models, and give us your take on which predictor(s) is/are relevant.
