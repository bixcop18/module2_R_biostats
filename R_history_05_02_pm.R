## IMPORTING DATA FROM FILES
# main function is read.table()
getwd() # identical to Bash's pwd
getwd
getwd()
getwd("~")
getwd("/home/jbde/")
setwd("~")
getwd()
setwd("Trainings/Biostats_and_R_bixcop_github/module2_R_biostats/")
setwd("~/Trainings/Biostats_and_R_bixcop_github/module2_R_biostats")
# LOADING THE DATA
read.table("fev_dataset.txt")
read.table("fev_dataset.txt") -> fev_dat
str(fev_dat)
read.table("fev_dataset.txt", header = TRUE) -> fev_dat # indicating the presence of a header row in the file
str(fev_dat)
range(fev_dat$Age) # just to get the range of ages in the dataset
range(fev_dat$Gender)
range(fev_dat$Smoke)
summary(fev_dat)
# transform the columns Gender and Smoke into factors, with levels {boy,girl} and {smoking, non-smoking}
# count the number of observations with Gender == 1
sum(fev_dat$Gender)
sum(fev_dat$Gender == 1) # same thing
nrow(fev_dat)
sum(fev_dat$Smoke)
fev_dat$Gender
?as.factor
factor(fev_dat$Gender)
tempfactor = factor(fev_dat$Gender)
levels(tempfactor)
levels(tempfactor) <- 'boy'
levels(tempfactor) <- c('girl', 'boy') # "0" becomes "girl" and "1" becomes "boy"
tempfactor
# modifying the data frame:
fev_dat$Gender = tempfactor
str(fev_dat)
tempfactor=factor(fev_dat$Smoke,levels = c("non-smoking","smoking"))
tempfactor
# the above is WRONG!
# instead, the correct way is a two-step thing:
tempfactor=factor(fev_dat$Smoke)
levels(tempfactor)
head(tempfactor)
sum(is.na(tempfactor))
# happy!
levels(tempfactor)
# cahnge the levels carefully, respecting the order!
levels(tempfactor) <- c('non-smoking','smoking')
head(tempfactor)
# finally, change the original dataset:
fev_dat$Smoke = tempfactor
str(fev_dat)
summary(fev_dat$Gender)
summary(fev_dat) # column-wise summary
# a new graphical function: scatterplots of all pairs of variables
pairs(fev_dat)
# select the numerical columns before calling pairs():
pairs(fev_dat[1:3])
pairs(fev_dat[-c(4,5)]) # same
pairs(fev_dat[c("Age","Ht","FEV")]) # same
# draw the histograms of heights of boys (blue) and girls (red) superimposed
# first have the boxplots of boys and girls, properly labeled
boxplot(Ht ~ Gender,data=fev_dat)
boxplot(Ht ~ Gender,data=fev_dat, xlab = "Gender", ylab = "Height (ft)", border = c("pink","lightblue")) # adding some ornament
?par
T
F
# wonderful short forms!!!
height_boys = fev_dat[fev_dat$Gender=="boys","Ht"]
length(height_boys)
height_boys = fev_dat[fev_dat$Gender=="boy","Ht"]
length(height_boys)
height_girls = fev_dat[fev_dat$Gender=="girl","Ht"]
hist(height_girls, border="pink")
hist(height_girls, border="pink", main="Histogram of heights", xlab = "Height")
hist(height_boys, border="lightblue", main="Histogram of heights", xlab = "Height")
# problem: we want to superimpose another graph
# by default, hist() being a first-class citizen of the world of graphical functions, it *erases* the previous plot
# we have to turn this behaviour down
par(new=T) # so that the next plot does not erase the existing one
hist(height_girls, border="pink", main="", xlab = "", ylab = "") # labels were already there
# we have no choice but to specify what are the axes limits we want
hist(height_boys, border="lightblue", main="Histogram of heights", xlab = "Height", xlim=c(45,75), ylim=c(0,60)) # xlim and ylim to set limits for the axes
par(new=T) # so that the next plot does not erase the existing one
hist(height_girls, border="pink", main="", xlab = "", ylab = "", xlim=c(45,75), ylim=c(0,60)) # labels were already there
# we can remove the axes altogether when drawing:
hist(height_girls, border="pink", main="", xlab = "", ylab = "", xlim=c(45,75), ylim=c(0,60), xaxt="n",yaxt="n") # labels were already there
# now we're finally good to go in three steps:
hist(height_boys, border="lightblue", main="Histogram of heights", xlab = "Height", xlim=c(45,75), ylim=c(0,60)) # xlim and ylim to set limits for the axes
par(new=T) # so that the next plot does not erase the existing one
hist(height_girls, border="pink", main="", xlab = "", ylab = "", xlim=c(45,75), ylim=c(0,60), xaxt="n",yaxt="n") # labels were already there
# exercise: add a legend to this plot to explain the colours
# other way exploiting the "hidden" add parameter:
# FIRST STEP
hist(height_boys, border="blue", main="Histogram of heights", xlab = "Height", xlim=c(45,75), ylim=c(0,60)) # xlim and ylim to set limits for the axes
# SECOND AND LAST STEP
hist(height_girls, border="red", main="", xlab = "", ylab = "", xlim=c(45,75), ylim=c(0,60), xaxt="n",yaxt="n", add=T) # labels were already there
?legend
savehistory("R_history_05_02_pm.R")
