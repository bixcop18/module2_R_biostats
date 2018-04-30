ls # incorrect: calling a function without parenthesis is asking for its code!
ls() # lists the variables in your environment
length(myvec)
myvec
a
a + 5
myvec + c(1000, -6, 23.5, 12, -10)
myvec + c(1000, -6, 23.5, 12.35, -10.53456)
myvec + c(1000, -6, 23.5, 12.35, -10.53456) -> myvec
length(myvec)
myvec(1) # a vector of type numeric is NOT callable!
myvec[1] # slicing a vector
myvec[10:14] # slicing a vector, from index 10 to index 14, inclusive
# slicing creates a NEW vector
# we can get non-consecutive items:
myvec[10,14,11]
myvec[[10],[14],[11]]
myvec[c(10,14,11)]
# the above is a way to get non-consecutive elements from a vector
myvec[seq(1,length(myvec),2)] # taking elements from first to last, by steps of 2
myvec[c(1,3,5,7,9)]
# accessing out of bounds produces NA values!
length(myvec)
myvec[101]
myvec[c(101,56, -2)]
myvec[c(101, 56, 200)]
# BEWARE! Minus in square brackets filtering of a vector EXCLUDES some values
multiplier_vector[-3]
multiplier_vector[-c(1,3)]
## INTRODUCING LOGICAL FILTERS
myvec
multiplier_vector
multiplier_vector[-5] # silently ignores the fact there are fewer than 5 elements in this array
multiplier_vector
multiplier_vector[-1]
multiplier_vector[-3]
multiplier_vector[c(1,3)]
multiplier_vector[-c(1,3)] # all values BUT the ones at the indices mentioned in c(...)
# we want to extract from myvec all values larger than 50
myvec > 50
myvec[myvec > 50]
myvec[myvec > 50] # using a logical mask/filter/sieve to extract values responding "TRUE" to a certain test
length(myvec > 50) # count the number of values larger than 50
count(myvec > 50) # count the number of values larger than 50
?sum
sum(1,2,3)
sum(c(1,2,3,67,56))
sum(c(1,2,3,67,NA,56))
sum(c(1,2,3,67,NA,56),na.rm = TRUE)
sum(myvec > 50) # proper count of the number of values larger than 50
sum(1:5)
##
## DESCRIPTIVE STATS ON SAMPLE myvec
myvec
# sample mean
sum(myvec/myvec) # outputs 100
sum(myvec)/length(myvec)
sum(1:100)/100
mean(myvec)
# min and max give you the range of a vector
min(myvec)
max(myvec)
# let's prove that there is no value greater than 1096 in this vector:
myvec > 1096
sum(myvec > 1096)
# range is min and max combined
range(myvec)
is.na(myvec) # logical vector
sum(is.na(myvec)) # counting the number of NAs
?sort
sort(myvec)
myvec
# myvec has not been modified by sort()
sort(myvec)[(50+51)/2]
sort(myvec)-> sorted_vector
(sorted_vector[50] + sorted_vector[51]) / 2 # manual calculation of the sample median
median(myvec) # shorter way
summary(myvec) # very versatile, useful function
sum(myvec > 106.4) # counting points over the third quartile
summary(myvec) -> summary_object # everything is an object!
summary_object[5]
sum(myvec > summary_object[5]) # counting points over the third quartile
# named vectors are vectors with an extra attribute: names
# named vectors still DO HAVE indices
# so we have two ways to address or extract the elements in a named vector
summary_object["Median"]
summary_object[3] # same same!
str(summary_object)
str(summary_object)
names(summary_object) # calling the "names" attribute
attributes(summary_object)
# str() is a VERY IMPORTANT FUNCTION
str(the_false_object) # structure of a simple vector
str(sorted_vector)
head(sorted_vector)
tail(sorted_vector)
str(a)
?head
head(sorted_vector,n=10) # getting the 10 top values
?sort
## LOADING A BUILT-IN DATASET: mtcars
mtcars
iris
str(iris) # what is the structure of that dataset?
head(iris) # gets the first 6 observations
summary(iris) # variable-wise summary of the whole dta frame
# beware! length of a data frame == number of columns (variables)
length(iris)
dim(iris) # to get the proper number of rows and columns
nrow(iris) # just the number of rows
ncol(iris) # just the number of columns
colnames(iris)
rownames(iris)
rownames(mtcars)
rownames(iris) <- 'beautiful_flower'
rownames(iris)[12] <- 'beautiful_flower'
iris
head(iris, n=15)
rownames(iris)[1] <- 'beautiful_flower'
rownames(iris)[1]
# in a data frame, each column is a vector
# to extract from a data frame one of its column: "$" operator
str(iris)
iris$Petal.Length
iris$Petal.Length -> petal_lengths
is.vector(petal_lengths)
attributes(petal_lengths)
## MY FIRST GRAPHICS
# very simple plot with plot()
plot(petal_lengths)
range(petal_lengths)
iris$Species
plot(iris$Petal.Length, col=iris$Species)
# plotting with an argument for the colour
# first boxplots
boxplot(iris$Petal.Length)
median(iris$Petal.Length)
summary(iris$Petal.Length)
boxplot(Petal.Length ~ Species)
boxplot(Petal.Length ~ Species, data = iris)
?boxplot # to get help
boxplot(Petal.Length ~ Species, data = iris, col=c("blue","red","green"))
savehistory("R_history_04_30_pm.txt")
