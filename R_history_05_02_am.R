str(mtcars)
# get the mean consumption (in miles per gallon, mpg) of all cars whose engine displacement exceeds 2L.
cu_in_to_L = 0.0163871
dim(mtcars)
mtcars[2,5] # element on the second row and fifth column
# selecting one row:
mtcars[2] # WRONG!
# a vector would be displayed with a different syntax:
mtcars$cyl
# dim does not work on a vector:
dim(mtcars$cyl)
# but of course, it works on a data frame:
dim(mtcars[2])
# to get the whole of the second row: indicate a row filter AND no column filter
mtcars[2,] # second row, all columns
# a data frame is seen internally as a list of _columns_ (variables): if you indicate only one index within the square brackets, it will select a whole _column_, not row
mtcars disp * cu_in_to_L
disp * cu_in_to_L
mtcars$disp * cu_in_to_L
mtcars$disp * cu_in_to_L > 2
# count the number of cars exceeding 2L in engine displacement:
sum(mtcars$disp * cu_in_to_L > 2)
mtcars[mtcars$disp * cu_in_to_L > 2]
mtcars[,mtcars$disp * cu_in_to_L > 2]
mtcars[mtcars$disp * cu_in_to_L > 2,]
# we can filter simultaneously on rows and columns:
mtcars[5:10, 2:3]
mtcars[c(5,7,10), 2:3] # elements don't need to be consecutive
mtcars[c("Ferrari Dino", "Merc 280"), 2:3] # we can also use names
mtcars[c("Ferrari Dino", "Merc 280"), "mpg"] # we can also use names
mtcars[c("Ferrari Dino", "Merc 280"), c("cyl", "mpg")] # we can also use names
mtcars[mtcars$disp * cu_in_to_L > 2,]
mtcars[mtcars$disp * cu_in_to_L > 2,]$mpg # one way...
mtcars$mpg[mtcars$disp * cu_in_to_L > 2,] # ... other way
mtcars$mpg[mtcars$disp * cu_in_to_L > 2] # ... other way
mtcars[mtcars$disp * cu_in_to_L > 2, mpg] # ... yet another way, but wrong...
mtcars[mtcars$disp * cu_in_to_L > 2, "mpg"] # ... yet another way!
mean(mtcars[mtcars$disp * cu_in_to_L > 2, "mpg"]) # final answer
mean(mtcars[mtcars$disp * cu_in_to_L > 2, 1]) # final answer
mean(mtcars[mtcars$disp * cu_in_to_L < 2, "mpg"]) # final answer for cars below 2L displacement
# try and make boxplots of the consumption values according to number of cylinders
# how many different cylinder values?
table(mtcars$cyl) # nice and cute command to get a table of counts
boxplot(mtcars)
?boxplot
boxplot(mtcars$cyl) # not appropriate
boxplot(mtcars$mpg) # only one distribution
boxplot(mpg ~ cyl) # three boxplots, one per number of cylinders
boxplot(mpg ~ cyl, data = mtcars) # three boxplots, one per number of cylinders
# introducing common GRAPHICAL PARAMETERS
boxplot(mpg ~ cyl, data = mtcars, main = "The title of my plot", xlab = "Number of cylinders", ylab = "Consumption (mpg)")
# ancillary graphical functions do not erase the current plot, they add to it.
# we calculate the summary for the consumption values pertaining to cars with 4 cylinders
summary(mtcars[mtcars$cyl == 4, "mpg"])
summary(mtcars[mtcars$cyl == 4, "mpg"]) -> summ
# inter-quartile range is the distance between the 1st and 3rd quartiles
iqr = summ["3rd Qu."] - summ["1st Qu."]
iqr
unname(iqr)
unname(iqr) -> iqr
# abline() is an ancillary function to draw lines on top of the existing plot or graph
# to draw horizontal lines, we use the named option 'h' with the y-coordinate of the line we want to draw
# example:
abline(h=10,col="blue")
# abline can't draw outside of the core graphical frame
abline(h=5,col="blue")
# abline with option v draws vertical lines
abline(v=3,col="blue")
# draw a thick (lwd = 2) horizontal line corresponding to the median of the first boxplot
abline(h=summ["Median"],lwd = 2, col='red')
# bottom and top of the boxplot in green:
abline(h=summ["1st Qu."], col="green")
abline(h=summ["3rd Qu."], col="darkgreen")
# for the whiskers, use the predefined min and max functions:
# minimum consumption value for cars with 8 cylinders:
min(mtcars[mtcars$cyl==8,"mpg"])
abline(h=min(mtcars[mtcars$cyl==8,"mpg"]), col="purple")
# output of a filtering that has failed to retain any row:
mtcars[mtcars$cyl==10,]
mtcars[mtcars$cyl==10,]
mtcars[mtcars$cyl==10,"mpg"]
summ
# lower whisker:
max(summ["1st Qu."]-1.5*iqr, summ["Min."])
abline(h=max(summ["1st Qu."]-1.5*iqr, summ["Min."]), col= "grey")
abline(h=summ["Min."], col= "grey")
# top whisker
abline(h=min(summ["3rd Qu."]+1.5*iqr, summ["Max."]), col= "darkgrey")
# OBJECTS: what's in a boxplot?
boxplot(mpg ~ cyl, plot=FALSE) -> boxplotobj # saving the boxplot as an R object
boxplot(mpg ~ cyl, data = mtcars, plot=FALSE) -> boxplotobj # saving the boxplot as an R object
str(boxplotobj)
hist(mtcars[mtcars$cyl==4,"mpg"]) -> histobj # saving the histogram as an R object
# exercise for tomorrow: have a better labeling (0,1,2) of the Y axis scale
str(histobj)
# the class attribute is set to 'histogram'
class(histobj)
plot(histobj)
plot.histogram(histobj)
graphics::plot.histogram(histobj)
histobj.plot()
plot(histobj)
# LAST THING FOR THIS MORNING: FACTORS
plot(histobj, col='blue')
plot(histobj, border='blue')
plot(histobj, border='blue', col="red")
# remember the iris dataset
str(iris)
is.factor(iris$Species)
is.factor(1:10)
levels(iris$Species)
blood_groups_in_this_room = c("O","A","O","O","B") # creates a vector of type character
str(blood_groups_in_this_room)
levels(blood_groups_in_this_room)
summary(blood_groups_in_this_room)
blood_groups_in_this_room = factor("O","A","O","O","B") # creates a FACTOR
?factor
blood_groups_in_this_room = factor(c("O","A","O","O","B")) # creates a FACTOR
blood_groups_in_this_room
#good old vectors:
myvec = c("A","B","O","O","B")
myvec[6] = "AB"
myvec
myvec[10] = "AB"
myvec
# now with factors:
blood_groups_in_this_room[6] = "AB"
blood_groups_in_this_room
levels(blood_groups_in_this_room)
# modifying the levels afterwards:
levels(blood_groups_in_this_room) <- c(levels(blood_groups_in_this_room),"AB")
levels(blood_groups_in_this_room)
blood_groups_in_this_room # no retroactive insertion!
blood_groups_in_this_room[6] = "AB"
blood_groups_in_this_room
blood_groups_in_this_room[10] = "ab" # CASE-SENSITIVE!
blood_groups_in_this_room
summary(blood_groups_in_this_room)
str(iris$Species)
iris$Species
str(iris)
head(iris$Petal.Width)
iris$Species
as.integer(iris$Species)
levels(iris$Species)
levels(iris$Species) = c("flowerA","flowerB","flowerC")
as.integer(iris$Species)
iris$Species
levels(iris$Species) = c("virginica","versicolor","setosa")
iris$Species
iris
iris$Species
savehistory("R_history_05_02_am.R")
