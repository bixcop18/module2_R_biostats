4+4 # direct interaction
4+5
TRUE # the correct way to spell the boolean "TRUE" in R
True # incorrect, Python syntax!
FALSE # another logical value
typeof(FALSE)
typeof(4)
typeof(4L) # forcing a number to be considered and stored as an integer, not a double
typeof("Helen") # double-quoted string
typeof("Jean's trousers") # double-quoted string can include a single quote as a normal character
typeof(Helen) # unprotected token must refer to an existing OBJECT
## VARIABLE ASSIGNMENT
## two forms:
## (1) variable = value
a = 5
b = 5L # forcing storage as an integer
## (2) variable <- value
b <- 'Helen' # storing a string in b
typeof(b)
3 < 5
typeof(3 < 5)
b < - 'Helen' # erroneous: not the assignment operator
## third form of assignment:
## (3) value -> variable
34.5 -> a
(4+564.5)/3.567 + a
(4+564.5)/3.567 + 2 * a
(4+564.5)/3.567 + 2 * a -> a # convenient operator to save into a variable
typeof(3 < 5) -> mynewvar
56
# the simplest container in R is a VECTOR
# basic operator to create a vector from several elements: the function c
c(45,3,-3,67.5)
# c() is for "combine"
# try and use c() to combine elements of different types into the same vector
# automatic conversion is performed in order to comply with the rule "ONLY ONE DATATYPE PER VECTOR"
c("hello", 3, 56.5)
c("hello", 3, TRUE)
c(3, TRUE, FALSE)
# conversion goes to the most flexible type amongst those present
## SPECIAL FUNCTIONS is.**** and as.****
# is.vector checks whether something is a vector
is.vector(5)
is.numeric(5)
is.numeric("ezrgzrtzrg")
# explicit conversion is performed by means of an "as.*****" function
as.numeric(FALSE)
as.numeric(TRUE)
as.numeric(56.768)
as.numeric("456")
as.numeric("Eric")
NA # the object for missing data
na # case sensitivity holds!
as.character(345)
as.character(c(345,FALSE))
the_false_object = FALSE
1:100 -> myvec # vector of 100 values
the_false_object
myvec
is.vector(myvec)
# length is the built-in function to get the length of a vector
length(myvec)
length(a)
length(86.5)
# for regular sequences: use seq
seq(0,1,0.05)
length(seq(0,1,0.05))
seq(0,1,0.05) -> regular
## operations in R are by default VECTORIZED
3 + 5
2 * 5
2 * a
2 * regular
multiplier_vector = c(2,-2)
multiplier_vector * regular
plot(multiplier_vector * regular, col="red")
multiplier_vector = c(2, -2, 0.5)
length(myvec)
length(regular)
length(multiplier_vector*regular)
multiplier_vector*regular
is.integer(myvec)
c(myvec,45.0)
is.integer(c(myvec,45.0))
c(myvec,45.4)
savehistory("R_history_04_30_am.txt") # to save this file
