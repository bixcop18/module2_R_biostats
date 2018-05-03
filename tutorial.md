R tutorial for beginners
================
Jean-Baka Domelevo Entfellner
28 September 2017









Introduction
============

This tutorial walks you through basic interactions with the R software package, from data manipulation to statistical tests and regression models. You may start an interactive session with R either directly from the shell by typing `R` on the commandline. Pay attention that your GNU/Linux environment is case-sensitive, so typing `r` will fail. Alternatively, you can start R through the fancier Graphical User Interface (GUI) called RStudio: type `rstudio` from the terminal, or (double-)click on the corresponding icon on your desktop space.

During your interactive session with R, you type **commands** or **expressions** in the terminal (the frame called *Console* in RStudio), to which R will either reply silently or display some result or perform some other action (e.g. drawing a graph in a separate window frame). Whenever R is ready to listen to you, it **invites** you to type in some command with a tiny "greater than" sign at the very beginning of the last line in the Console. In the examples you will find troughout this tutorial, the interactions with R are reproduced in `typewriter font`. So you don't have to type in the initial "greater than" sign when it is displayed at the beginning of a commandline: this is simply the **invite** as produced by R.

Once you are done with the present tutorial, if you want to deepen your understanding of how R works, start to write some basic programs in R, etc, I suggest that you read that excellent other tutorial written by Emmanuel Paradis and entitled *R for beginners* \[@R\_paradis\].

First interactions
==================

Comments in R
-------------

This is really what we should start with. On a commandline, the hash character (`#`) has a special meaning: the rest of the line, including the hash character itself, is simply totally ignored by R. This means that you can use it to enter comments in your code. Please **do comment** massively your code, as it will make your life easier when you will go back to saved file of R commands months after you first wrote them: you will understand what they mean exactly.

Variable assignment
-------------------

In programming languages, storing some kind of data into the "memory" of the computer (in fact into the current symbolic workspace defined by your R session) is called **assigning** a value to a variable. When you assign a value (whatever its type: it can be a string of characters, an integer, a boolean variable, a floating-point number, etc) to a variable, you create a new object with R. This is done through the **assignment operator** `->`. This operator is written with a hyphen (`-`) followed by a "greater than" sign (`>`), so that it forms an arrow. Taking care of swapping the two operands (variable and value), this can be also written the other way around:

``` r
5 -> a    # puts the value 5 into the variable a
b <- 7    # puts the value 7 into the variable b 
b - a     # asks for the evaluation (calculation) of b-a 
```

    ## [1] 2

``` r
2         # nothing prevents you from evaluating a constant!
```

    ## [1] 2

The "greater than" character that appears at the beginning of the line (in a terminal or in RStudio's *Console* frame is the **invite**. It means that R is waiting for you to enter a **command**. Some commands produce a silent output (e.g. assigning a value to a variable is a silent operation), some other display a result. For example, subtracting the content of the variable called `a` from the content of the variable called `b` gives the single value `2` as an output. Notice that the `[1]` automatically prepended to the output line is **an index**: as R tends to see everything as a **vectorized variable** (you will see other examples very soon), here it tells us that this `2` is the first element of the output vector produced by the operation `b-a` (this output vector contains only one element). On the last line of the interaction above, you can see that even typing a mere value and asking R to **evaluate** it by pressing the (Enter) key yields the exact same output with the exact same formatting.

Vectors and function calls
--------------------------

As we just said, **vectors** are essential data structures in R. One creates vectors simply by using the concatenation operator (or function), rightfully named `c`:

``` r
myvec <- c(1,3,5,7,84) # passing five integers as arguments to the function c
myvec                  # myvec is now a vector containing five elements
```

    ## [1]  1  3  5  7 84

``` r
length(myvec)          # calling the function length on the object myvec
```

    ## [1] 5

Here we have just used our first two **functions** in R. With the first command of this interaction block, we performed a **function call** to the function called `c`, giving it five integers as arguments. A function call in R is always written as this: the name of the function is followed by a pair of parentheses enclosing a list of comma-separated arguments (possibly only one or even none). Hence, the last operation we performed above is a function call to the function `length`, passing to it one argument only, namely the `myvec` variable.

Remember that whenever you want to **use** a function, you **have to** write these parentheses. Even if the function needs no argument. For instance, the function `ls`, when invoked (another vocable computer people use for "called") with no argument, **lists** the content of your current "userspace" or "environment": it returns a vector populated with strings giving the names of these objects present in your current R environment (i.e. the variables you defined earlier in your interactive session).

``` r
ls()
```

    ## [1] "a"     "b"     "myvec"

Beware!! If you omit the parentheses, R will try and evaluate **the function itself**:

``` r
ls
```

    ## function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, 
    ##     pattern, sorted = TRUE) 
    ## {
    ##     if (!missing(name)) {
    ##         pos <- tryCatch(name, error = function(e) e)
    ##         if (inherits(pos, "error")) {
    ##             name <- substitute(name)
    ##             if (!is.character(name)) 
    ##                 name <- deparse(name)
    ##             warning(gettextf("%s converted to character string", 
    ##                 sQuote(name)), domain = NA)
    ##             pos <- name
    ##         }
    ##     }
    ##     all.names <- .Internal(ls(envir, all.names, sorted))
    ##     if (!missing(pattern)) {
    ##         if ((ll <- length(grep("[", pattern, fixed = TRUE))) && 
    ##             ll != length(grep("]", pattern, fixed = TRUE))) {
    ##             if (pattern == "[") {
    ##                 pattern <- "\\["
    ##                 warning("replaced regular expression pattern '[' by  '\\\\['")
    ##             }
    ##             else if (length(grep("[^\\\\]\\[<-", pattern))) {
    ##                 pattern <- sub("\\[<-", "\\\\\\[<-", pattern)
    ##                 warning("replaced '[<-' by '\\\\[<-' in regular expression pattern")
    ##             }
    ##         }
    ##         grep(pattern, all.names, value = TRUE)
    ##     }
    ##     else all.names
    ## }
    ## <bytecode: 0x559393a7ae58>
    ## <environment: namespace:base>

Getting some help
-----------------

To get some help on a command, just type a question mark (`?`) immediately followed by the name of the command. You will then enter a manpage-like environment, in which the (Space) key goes to the next screen (or page), the **b** key goes back one page, and a keypress on **q** quits the help and brings you back to the commandline and its invite. Alternatively, depending on the configuration of your computer, you may get access to the HTML version of the help pages:

``` r
?ls
#.... consulting the help on the ls command. Press q to quit ....

?length
 # .... consulting the help on the length command. Press q to quit ....

??transpose
#  .... asking for the help pages containing the transpose keyword. Press q to quit ....
```

The latter type of query (with the double question mark) is to be used when you are unsure of the name of the function you are seeking help about. It tries to provide you with the list of help files containing the keyword in question, after what you will prepend the single question mark to the name of the identified command (or function) to get the relevant help page.

These help pages (also called **manpages**) are all built with the same structure: after a short *Description* of the purpose of the command, follows a section called *Usage*. This latter section presents the syntax you may use to build a function call, with the possible options to specify and their possible default values. For instance, in the help about the `c` function, the *Usage* section reads as follows :

>     c(..., recursive = FALSE)

We are told here that the `c` function takes several arguments first (an undefined number thereof) and then expects an optional parameter named `recursive`. We know it is optional because of the equal sign and the specified value put thereafter: when the user omits to specify a value for that parameter, R will silently set its value to `FALSE`.

This is a general rule for the behaviour of functions in R: when an equal sign appears in the *Usage* section right after the name of an argument, it means that in case the corresponding argument is omitted, it is silently given the said value by R (i.e.~the value appearing on the right of that equal sign). This makes function call writing very flexible, as one can omit some of the arguments when one is fine with the default values.

For instance, you may try the following:

``` r
list1 <- list(1,2)   # the list function builds a list from its argument
list2 <- list(3,4)
c(list1,list2)       # don't pay too much attention to the way R writes lists
```

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 2
    ## 
    ## [[3]]
    ## [1] 3
    ## 
    ## [[4]]
    ## [1] 4

``` r
c(list1,list2,recursive=FALSE) # produces the exact same output as the previous command
```

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 2
    ## 
    ## [[3]]
    ## [1] 3
    ## 
    ## [[4]]
    ## [1] 4

``` r
c(list1,list2,recursive=TRUE)
```

    ## [1] 1 2 3 4

In other terms, here the function call finally executed when the user enters `c(list1,list2)` is indeed `c(list1,list2,recursive=FALSE)`: the default value for the argument has been used.

Back into the manpage, the section named *Arguments* explains the role and valid values of the different arguments (or options) of the function, and the *Details* section gives further in-depth explanations about the behaviour of the function and the results it yields.

Different data, different modes
-------------------------------

R can manipulate different types of data. Whenever you input some data into R, these data are given a **mode**, and this mode affects the way R deals with them.

``` r
mode(0.1)
```

    ## [1] "numeric"

``` r
mode("allo")
```

    ## [1] "character"

``` r
mode(2 > 5)
```

    ## [1] "logical"

``` r
mode(1+2i)
```

    ## [1] "complex"

``` r
mode(TRUE)
```

    ## [1] "logical"

``` r
mode(T)   # "T" is a short for TRUE. FALSE may also be written "F"
```

    ## [1] "logical"

Non-atomic constructs also inherit the mode of their components:

``` r
a = c(1,1)   # yes, variable assignment can also be written this most simple way... ;)
mode(a)
```

    ## [1] "numeric"

``` r
a = c("ab","ba")
mode(a)
```

    ## [1] "character"

The two logical values in R are `TRUE` and `FALSE`. You may use instead their shorter versions `T` and `F`. Attention: use these symbols "as is". Enclosing them into quotes would not give the boolean values but mere strings (mode *character*).

Data structures in R: vectors, matrices and data frames
=======================================================

 We've already seen the `c` function to create vectors. A vector is a special R construct used to store an array of items all having the same mode. Vectors made of evenly spaced numeric items are called **sequences**. These are created with the `seq` command. The following three commands produce the very same result:

``` r
c(1,2,3,4,5)
```

    ## [1] 1 2 3 4 5

``` r
seq(from=1, to=5, by=1)
```

    ## [1] 1 2 3 4 5

``` r
1:5
```

    ## [1] 1 2 3 4 5

Notice that the second command uses **argument naming**: `seq(from=1, to=5, by=1)`. This is optional but convenient in many cases, and highly recommended in the specific case of `seq`. We will see other examples of function calls with explicit argument naming later on. In order to understand how the `seq` function works, please refer to its help page (command `?seq` or `help("seq")`). There you can see (*Usage* section, a.k.a~"synopsis" of the command/function) that the first three arguments expected by `seq` are named respectively `from`, `to` and `by` (the first one is the lower bound of the sequence to be generated, the second is the upper bound and the third is the step value).

Keep in mind the `1:5` trick to quickly build a sequence of consecutive integers. We will make use of that later. Also notice that `seq` comes useful to sample regularly an interval on the real line, e.g.~`x = seq(from=0, to=1, by=0.01)` builds a vector of 101 points evenly spaced on the real interval \[0, 1\], both boundaries included, and stores the result into the variable `x`.

Finally, we mention the `rep` function that helps you build a vector with a repetitive content. For instance, if we want to build a vector of 10 values all equal to 1:

``` r
rep(1,10)
```

    ##  [1] 1 1 1 1 1 1 1 1 1 1

This also applies to build a repetition of a pattern of length &gt;1:

``` r
rep(1:3,4)
```

    ##  [1] 1 2 3 1 2 3 1 2 3 1 2 3

Indexing and altering elements
------------------------------

In a vector, each element is addressable by its **index**. The usual square bracket notation applies. Vector indices start at 1, and vector elements are mutable: one can alter directly one of the values in a vector without reassigning the whole vector.

``` r
a = c(10,11,12,13)
a[2]
```

    ## [1] 11

``` r
a[2] <- 20
a
```

    ## [1] 10 20 12 13

One can also take a slice from an existing vector, extracting consecutive elements:

``` r
a[2:4]
```

    ## [1] 20 12 13

Going multidimensional: matrices
--------------------------------

Our first attempt to build a 2x2 matrix could be as follows:

``` r
mat1=c(c(1,2),c(3,4))
mat1
```

    ## [1] 1 2 3 4

``` r
length(mat1)
```

    ## [1] 4

So it doesn't work like that: the `c` command flattens all the arguments it is given to build only **one** long vector. We have to use the function `matrix` to build a matrix:

``` r
mat1 = matrix(data=c(1,2,3,4), nrow=2, ncol=2)
mat1
```

    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4

Note that **by default R fills in the data structure by columns**: it fills up the first column with the first data and then proceeds to the second column with the remaining data, etc. This is beacause the default value for the `byrow` option of the `matrix` command is set to `FALSE` (see the manpage of `matrix`, e.g.~typing `?matrix` after the invite). To proceed row-wise, you must explicitly specify `byrow=T` (see our examples further below).

We said earlier that **vectorization is often implicit in R**. Here are some examples:

``` r
mat2 = matrix(data=5, nrow=2, ncol=3)
mat2
```

    ##      [,1] [,2] [,3]
    ## [1,]    5    5    5
    ## [2,]    5    5    5

``` r
mat3 = matrix(data=c(1,2), nrow=3, ncol=2, byrow=T)
mat3
```

    ##      [,1] [,2]
    ## [1,]    1    2
    ## [2,]    1    2
    ## [3,]    1    2

R automatically replicates the input data to pan to the size of the container (here, a 3x2 matrix).

A matrix is in fact a special form of vector: it has a length and a mode (and only one mode: try to mix strings and numbers in the same matrix and see what happens), but also an additional feature, its **dimension**, that one can query (and alter) through the function `dim`.

``` r
length(mat3)
```

    ## [1] 6

``` r
mode(mat3)
```

    ## [1] "numeric"

``` r
dim(mat3)
```

    ## [1] 3 2

``` r
dim(mat3) = c(1,6)
mat3
```

    ##      [,1] [,2] [,3] [,4] [,5] [,6]
    ## [1,]    1    1    1    2    2    2

Accessing elements from a matrix is done also with the usual square bracket notation:

``` r
mat4=matrix(data=1:20, ncol=5, byrow=T)
mat4
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    2    3    4    5
    ## [2,]    6    7    8    9   10
    ## [3,]   11   12   13   14   15
    ## [4,]   16   17   18   19   20

``` r
mat4[2,3]
```

    ## [1] 8

``` r
mat4[,3]
```

    ## [1]  3  8 13 18

``` r
mat4[1,]
```

    ## [1] 1 2 3 4 5

These last two commands are very important to understand. These are the first and simplest examples of **subsetting** that we see: here we extract the third column of `mat4`, and then its first row. In both cases the results are vectors. `mat4[,]` would simply give the entire `mat4`. All sorts of selection patterns can be used in combination.

For instance:

``` r
mat4[,2:4]
```

    ##      [,1] [,2] [,3]
    ## [1,]    2    3    4
    ## [2,]    7    8    9
    ## [3,]   12   13   14
    ## [4,]   17   18   19

Of course, as the resulting matrix is a new object, with no memory of the data container it originates from, indexing in it starts anew from 1.

Applying functions to variables with implicit vectorization
-----------------------------------------------------------

In R, the "modulo" operator (you know, that operator giving the remainder in the euclidean division of its two operands) is written `%%`. Its two operands (on its left and on its right) are expected to be numbers:

``` r
17 %% 5
```

    ## [1] 2

But in fact we can also use this operator to find out all the remainders modulo 2 from a matrix:

``` r
transformed = mat4 %% 2
transformed
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    0    1    0    1
    ## [2,]    0    1    0    1    0
    ## [3,]    1    0    1    0    1
    ## [4,]    0    1    0    1    0

``` r
sum(transformed)
```

    ## [1] 10

Fair enough: out of this matrix of 20 consecutive integers, 10 are odd numbers. The modulo operator has worked in a vectorized fashion: it has been applied to every element of its input, producing on output of same dimensionality. What's more, we can actually extract from `mat4` all its elements with zero remainder in the division by 3, with the single following selection command:

``` r
mat4[mat4 %% 3 == 0]
```

    ## [1]  6 12  3 18  9 15

As in most programming languages, **in R the boolean operator to test for equality is **`==`, obviously because `=` is one of the operators used for variable assignment. We are using it in the command above to select a subset of the indices in `mat4`, extracting from it the elements whose Euclidean division by 3 yields a zero remainder (i.e.~we are extracting the elements of `mat4` that are divisible by 3). Now let us try to use the same kind of selection pattern to count the number of A's and G's in a large matrix made of nucleotides. Our 10x42 matrix is made of repeated patterns of five nucleotides (A, C, A, T, G): there will be twice as many A's as any of the other three nucleotides.

``` r
mat5=matrix(c('A','C','A','T','G'),nrow=10,ncol=42,byrow=T)
mat5[1,] # just to check the first line...
```

    ##  [1] "A" "C" "A" "T" "G" "A" "C" "A" "T" "G" "A" "C" "A" "T" "G" "A" "C"
    ## [18] "A" "T" "G" "A" "C" "A" "T" "G" "A" "C" "A" "T" "G" "A" "C" "A" "T"
    ## [35] "G" "A" "C" "A" "T" "G" "A" "C"

``` r
mat5 == "G"  # vectorized comparison to "G"
```

    ##        [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11]
    ##  [1,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [2,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [3,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##  [4,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [5,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [6,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [7,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [8,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##  [9,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ## [10,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##       [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22]
    ##  [1,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [2,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [3,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [4,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [5,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##  [6,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [7,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [8,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [9,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##       [,23] [,24] [,25] [,26] [,27] [,28] [,29] [,30] [,31] [,32] [,33]
    ##  [1,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [2,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##  [3,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [4,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [5,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [6,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [7,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##  [8,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [9,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ## [10,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##       [,34] [,35] [,36] [,37] [,38] [,39] [,40] [,41] [,42]
    ##  [1,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [2,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [3,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [4,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ##  [5,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE
    ##  [6,] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
    ##  [7,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
    ##  [8,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
    ##  [9,]  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
    ## [10,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE

``` r
length(mat5[mat5=="G"])
```

    ## [1] 84

Note that the two boolean/logical values `TRUE` and `FALSE` are automatically translated into respectively 1 and 0 when forced in an arithmetic operation for instance the `sum` operation as illustrated below. This makes it extremely convenient to **count the number of elements in a vector that fulfill a given requirement**:

``` r
sum(mat5=="G")
```

    ## [1] 84

``` r
sum(mat5=="A") # correct result: 168 = 2 * 84
```

    ## [1] 168

\subsection{The logical selection scheme in R}
It is worth here commenting further about the selection scheme based on a test (i.e. an expression being evaluated into a boolean value or an array of boolean values, i.e.~an R object in *logical* mode) enclosed into square brackets that are appended to the name of a variable. While in the above examples the array we took a subset from (`mat4` or `mat5`) was also appearing in the selection pattern (e.g. `mat5[mat5=='G']`), this is not a constraint imposed by R. One can extract elements from a vector according to a criterion determined on some other vector, possibly unrelated to the first one. For example:

``` r
myvec = 1:20
filter = rep(c(T,F,F,T,F),4)      # logical vector unrelated to myvec\ldots
length(filter)                    # \ldots but with same size
```

    ## [1] 20

``` r
myvec[filter]
```

    ## [1]  1  4  6  9 11 14 16 19

Working with categorical variables: factors
-------------------------------------------

A **categorical** variable can take only a finite number of different values, usually from quite a small set. Examples are for instance: \* a nucleotide can be encoded as a categorical variable, taking one of four values represented e.g. with the four letters A,C,G and T; \* human blood groups are taken from the set {A,B,AB,O} (four categories or levels); \* from the Martin-Schultz scale, one could classify human iris colours in the seven following categories: amber, blue, brown, gray, green, hazel, red/violet; \* a question from survey could accept responses *high*, *medium* or *low* (three categories our levels); \* a disease allele can be either dominant or recessive (two categories or levels).

Please note that some categorical variables come with no specific logical ordering (e.g. human iris colors), while some other (we call them **ordinal** variables) do: for instance the high/medium/low categories.

In R, the different values a categorical variable can possibly have are called **levels**. Defining categorical variables is done through the `factor` function. One has to pay attention to the fact that this function is at the same time the instanciation of a vector and the declaration of the **type** of its elements. Possible values that would not exist in the specific vector we are declaring should be named through the argument called `labels`.

For a start, let us define the blood groups of 8 patients:

``` r
blood_groups = factor(c('A','B','A','B','A','O','AB','A'))
blood_groups
```

    ## [1] A  B  A  B  A  O  AB A 
    ## Levels: A AB B O

Please refer to the manpage for `factor`: in the example above we only use the first argument of this function (called `x`) in the manpage. Here it is a vector made of strings, but it could also have been a vector of integers. R automatically deduces the four possible levels for this categorical variable, as in this example at least one instance of each is present. The resulting variable, `blood_groups`, is a vector **plus** the information of the possible levels of the underlying categorical variable. Note the difference with:

``` r
blood_groups=c('A','B','A','B','A','O','AB','A')
blood_groups
```

    ## [1] "A"  "B"  "A"  "B"  "A"  "O"  "AB" "A"

In this latter example, `blood_groups` is simply a vector of strings, with no underlying idea of categories.

If we need to tell R that levels exist that are not present in the vector we define, we have to use the second argument of the `factor` function, called `labels` in its manpage:

``` r
blood_groups=factor(c('A','B','A'), levels=c('A','B','AB','O'))
blood_groups
```

    ## [1] A B A
    ## Levels: A B AB O

If we want to define **ordinal** data, we put the right ordering in the `levels` argument and set the boolean option `ordered` to `TRUE`. Note the informative way used by R to display that ordering along with the vector of categorical data:

``` r
responses = factor(c('low','low','high','low'), levels=c('low','med','high'), ordered=T)
responses
```

    ## [1] low  low  high low 
    ## Levels: low < med < high

To sum it up, let us remember that factors are some kind of vectors that contain the information relative to the possible levels or categories. The function `levels` gives you direct access to these.

Data frames
-----------

Data frames are complex data containers in R. While vectors (and their matrix derivatives) cannot store data of different types (try to build `c(1,2,"three")`), data frames can sotre different types of data in different **fields** (i.e.~different columns). To get our first example of a data frame, and as we don't know yet how to import data from our data files, we load some data readily available in R through the variable called `iris`. These are observations of a number of plant specimens, all belonging to the *Iris* genus. For each specimen, geometrical features of the petal and sepal are recorded, as well as its classification name at the species level. As this data frame is rather large, typing `iris` on the commandline dumps the whole dataframe to the screen in a rather inconvenient way. Let us introduce the very useful and very versatile function `str` (for "structure") that provides insight on the structure of just any R object:

``` r
str(iris)
```

    ## 'data.frame':    150 obs. of  5 variables:
    ##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
    ##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
    ##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
    ##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
    ##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

``` r
# and to get all the levels associated to the Species field:
levels(iris$Species)
```

    ## [1] "setosa"     "versicolor" "virginica"

We learn that the `iris` variable is of type `data.frame` and contains 150 observations (**records** or rows) or 5 variables (**fields** or columns). The first four fields contain numeric variables and are named `Sepal.Length`, `Sepal.Width`, `Petal.Length` and `Petal.Width`, while the fifth field contains a categorical variable being the name of the species. We are told that only three different species (and thus 3 different levels) exist in the dataset: *Iris setosa*, *Iris versicolor* and *Iris virginica*. To get all the information relative to the levels of the field named `Species`, we type `levels(iris$Species)`: the dollar sign is used to designate a field of a data frame. Besides the information concerning the size of the data container, field names, type of data, etc, `str` displays the first values found in every field. Note that the internal representation of categorical variables by R may rely on integers. These are not to be typed in by the user but gives you an idea of how efficient categorical variable storage is in R.

Another useful and versatile function to have a glance at a complex set of data is `summary`, which gives an account of the distribution of categorical variables as well as a basic statistical summary of all numerical variables:

``` r
summary(iris)
```

    ##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
    ##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
    ##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
    ##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
    ##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
    ##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
    ##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
    ##        Species  
    ##  setosa    :50  
    ##  versicolor:50  
    ##  virginica :50  
    ##                 
    ##                 
    ## 

### Taking subsets out of a data frame

As we have already seen, the dollar sign is used to designate a field from a data frame:

``` r
iris$Sepal.Length
```

    ##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
    ##  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
    ##  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
    ##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8
    ##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
    ##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
    ## [103] 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
    ## [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
    ## [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9

Note that we could also use the good old square bracket notation to select that column: a data frame resembles a matrix where column are not designated with their indices, but with names (strings of characters):

``` r
iris[,'Sepal.Length']
```

    ##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
    ##  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
    ##  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
    ##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8
    ##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
    ##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
    ## [103] 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
    ## [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
    ## [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9

Selecting a range of lines works, as the lines (or records) in a data frame are numbered:

``` r
iris[50:54,]
```

    ##    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
    ## 50          5.0         3.3          1.4         0.2     setosa
    ## 51          7.0         3.2          4.7         1.4 versicolor
    ## 52          6.4         3.2          4.5         1.5 versicolor
    ## 53          6.9         3.1          4.9         1.5 versicolor
    ## 54          5.5         2.3          4.0         1.3 versicolor

What if we now want to select some of the records (lines), based on some test(s) on their content? Below we extract all the records (i.e. lines, corresponding to specimens) for which the length of the sepal is at least 7.7. Note that nothing follows the comma enclosed in the square brackets: we select all columns.

``` r
iris[iris$Sepal.Length>=7.7,]
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ## 118          7.7         3.8          6.7         2.2 virginica
    ## 119          7.7         2.6          6.9         2.3 virginica
    ## 123          7.7         2.8          6.7         2.0 virginica
    ## 132          7.9         3.8          6.4         2.0 virginica
    ## 136          7.7         3.0          6.1         2.3 virginica

Selecting lines with criteria calculated among several columns is also possible. Below we select all the records where the sepal length is greater or equal than 7.7 AND the petal length is strictly greater than 6.5. The logical AND operator is written `&`, while the logical OR is `|` and the logical NOT writes `!` (prepended):

``` r
b <- iris[iris$Sepal.Length>=7.7 & iris$Petal.Length>6.5,]
b
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ## 118          7.7         3.8          6.7         2.2 virginica
    ## 119          7.7         2.6          6.9         2.3 virginica
    ## 123          7.7         2.8          6.7         2.0 virginica

Note that the resulting object is still a data frame, where the original **names** of the records have remained:

``` r
is.data.frame(b)
```

    ## [1] TRUE

``` r
b[1,]
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ## 118          7.7         3.8          6.7         2.2 virginica

``` r
b['123',]
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ## 123          7.7         2.8          6.7           2 virginica

``` r
b[,2]
```

    ## [1] 3.8 2.6 2.8

Here we see an interesting feature of data frames: their records (lines) and fields (columns) are usually named with character strings, but integer indices are still usable to address elements. If we want to get only a subset of all columns in our resulting data frame, we use the `subset` function:

``` r
subset1 = subset(iris, Sepal.Length==5.1, select=Sepal.Width)
subset1
```

    ##    Sepal.Width
    ## 1          3.5
    ## 18         3.5
    ## 20         3.8
    ## 22         3.7
    ## 24         3.3
    ## 40         3.4
    ## 45         3.8
    ## 47         3.8
    ## 99         2.5

Above, the second argument of `subset` is the boolean selection operator, while the third argument (`select`) trims columns out of the output.

``` r
subset1 = subset(iris,abs(Sepal.Length-5)<=0.1,select=c('Sepal.Length','Sepal.Width'))
subset1
```

    ##     Sepal.Length Sepal.Width
    ## 1            5.1         3.5
    ## 2            4.9         3.0
    ## 5            5.0         3.6
    ## 8            5.0         3.4
    ## 10           4.9         3.1
    ## 18           5.1         3.5
    ## 20           5.1         3.8
    ## 22           5.1         3.7
    ## 24           5.1         3.3
    ## 26           5.0         3.0
    ## 27           5.0         3.4
    ## 35           4.9         3.1
    ## 36           5.0         3.2
    ## 38           4.9         3.6
    ## 40           5.1         3.4
    ## 41           5.0         3.5
    ## 44           5.0         3.5
    ## 45           5.1         3.8
    ## 47           5.1         3.8
    ## 50           5.0         3.3
    ## 58           4.9         2.4
    ## 61           5.0         2.0
    ## 94           5.0         2.3
    ## 99           5.1         2.5
    ## 107          4.9         2.5

Here we use the `subset` command to extract the specimens with a sepal length less than 0.1 away from 5.0, and on these we select only the two columns relative to sepal dimensions.

Combining rows and columns
--------------------------

In R, two very generic commands exist that allow you to combine data row-wise or column-wise. They are called respectively `rbind` and `cbind`. With `cbind` you may for instance add an additional column to a dataframe. With `rbind` you could for instance concatenate the records of two similar arrays of data into a single one. Let's start with a simple example, say you want to add as a first column of the dataframe `iris` random id numbers for every specimen. We will use the random number generation function `runif`, with no guarantee not to get duplicates, though. On the first line below, `runif(150, min=1, max=100000` generates a series of 150 numbers from the uniform probability distribution on the interval \[1, 100000\]. Of these random numbers, `floor` gives the numerical floor (largest integer value no greather than). We then combine this new column with the existing `iris` data frame:

``` r
my_column = floor(runif(150, min=1, max=100000))
cbind(my_column, iris) -> iris2
str(iris2)
```

    ## 'data.frame':    150 obs. of  6 variables:
    ##  $ my_column   : num  28218 33006 33372 68180 27979 ...
    ##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
    ##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
    ##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
    ##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
    ##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

Pay attention that the additional column is automatically named by the name of the source. You can always alter the column names later on, accessing these by the `names()` function, which can be use to output **or** to input the names:

``` r
names(iris2) -> oldnames
oldnames[1] <- "ID"
names(iris2) <- oldnames
```

You can add additional rows to an existing dataframe with `rbind`, for instance adding the column averages to any dataframe made of numeric values:

``` r
av1 = mean(iris2[,1]);av2=mean(iris2[,2])
av3=mean(iris2[,3]);av4=mean(iris2[,4]);av5=mean(iris2[,5])
av6=names(which.max(table(iris2[,6]))) # # to get the most common category in this factor
rbind(iris2,c(av1,av2,av3,av4,av5,av6)) -> iris3
tail(iris3, n=2)
```

    ##           ID     Sepal.Length      Sepal.Width Petal.Length
    ## 150    43864              5.9                3          5.1
    ## 151 50689.34 5.84333333333333 3.05733333333333        3.758
    ##          Petal.Width   Species
    ## 150              1.8 virginica
    ## 151 1.19933333333333    setosa

So it seems that we are fine: the line containing the average values of all the columns has been added at the bottom of the dataframe. But let's look at the structure of our new `iris3` variable:

``` r
str(iris3)
```

    ## 'data.frame':    151 obs. of  6 variables:
    ##  $ ID          : chr  "28218" "33006" "33372" "68180" ...
    ##  $ Sepal.Length: chr  "5.1" "4.9" "4.7" "4.6" ...
    ##  $ Sepal.Width : chr  "3.5" "3" "3.2" "3.1" ...
    ##  $ Petal.Length: chr  "1.4" "1.4" "1.3" "1.5" ...
    ##  $ Petal.Width : chr  "0.2" "0.2" "0.2" "0.2" ...
    ##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

What happened here? Furtively, all the numeric variables have been converted to string (values of mode "character"). This is very interesting to explain here, as it draws from the differencies between data types in R.

First of all, we have to be aware that **vectors** (built for instance through the use of the `c` command) **cannot contain mixed data types**. Whenever one wants to build a vector from data of different modes, R automatically coerce some of the data to the most generic mode (usually the "character" mode as lots of basic objects accept conversion to strings by means of the `as.character()` function). For instance, here:

``` r
mode(av1)
```

    ## [1] "numeric"

``` r
mode(av6)
```

    ## [1] "character"

``` r
av1
```

    ## [1] 50689.34

``` r
c(av1,av2,av3,av4,av5,av6) -> last_row
last_row
```

    ## [1] "50689.34"         "5.84333333333333" "3.05733333333333"
    ## [4] "3.758"            "1.19933333333333" "setosa"

``` r
mode(last_row)
```

    ## [1] "character"

`last_row`, as an R vector, has only one single mode: here it is made of strings. Very logically then, when we used `rbind` to concatenate this row to the `iris2` table, the contagion spread to the dataframe because we were adding character values to columns formerly of numeric mode.

Data input/output in R: from/to files
=====================================

Most frequently your work session with R will start with importing some data from a datafile that you have somewhere on your computer. We are going to see how to build an R object from a file, filling the object (it will be that data structure R calls a **table**) with the data present in that file.

Current working directory
-------------------------

Whenever R is running, it has an internal variable indicating where is its **current working directory**. If you invoked R from a shell, it will usually be the current working directory of the shell at the moment when you launched R. Otherwise it can be your home directory, or any other directory where R has read and write permissions. You may check what is R's current working directory with the function `getwd()`:

``` r
getwd()      # obviously you will get a different value here...
```

    ## [1] "/home/jbde/Trainings/R_material_github"

``` r
mydir = getwd()
```

The current working directory may be set to some other value through the `setwd` command:

``` r
setwd("~")      # setting it to my home directory...
getwd()
```

    ## [1] "/home/jbde"

``` r
setwd(mydir)    # setting the current directory back to original value
```

Whenever you specify some filename during your R session, R will search for that file **from the current working directory**, unless of course you give it in the form of an **absolute path** (i.e. starting at the root of the filesystem, with an initial slash `/`). So if you just give the name of a file (and not an absolute or relative path), R will expect to find the file you're talking about in its current working directory. This is also where it will write files.

The generic `read.table` function
---------------------------------

Although there are several specific R functions to read data from files, these are nothing but static refinements of the generic `read.table` function. We will thus focus on this latter only. It is meant to read data from a file, according to some specifications (whether there is a header line, what is the field separator, etc) and writes the content into an R object called a **data frame**.

As a first example of input file, let us take the file `fev_dataset.txt` provided along with this tutorial. This file contains 655 lines (one header line and 654 records). We reproduce below its first 6 lines (for those who want to know, the shell command to get this is `head -n 6 fev_dataset.txt`):

> Age FEV Ht Gender Smoke
> 9 1.7080 57.0 0 0
> 8 1.7240 67.5 0 0
> 7 1.7200 54.5 0 0
> 9 1.5580 53.0 1 0
> 9 1.8950 57.0 1 0

Each line comprises 5 fields:

1.  age in years,
2.  FEV (Forced Expiratory Volume) expressed in liters,
3.  height in inches,
4.  gender (boys are coded 1, girls 0),
5.  whether the kid is exposed to smoking in its family environment (also a binary 0/1 variable).

This dataset comes from a study originally performed by Rosner and colleagues to find out whether constant exposure to an environment where at least one of the parents is smoking had an impact on the respiratory capacity of young boys and girls. Or course, the age and height of a child are expected to play a significant role in the determination of the pulmonary capacity of that same child, hence the presence of these variables among the data collected.

Let us first try and use the simplest form of the function `read.table`:

``` r
read.table("fev_dataset.txt") -> dat1
```

Okay, we have read the contents of the file and have stored it into a new **data frame** we called `dat1`. As R keeps silent after this, let us check that this worked as expected. As two exploratory content-checking commands, you may use `head` (to first items of a data structure) or `str` (to get an informative output concerning the internal structure of the object you query):

``` r
is.data.frame(dat1)
```

    ## [1] TRUE

``` r
head(dat1)
```

    ##    V1     V2   V3     V4    V5
    ## 1 Age    FEV   Ht Gender Smoke
    ## 2   9 1.7080 57.0      0     0
    ## 3   8 1.7240 67.5      0     0
    ## 4   7 1.7200 54.5      0     0
    ## 5   9 1.5580 53.0      1     0
    ## 6   9 1.8950 57.0      1     0

``` r
str(dat1)
```

    ## 'data.frame':    655 obs. of  5 variables:
    ##  $ V1: Factor w/ 18 levels "10","11","12",..: 18 17 16 15 17 17 16 14 14 16 ...
    ##  $ V2: Factor w/ 576 levels "0.7910","0.7960",..: 576 84 91 90 48 127 232 133 25 149 ...
    ##  $ V3: Factor w/ 57 levels "46.0","46.5",..: 57 21 43 16 13 21 29 23 19 24 ...
    ##  $ V4: Factor w/ 3 levels "0","1","Gender": 3 1 1 1 2 2 1 1 1 1 ...
    ##  $ V5: Factor w/ 3 levels "0","1","Smoke": 3 1 1 1 1 1 1 1 1 1 ...

Now, that's **bad**: R has seen a file of 655 records, not noticing that the first line is actually not a data record, but the header containing the names of the different fields (or columns). Instead R used an automatic naming convention, dubbing the columns `V1`, `V2`, etc. Notice it automatically adds row-naming numbers, also.

The output of the `str` function is even more informative: we see that as R had to fit into the same column some textual data (coming from the header) and some numerical data as well (the measurement datapoints), it interpreted everything to be categorical variables represented as strings. To correct this, we have to tell R that the first line of the file should not be considered as a data record but as a header, thus giving the names of the columns. This is done through the `header` option that we set to `TRUE`:

``` r
read.table("fev_dataset.txt", header=TRUE) -> dat1
head(dat1)
```

    ##   Age   FEV   Ht Gender Smoke
    ## 1   9 1.708 57.0      0     0
    ## 2   8 1.724 67.5      0     0
    ## 3   7 1.720 54.5      0     0
    ## 4   9 1.558 53.0      1     0
    ## 5   9 1.895 57.0      1     0
    ## 6   8 2.336 61.0      0     0

``` r
str(dat1)
```

    ## 'data.frame':    654 obs. of  5 variables:
    ##  $ Age   : int  9 8 7 9 9 8 6 6 8 9 ...
    ##  $ FEV   : num  1.71 1.72 1.72 1.56 1.9 ...
    ##  $ Ht    : num  57 67.5 54.5 53 57 61 58 56 58.5 60 ...
    ##  $ Gender: int  0 0 0 1 1 0 0 0 0 0 ...
    ##  $ Smoke : int  0 0 0 0 0 0 0 0 0 0 ...

All is fine now, as R correctly detected that the records contain numerical values. If we really want to insist that the `Gender` and `Smoke` variable be treated as categorical, we can force the use of specific classes (or "types") for the different columns (the backslach character at the end of a commandline is just to indicate that the said line continues uninterrupted onto the next: the line break was necessary only to fit the line into this pagewidth):

``` r
read.table("fev_dataset.txt", header=TRUE, colClasses=c("integer","numeric","numeric","factor","factor")) -> dat1
str(dat1)
```

    ## 'data.frame':    654 obs. of  5 variables:
    ##  $ Age   : int  9 8 7 9 9 8 6 6 8 9 ...
    ##  $ FEV   : num  1.71 1.72 1.72 1.56 1.9 ...
    ##  $ Ht    : num  57 67.5 54.5 53 57 61 58 56 58.5 60 ...
    ##  $ Gender: Factor w/ 2 levels "0","1": 1 1 1 2 2 1 1 1 1 1 ...
    ##  $ Smoke : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...

### Field separator

It is important to consider that within your original file, some characters mark the boundary between one field and the following, within one record. These can be for instance tabulation characters (usually notated `\t`), any number of consecutive white spaces, commas (`,`), semicolons (`;`) or colons (`:`). By default `read.table`'s field separator is any "white space", which means one or more spaces, tabs, newlines or carriage returns. In case this is not suitable for your input file, you have to specify the correct field separator by means of the `sep` option: for a regular CSV file (Comma-Separated Values), you would specify `sep=","` as an option to `read.table`.

### Decimal separator

Also important to consider is the decimal separator in use for numerical data in your original datafile. Most people around the world use the dot (`.`) as the decimal point, but you are not without knowing that the convention in French-speaking countries is to have the comma (`,`) as the decimal point. Such an encoding would be correctly handled by R during importation when the user specifies the decimal point through the `sep` option, e.g.~`sep=","`.

### Unknown or missing values

Sometimes your file contains missing values, for instance if you have two consecutive commas (`,,`) in a CSV file using the comma as a field separator. R understand this and uses a special token called `NA` to encode missing values. Sometimes the people who prepared the datafile also use another predefined token to indicate missing values, for instance "Na", "na" or "n/a". In order for R to translate these strings into its proper `NA` values, you have to indicate the possible NA-coding strings by means of the `na.strings` option. For instance:

``` r
read.table("myfile.txt", header=TRUE, sep=",", na.strings=c("na", "n/a"))
```

In this case any value completely missing (two consecutive field separators), as well as any string "na" or "n/a" as a field value, will be understood by R as a missing value and translated into the unique appropriate R token `NA`.

Data output: writing into a file
--------------------------------

Once you want to write some tabulated data (e.g.~a vector, matrix or data frame) from R right into a file in your filesystem, you may use the `write.table` function. For instance, to write the content of an R data frame called `mydata` in your current working session into a file that you wawnt to call `myfile` and write into your current working directory, you will use:

``` r
write.table(mydata, file="myfile")
```

In this case, the file will be written using the default field separator for `write.table`, which is a single space character. You may explore the different formatting options by calling the help of `write.table`. Most of them are the equivalent of what you can find for the reciprocal `read.table` function.

Caution when importing Excel format into R!
-------------------------------------------

While many people use an advanced spreadsheet software (e.g. LibreOffice Calc, Apache OpenOffice Calc or Microsoft Excel) to prepare their data, unfortunately it is not possible to read data into R directly from any of the `.odt`, `.xls` or `.xlsx` formats. This is mainly because these formats are meant to accomodate complex data in several sheets, which possibly cannot fit into one single R object. When you want to import some data from such a format, you first have to convert it into some CSV format (notice that the field separator can be any other character of your choice, not necessarily a comma), using your favourite spreadsheet software. You will then be able to read the simpler CSV format into R with the `read.table` function.

For instance, after having transformed the file `tutorial_data.xlsx` into a comma-separated file that you call `tutorial_data_commasep.csv`, you would load in into a `mydat` data frame in your R session using the following command (the backslach character at the end of a commandline is just to indicate that the said line continues uninterrupted onto the next: the line breaks were necessary only to fit the lines into this pagewidth):

``` r
mydat=read.table("tutorial_data_commasep.csv",
                   header=T,
                   sep=",",
                   colClasses=c("integer","factor","integer","numeric","factor",
                                "numeric","factor","integer","factor","factor"))    
```

The above (converting into text-formatted CSV file in your third-party application and then reading this file into R) is what I strongly recommend when you want to import Excel data into R. However, there exists some add-on packages (e.g. *gdata*) that allow you to read .xls or .xslx files directly into R. You then have to pay attention to which of the spreadsheets you are actually reading (for a file can contain several spreadsheets), and of course that sheet must contain nothing but a data frame (though you have an option to skip some of the first lines). As an example application, the following interaction uses the *gdata* supplementary package to load the contents of the first sheet of a .xlsx file into a R new data frame that we call `mydat2`:

``` r
if (!require("gdata")) {
  # download and install the package only if not yet installed on your system (will be done only once)
  install.packages("gdata", repos="http://cran.mirror.ac.za/", quiet=TRUE)
  library(gdata)              # actually *loading* the installed library
}
```

    ## Loading required package: gdata

    ## gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.

    ## 

    ## gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.

    ## 
    ## Attaching package: 'gdata'

    ## The following object is masked from 'package:stats':
    ## 
    ##     nobs

    ## The following object is masked from 'package:utils':
    ## 
    ##     object.size

    ## The following object is masked from 'package:base':
    ## 
    ##     startsWith

``` r
mydat2 = read.xls("tutorial_data.xlsx", sheet=1, header=TRUE)
str(mydat2)                 # just a quick check... 
```

    ## 'data.frame':    3109 obs. of  10 variables:
    ##  $ RANDID  : int  6238 11252 11263 12806 14367 16365 16799 23727 24721 33077 ...
    ##  $ SEX     : int  2 2 2 2 1 1 2 2 2 1 ...
    ##  $ AGE     : int  58 58 55 57 64 55 62 53 51 60 ...
    ##  $ SYSBP   : num  108 155 180 110 168 ...
    ##  $ CURSMOKE: int  0 1 0 1 0 0 0 0 1 1 ...
    ##  $ BMI     : num  28.5 24.6 31.2 22 25.7 ...
    ##  $ educ    : int  2 3 2 2 1 1 1 3 2 3 ...
    ##  $ CIGPDAY : int  30 20 30 0 18 0 10 0 0 0 ...
    ##  $ DEATH   : int  0 0 0 0 0 1 0 0 0 0 ...
    ##  $ DIABETES: int  0 0 0 0 0 0 0 0 0 0 ...

Sanity checks
-------------

As soon as you have imported some data into R, you should immediately perform some sanity checks, in order to check that the importation ran smoothly and as expected. I suggest that you check the content and structure of the resulting R object `mydat` with the commands `head` and `str`. One additional important thing to check is the length of your data, in terms of how many datapoints your data frame contains.

You already know that `str` gives you that information:

``` r
str(mydat)
```

    ## 'data.frame':    3109 obs. of  10 variables:
    ##  $ RANDID  : int  6238 11252 11263 12806 14367 16365 16799 23727 24721 33077 ...
    ##  $ SEX     : Factor w/ 2 levels "1","2": 2 2 2 2 1 1 2 2 2 1 ...
    ##  $ AGE     : int  58 58 55 57 64 55 62 53 51 60 ...
    ##  $ SYSBP   : num  108 155 180 110 168 ...
    ##  $ CURSMOKE: Factor w/ 2 levels "0","1": 1 2 1 2 1 1 1 1 2 2 ...
    ##  $ BMI     : num  28.5 24.6 31.2 22 25.7 ...
    ##  $ educ    : Factor w/ 4 levels "1","2","3","4": 2 3 2 2 1 1 1 3 2 3 ...
    ##  $ CIGPDAY : int  30 20 30 0 18 0 10 0 0 0 ...
    ##  $ DEATH   : Factor w/ 2 levels "0","1": 1 1 1 1 1 2 1 1 1 1 ...
    ##  $ DIABETES: Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...

Now there is another way to check for the length of a vector, and you already know it: the `length` function.

``` r
length(mydat)     # Beware! This gives the number of **fields** in mydat!
```

    ## [1] 10

``` r
length(mydat$BMI) # The correct way to query the number of records
```

    ## [1] 3109

``` r
nrow(mydat)       # An alternative, simpler way to query the number of records
```

    ## [1] 3109

Notice the way we name the vector corresponding to one of the columns of a data frame, using the dollar ($) symbol : `mydata$BMI` is the Body Mass Index column from the original data. Of course, for the purpose of getting the data length we could have chosen any other column from this data frame.

You may also check that the data has been imported into R with the correct type:

``` r
class(mydat$SEX)
```

    ## [1] "factor"

``` r
class(mydat$BMI)
```

    ## [1] "numeric"

``` r
class(mydat$RANDID)
```

    ## [1] "integer"

**Note (advanced):** the `class` and `mode` functions differ slightly. Provided with some data, `mode` replies giving its internal storage mode. Because R finds it convenient to store factors (i.e.~categorical variables) as numeric vectors, `mode` replies `"numeric"` when asked about categorical variables. So one should remember that `class` is more of a high-level function than `mode`:

``` r
class(mydat$DEATH)
```

    ## [1] "factor"

``` r
mode(mydat$DEATH)
```

    ## [1] "numeric"

First graphical representations: histograms, curves, boxplots, piecharts
========================================================================

Histograms
----------

It is extremely straightforward to get the histogram corresponding to a vector of numerical values. For instance, to get the distribution of all the BMI values for our 3,109 observations:

``` r
hist(mydat$BMI)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-53-1.png)

In fact the `hist` function is a combined one: it first builds an R object of class "histogram", and then optionally draws its graphic representation (`hist` has an option `plot` that is set to `TRUE` by default. If set to `FALSE`, the object is built but nothing gets drawned on R's graphical output. To have a quick look at the contents of the *histogram* object, you may try the following:

``` r
hist1 = hist(mydat$BMI,plot=F)
class(hist1)
```

    ## [1] "histogram"

``` r
str(hist1)
```

    ## List of 6
    ##  $ breaks  : num [1:11] 10 15 20 25 30 35 40 45 50 55 ...
    ##  $ counts  : int [1:10] 2 144 1287 1267 335 57 12 4 0 1
    ##  $ density : num [1:10] 0.000129 0.009263 0.082792 0.081505 0.02155 ...
    ##  $ mids    : num [1:10] 12.5 17.5 22.5 27.5 32.5 37.5 42.5 47.5 52.5 57.5
    ##  $ xname   : chr "mydat$BMI"
    ##  $ equidist: logi TRUE
    ##  - attr(*, "class")= chr "histogram"

In this specific case, R has chosen to classify the data into 10 bins (hence 11 breaks). `hist1$mids` contains the reprensentative values of each of the bins (simply their midpoints), and the boolean variable `equidist`, set to `TRUE`, tells us that the bins are evenly spaced. `hist1$counts` contains the counts corresponding to the bins (i.e. the number of datapoints falling into each of the bins), and `hist1$density` contains some values that are akin to a probability density. Indeed, you may verify that `sum(hist1\$density * (hist1\$breaks[2] - hist1\$breaks[1])) == 1`: the second operand in this multiplication is the width of a bin, so that the result of the multiplication is the area of a rectangle, and the result of the `sum` is the total area under the histogram when it is drawn with its option `freq` set to `FALSE` (see below).

You can see that in the previous histogram R automatically labelled the y-axis with *Frequency*: the heights of the rectangles in the histogram are **raw datapoint counts**. If you want to draw a histogram whose AUC (area under the curve) is equal to 1, and thus compare it with a probability distribution, you have to specify that you want to draw `hist$density` instead of `hist$counts`. This is done with the option `freq=F`:

``` r
plot(hist1, freq=F, main="My first histogram", xlab="BMI value")
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-55-1.png)

In the above I also introduced two of the standard options for plots. You may want to play with a couple of them, in any plot you will get to produce:

-   `main`: the main title of the graphics
-   `xlab`: the text label corresponding to the x-axis
-   `ylab`: the text label corresponding to the y-axis
-   `xlim`: a vector of two values being the lower and upper limits corresponding to the x-axis, e.g.~`xlim=c(0,100)`
-   `ylim`: a vector of two values being the lower and upper limits corresponding to the y-axis, e.g.~`ylim=c(0,100)`
-   `col`: the colour to use when drawing the plot, e.g.~`col="red"`
-   `type`: the type of plot, e.g~`type="p"` to draw points, `type="l"` to draw lines
-   `pch`: the symbol or character to use when plotting points, e.g. `pch=20` for filled bullets, `pch=3` for +'s
-   `lty`: the type of lines to be drawn, e.g.~`lty=1` for a solid line, `lty=2` for dahsed lines, `lty=3` for dots
-   `lwd`: the line width or thickness as an integer number, defaulting to `lwd=1` for standard thickness

You will get tons of help about the graphical parameters accepted by the plotting functions asking `?par` on the commandline.

Curves and function graphs
--------------------------

You may want to draw e.g. the sine function between 0 and 2*π*:

``` r
plot(sin,xlim=c(0,2*pi))
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-56-1.png)

R automatically guesses the best boundary values for the y-axis. Besides, it already knows the `sin` function and the constant *π*. Easy. Now let's say you want to draw the behaviour of a more complex function, e.g.~2*x*sin(*x*) on a larger interval:

``` r
plot(2*x*sin(x), xlim=c(0,10))
```

    ## Error in plot(2 * x * sin(x), xlim = c(0, 10)): object 'x' not found

Indeed, R tries to find the variable `x`, unsuccessfully. You have to specify it and then ask R to draw what is in fact a series of points for which you give the two separate vectors of x and y coordinates in the form `plot(x,y)`. To do so, we prepare a regular sampling of the interval of interest using a **sequence** (cf.~chapter , page ):

``` r
x = seq(from=0, to=10, by=0.05)
plot(x, 2*x*sin(x), xlim=c(0,10))
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-58-1.png)

**Note (advanced):** another way to do the same thing is to create a new R function and then plot it using the same symbolic syntax as for the simple sine function above.

``` r
myfun = function(x) { 2*x*sin(x) }    # creates a function as a new R object
plot(myfun, xlim=c(0,10))             # and then plots it on [0,10]
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-59-1.png)

### Superimposing graphs

By default any call to any `plot` function (and here we say "any" because internally there are various `plot` functions, for instance objects of class *diagram* are in fact drawn by a function named `plot.histogram`) erases the previous content of R's graphics window and draws a brand new plot. If you want to superimpose two curves, you can do the following:

1.  draw the first function with the high-level function `plot`;
2.  and then add to the previous graph a second curve by means of the low-level `curve` function with the option `add=TRUE`. The first argument to `curve` is an expression in which `x` will be understood as the dummy variable, i.e.~the one corresponding to the x-axis.

Below we draw two curves on the same graph, with different colours:

``` r
plot(sin, xlim=c(0,10), ylim=c(-15,15))
curve(2*x*sin(x), from=0, to=10, col="red", add=TRUE)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-60-1.png)

Boxplots
--------

Boxplots are also called box-and-whisker plots. They give a concise graphical representation of some of the features of the distribution of a numerical data vector. Please notice first that you may get a non-graphical summary with the function `summary`:

``` r
summary(mydat$BMI)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   14.43   23.10   25.38   25.77   27.87   56.80

This gives you (in this case, for the vector of data collected as Body Mass Indices):

-   the minimum value found in the whole vector (`Min.`);
-   the first quartile (`1st Qu.`): the value below which lies the lower 25% of the data;
-   the median value: this is the value splitting the order dataset into two halves of equal count;
-   the mean value: this is the arithmetic average of the data;
-   the third quartile (`3rd Qu.`): the value beyond which lies the upper 25% of the data;
-   the maximum value found in the whole vector (`Max.`).

Notice that when you are only interested in the min and max values, you may simply call the `range` function, e.g. `range(mydat$BMI)`.

Now R can easily produce the boxplot for you:

``` r
boxplot(mydat$BMI)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-62-1.png)

In such a boxplot, the box represents the inter-quartile range (IQR), expanding vertically from the first to the third quartile. The thick line inside the IQR is the median and the two whiskers extend above and below by 1.5 times the IQR. Above the upper whisker and below the lower whisker, the outliers are plotted as points. These are the datapoints that either are bigger than the 3<sup>rd</sup> quartile plus 1.5 IQR or smaller than the 1<sup>st</sup> quartile less 1.5 IQR.

``` r
nrow(subset(mydat,SEX=="1"))   # records corresponding to boys
```

    ## [1] 1304

``` r
nrow(subset(mydat,SEX=="2"))   # records corresponding to girls
```

    ## [1] 1805

``` r
boxplot(BMI ~ SEX, data=mydat, ylab="Body Mass Index", names=c("boys (n=1304)","girls (n=1805)"), varwidth=T)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-63-1.png)

In the command above, the first argument to the `boxplot` function is an R **formula**. It tells R that it has to segregate the `BMI` data points according to the value of the (categorical) variable `SEX`. The resulting plot will show as many boxes as there are levels for the categorical variable according to which the segregation into groups is performed (in other terms, we get one box per population group). Notice that the use of `varwidth=T` enforces that the width of the boxes be proportional to the square root of the corresponding group sizes. You may calculate these *n* and explicitly write them as labels on your graph, as shown here.

The take-home message from this pair of boxplots could be that there is a slightly bigger variability BMI-wise in the group of girls than in the group of boys (larger IQR and more outliers in the group of girls). At the same time, the girls have a slightly lower mean BMI. In both groups, it is more common to find overweight or obese individuals than underweight (this is made graphically obvious by the distribution of outliers, which are almost all in the upper tail of the distribution of BMI values).

Displaying categorical data
---------------------------

In this section we will be going through different ways to represent categorical data. For this purpose we will use the `educ` column from our dataset. This variable can take one of four categories (or levels) which are coded as follows:

1.  0-11yrs
2.  high school
3.  some college/vocational school
4.  university degree obtained

We will also take advantage of this section to present the way to build and incorporate legends in our R graphics.

### Bar graphs

``` r
barplot(mydat$educ)    # wrong attempt...
```

    ## Error in barplot.default(mydat$educ): 'height' must be a vector or a matrix

``` r
summary(mydat$educ)    # getting the vector of the counts for each level
```

    ##    1    2    3    4 
    ## 1273  962  542  332

``` r
barplot(summary(mydat$educ), ylim=c(0,1400), names.arg=c("0-11yrs", "high school", "college", "university graduate"))
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-64-1.png)

### Pie charts

Now this was nice enough, but let's say we prefer a piechart with fancy colours

``` r
educ_vec = summary(mydat$educ)
pie(educ_vec)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-65-1.png)

But we are not very happy with this result: we prefer to have four more vivid, non-white colours. Besides we want to get rid of the small ticks and numberings around the pie, and replace them with a legend box. For the sake of our eyes, we will rotate the pie counterclockwise by some 15 degrees. Finally, the whole picture will get framed.

``` r
pie(educ_vec, labels="", col=c("red3","blue","yellow2","green"), init.angle=15)
legend("topright", legend=c("0-11yrs", "high school", "college", "university graduate"), bty="n", pch=15, col=c("red3","blue","yellow2","green"))
box()
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-66-1.png)

The option `bty="n"` draws no box around the legend itself. Here the first argument `"topright"` places the legend in the upper right corner of the graph window. We could have indicated a pair of coordinates there. Finally, `pch=15` is the symbol corresponding to a filled square (see `?points`) and the same set of colours (given as a vector of strings) is used in the pie chart and in its legend. The list of predefined string-coded colours can be retrieved by invoking `colours()`.

Even fancier three-dimensional pie charts can be built using the `plotrix` additional package. If not already present on your system, additional packages can be installed via the command `install.packages` (you may get the list of already installed packages with `installed.packages()` or via the *Packages* tab in the lower right frame of your *RStudio* window).

``` r
if (!require("plotrix", quietly=T)) {
   # download and install the package only if not yet installed on your system (will be done only once)
    install.packages("plotrix", repos="http://cran.mirror.ac.za/", quiet=TRUE)
  library(plotrix) # making the functions from the package plotrix readily available for use in the rest of our session
}
pie3D(educ_vec, explode=0.1, labels=c("0-11yrs", "high school", "college", "university graduate"))
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-67-1.png)

The `explode` option is a numeric value indicating by how much the user wants to "explode" its 3D pie chart. But now that you are comfortable enough with R, you know that you may tweak your 3D pie further through a host of options you will learn about asking the help on the function `pie3D`, e.g.~typing `?pie3D`

Normal distributions and normality tests
========================================

A touch of probability theory
-----------------------------

The normal (or **Gaussian**\[^1\]) distribution defines this "bell curve" you can see everywhere in any book of stats. It has two parameters:

1.  a **location parameter**, being the true mean *μ* of the distribution. It is altogether the mean, the median and the mode of the distribution,
2.  a **scale parameter**, being the standard deviation *σ* of the distribution.

\[^1: after the name of the famous German mathematician, astronomer, physicist and geophysicist Carl Friedrich Gau{} (1777--1855). The early development of the theory and tools revolving around the concept of normal distributions also owes French mathematicians Abraham de Moivre (1667--1754) and Pierre-Simon de Laplace (1749--1827). To avoid controversy concerning the scientific paternity of this paramount statistical distribution, we stick to calling it **normal**.

The normal distribution with location parameter *μ* and scale parameter *σ* is notated 𝒩(*μ*, *σ*) or 𝒩(*μ*, *σ*<sup>2</sup>). In this latter case it is made explicit that the variance, and not its square root, is used as a parameter. The choice is up to the author. In R, normal distributions are always parameterized by their standard deviation *σ*, not by their variance *σ*<sup>2</sup>. The corresponding density is expressed as follows and displayed in figure :

    $$d_{\mathcal{N}(\mu,\sigma)}(x) = \frac{1}{\sigma\sqrt{2\pi}} \, e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$

\begin{figure}[ht]
\centering
\begin{subfigure}{.5\linewidth}
  \centering
  \includegraphics[width=\linewidth]{normal_density.pdf}
  \caption{density function (the derivative of the cdf)}
  \label{fig:normal_density}
\end{subfigure}%
\hspace*{3ex}
\begin{subfigure}{.5\linewidth}
  \centering
  \includegraphics[width=\linewidth]{normal_cdf.pdf}
  \caption{cumulative distribution function (an antiderivative of the density)}
  \label{fig:normal_cdf}
\end{subfigure}
    \caption{Density function and cumulative distribution function for the normal distribution. Pictured here is the normal distribution with mean $\mu=3$ and standard deviation $\sigma=1$.}
    \label{fig:normal_curves}
\end{figure}
A random variable with a Gaussian distribution is said to be normally distributed and is called a normal deviate. Note that the density function is symmetric with respect to the vertical line *x* = *μ*. Higher values of *σ* give flatter curves, with low values of *σ* yield sharp curves, with almost all the probability concentrated in a close neighbourhood of *μ*. In fact, it is easy to show that the breadth of the curve at half its peak height is equal to $\\sigma \\sqrt{8\\ln(2)} \\simeq 2.35\\, \\sigma$. When *μ* = 0 and *σ* = 1, we refer to the **standard normal distribution**, a.k.a.~**unit normal distribution**.

The cumulative distribution function for a normal distribution has the same shape as what mathematicians call the "error function". This shape has name a **sigmoid**. The slope around the mean of the distribution is increasingly steeper as *σ* → 0. The cumulative distribution function for 𝒩(3, 1) is pictured in figure .

Overlaying a normal curve on a histogram
----------------------------------------

In the remaining of this chapter we want to determine whether the data we have can be considered as distributed according to a normal distribution. In other terms, we want to know whether it is likely that these data have been produced by a stochastic process generating values according to a normal law. As a matter of fact, trying to answer such a question, we will never reach certainty. We will be satisfied with a "reasonable truth" or with a sufficiently high likelihood.

The best guess we can devise for a normal probability density corresponding to e.g.~`mydat$BMI` is the one of a normal distribution whose parameter (mean and standard deviation) are the ones of the sample itself:

``` r
m = mean(mydat$BMI) ; m    # the mean of our 3,109 observations
```

    ## [1] 25.77417

``` r
s = sd(mydat$BMI) ; s      # the std.dev. of our 3,109 observations
```

    ## [1] 4.013296

Now we are going to redraw the histogram we prepared in section and then overlay the density function of the normal curve whose parameters are calculated as above from our sample. We have to pay attention to the way we draw the histogram: we want to draw rectangles corresponding to a **density** (`freq=FALSE`), not to data counts aka.~frequencies (the default `freq=TRUE`). The normal density function is provided by the `dnorm` function: `dnorm(x,mean=m,sd=s)` is the value of the normal density with parameters *μ* =  `m` and *σ* =  `s` at abscissa `x`.

``` r
hist1 = hist(mydat$BMI, plot=F)    # only if you had lost this object en route...
plot(hist1, freq=F, main="Histogram + normal curve", xlab="BMI value", ylim=c(0,0.12))
curve(dnorm(x,mean=m,sd=s), add=T, col="red", lwd=2, from=10, to=60)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-69-1.png)

In case we are not fully satisfied with the graphical result, we may ask for more bins in the histogram, using the `breaks` option of the `hist` function:

``` r
hist2 = hist(mydat$BMI, breaks=21, plot=F)  # requesting exactly 21 bins
plot(hist2, freq=F, main="Histogram + normal curve", xlab="BMI value", ylim=c(0,0.12))
curve(dnorm(x,mean=m,sd=s), add=T, col="blue", lwd=2, from=10, to=60)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-70-1.png)

Testing for normality: the Shapiro-Wilk hypothesis test
-------------------------------------------------------

Although we may see from the histogram and its normal overlay that the BMI variable "seems to be" normally distributed, we may use more theoretically sound a procedure. We will use what is called the Shapiro-Wilk test of normality. Given any dataset *X* (i.e.~a vector of numerical values), this procedure tests the null hypothesis *H*<sub>0</sub> being "*X* is normally distributed" against the alternative hypothesis *H*<sub>1</sub>: "*X* **is not** normally distributed".

With any statistical test, the lower the p-value (i.e. the closer it gets to 0), the more likely we are to reject the null hypothesis. Conversely, the higher the p-value (i.e. the closer it gets to 1), the more likely we are to reject the alternative hypothesis and thus the more likely we are to trust the null hypothesis.

What it means with regard to the Shapiro-Wilk test is that **the greater the p-value, the more confident we are that the assumption of normality holds.** For our purpose, we can say that any p-value &gt;0.05 consolidates our belief that the tested data can be considered as normally distributed.

The Shapiro-Wilk test is called by means of the R function `shapiro.test`:

``` r
shapiro.test(mydat$BMI)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  mydat$BMI
    ## W = 0.96111, p-value < 2.2e-16

The p-value here is so low that it would be misleading to consider that the data `mydat$BMI` is normally distributed.

Because it is somewhat skewed to the left, the `mydat$SYSBP` variable also doesn't respond well to the test for normality:

``` r
shapiro.test(mydat$SYSBP)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  mydat$SYSBP
    ## W = 0.9684, p-value < 2.2e-16

``` r
hist(mydat$SYSBP)
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-72-1.png)

Well, some data can indeed be considered as normally distributed! Below we generate a vector of 150 values from the normal distribution with parameters `m` and `s` (those parameters corresponding respectively to the mean and standard deviation of `mydat$BMI`). This is achieved using the `rnorm` random generation function. We then test the resulting vector of datapoints with the Shapiro-Wilk test. The answer is positive: the p-value is very close to 1, and thus the data can indeed be considered as normal. Obviously, in the real world we do not generate data artificially from a normal distribution, but this works here as a proof of concept.

``` r
normvec=rnorm(150, mean=m, sd=s)
shapiro.test(normvec)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  normvec
    ## W = 0.98975, p-value = 0.345

Of course, this is just an example, and as you will generate your own `normvec` vector, you will get a different value for the p-value out of the Shapiro-Wilk test. Nevertheless, you should definitely get a p-value that is higher than 0.05, thus giving credit to the null hypothesis that the data `normvec` is normally distributed (and with good reason!).

Measuring correlations
======================

Correlation coefficients
------------------------

For two random variables *X* and *Y*, Pearson's correlation coefficient *ρ*<sub>*X*, *Y*</sub> is defined as follows:

$$\\rho\_{X,Y} = \\frac{cov(X,Y)}{\\sigma\_X \\sigma\_Y} = \\frac{\\mathbb{E}\\left\[(X-\\mathbb{E}(X)) (Y-\\mathbb{E}(Y))\\right\]}{\\sigma\_X \\sigma\_Y}$$

where 𝔼 is the operator for the mathematical expectation.

The correlation coefficient measures how much the two variables evolve jointly (*ρ*<sub>*X*, *Y*</sub> → 1), in opposition to each other (*ρ*<sub>*X*, *Y*</sub> → −1) or without any noticeable pattern of correlation (*ρ*<sub>*X*, *Y*</sub> ≃ 0).

For two paired samples {*X*<sub>*i* ∈ \[1, *n*\]</sub>} and {*Y*<sub>*i* ∈ \[1, *n*\]</sub>}, the above formula gets transformed to use the sample means $\\bar{X}$ and $\\bar{Y}$ as estimators of the "true means" or mathematical expectations:

$$\\rho\_{X,Y} = \\frac{\\sum \_{{i=1}}^{n}(X\_{i}-{\\bar{X}})(Y\_{i}-{\\bar{Y}})}{{\\sqrt{\\sum \_{{i=1}}^{n}(X\_{i}-{\\bar{X}})^{2}}}\\;{\\sqrt{\\sum \_{{i=1}}^{n}(Y\_{i}-{\\bar{Y}})^{2}}}}$$

To determine this **Pearson's correlation coefficient** between two vectors of paired data (i.e.~two vectors of numerical values, with same length and some logical relationship between every pair of corresponding datapoints -- e.g.~they are two measurements performed on the same individual) with R, one simply uses the `cor` function:

``` r
cor(mydat$BMI, mydat$SYSBP)
```

    ## [1] 0.2214656

When data are not normally distributed or even not numerical but ordinal values, one should insted get a measure of correlation calculated as **Spearman's rank correlation coefficient**. In order to calculate Spearman's rank correlation coefficients, it suffices to indicate this to the `cor` function through an option called `method`:

``` r
cor(mydat$BMI, mydat$SYSBP, method="spearman")
```

    ## [1] 0.2131568

The `cor` command is even more versatile, because it readily accepts to get as its argument a multicolumn dataframe, in which case it returns the corresponding matrix of correlation coefficients. Of course, as calculating correlation coefficients makes no sense on non numerical values (or at least on non-rankable values), R will refuse to perform the calculation on a data frame containing factors:

``` r
cor(mydat, method="spearman")
```

    ## Error in cor(mydat, method = "spearman"): 'x' must be numeric

This means we have to first select the columns from the data frame that contain relevant numerical data (it would make no sense to ask for a correlation calculation including the random IDs). These columns are at indices 3, 4, 6 and 8:

``` r
cor(mydat[,c(3,4,6,8)], method="spearman")
```

    ##                   AGE         SYSBP          BMI       CIGPDAY
    ## AGE      1.0000000000  3.454317e-01 -0.006353394  8.953428e-04
    ## SYSBP    0.3454317336  1.000000e+00  0.213156811 -4.426104e-05
    ## BMI     -0.0063533941  2.131568e-01  1.000000000 -1.176153e-02
    ## CIGPDAY  0.0008953428 -4.426104e-05 -0.011761525  1.000000e+00

You remember from section that the expression `mydat[,c(3,4,6,8)]` builds a dataframe from a selection of columns (at indices 3, 4, 6 and 8) but taking into account all the lines (or rows) of the original dataframe `mydat` (hence the absence of anything between the opening square bracket and the comma). Selecting some columns from a data frame can also be done using their names, provided such column names exist:

``` r
names(mydat)
```

    ##  [1] "RANDID"   "SEX"      "AGE"      "SYSBP"    "CURSMOKE" "BMI"     
    ##  [7] "educ"     "CIGPDAY"  "DEATH"    "DIABETES"

``` r
cor(mydat[,c("AGE","SYSBP","BMI")], method="spearman")
```

    ##                AGE     SYSBP          BMI
    ## AGE    1.000000000 0.3454317 -0.006353394
    ## SYSBP  0.345431734 1.0000000  0.213156811
    ## BMI   -0.006353394 0.2131568  1.000000000

Correlation tests
-----------------

Having a mere correlation value to measure the association between two vectors of paired values is often not enough: particularly when you have reduced data sets, you also want to know whether you are able to transfer this correlation result to the two population groups from which the two samples originated. It is easy to understand that the same correlation value of, say, 0.2, can be said to be significantly different from 0 if calculated on two samples of 10,000 values each, but it can happen to be the mere product of randomness in the sampling when it is the correlation coefficient calculated from two samples of length 5.

Bearing in mind that a correlation coefficient of 0 (be it calculated as the result of Pearson's method or of Spearman's) denotes no association between the two vectors of paired values, a few **correlation tests** have been designed and mathematically established, that all have as their null hypothesis (*H*<sub>0</sub>) that the true correlation coefficient that would be calculated on the two underlying populations **is equal to zero**. The R function to perform correlation tests is called `cor.test` and accepts the same option `method` as does the `cor` function (with same default value being `"pearson"`).

``` r
cor.test(mydat$BMI, mydat$SYSBP)
```

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  mydat$BMI and mydat$SYSBP
    ## t = 12.659, df = 3107, p-value < 2.2e-16
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  0.1877740 0.2546367
    ## sample estimates:
    ##       cor 
    ## 0.2214656

This test is built around a test statistic (we call it *t*) that, if the *H*<sub>0</sub> hypothesis holds, follows what is called a known Student's distribution with 3107 degrees of freedom (this well-known distribution draws its name from the great statistician William Sealy Gosset aka `Student', 1876--1937). That distribution is symmetrical across the line $x=0$. Under $H_0$, the test statistic $t$ has thus expected value 0. The results of the above test say that the value of the test statistic calculated from the two samples is equal to $12.66$, so far from 0 that it is highly unlikely ($\textrm{p-value} < 2.2 \times 10^{-16}$) that the two samples we gave (i.e.`mydat$BMI`and`mydat$SYSBP\`) are the product of a situation where *H*<sub>0</sub> holds: as a result of this test, we would logically **reject** **H**<sub>**0**</sub>.

As the *RANDID* column of our original dataset contains random IDs, it is expectable that that column will **not** correlate with any of the others, for instance *SYSBP*:

``` r
cor.test(mydat$RANDID, mydat$SYSBP)
```

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  mydat$RANDID and mydat$SYSBP
    ## t = 0.38204, df = 3107, p-value = 0.7025
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.02830654  0.04199713
    ## sample estimates:
    ##         cor 
    ## 0.006853768

The correlation coefficient of 0.0069 is low, and the result of the correlation test is a high p-value of 0.7025, which clearly indicates that we shall **not** reject *H*<sub>0</sub>: from what we can see in our two vectors, the true correlation is unlikey not to be equal to 0 (if we say it is not equal to 0, we have 70% chances to be wrong).

Graphical correlation matrices
------------------------------

In the previous section we have seen how to calculate Pearson's correlation coefficient between two vectors of paired values, possibly into a matrix of all the bivariate correlations from a data frame. But what if we want to represent graphically these correlation patterns between all pairs of columns from our data frame? We would then draw a **correlation matrix**, also called matrix of bivariate scatterplots.

To see higher correlation coefficients, let us revert for now to our small dataset relative the experience carried on children about their breathing capacity:

``` r
read.table("fev_dataset.txt", header=TRUE) -> dat1
head(dat1, n=3)       # just to refresh our mind about the contents of dat1
```

    ##   Age   FEV   Ht Gender Smoke
    ## 1   9 1.708 57.0      0     0
    ## 2   8 1.724 67.5      0     0
    ## 3   7 1.720 54.5      0     0

``` r
pairs(dat1,cex=0.4)   # cex sets a magnification factor for the symbols plotted
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-81-1.png)

We get a representation of the correlations between the any two of the five variables from our dataset `dat1`: each of the 20 graphs represented here simply contains the scatterplot *y* = *f*(*x*) with *x* and *y* chosen amongst the five variables (*Age*, *FEV*, *Ht*, *Gender* and *Smoke*).

Two of the five variables (*Gender* and *Smoke*) are categorical variables, each one with two levels (respectively Female/Male and No/Yes). Although they do convey some information (e.g. the kids having the highest Forced Expiratory Volume values are boys, and kids exposed to a smoking environment are all above 8), one could prefer to discard them from this graphical representation:

``` r
pairs(dat1[,c("Age","FEV","Ht")], cex=0.4)  # selects only 3 columns
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-82-1.png)

We see that there is a positive correlation between any two of the three variables *Age*, *FEV* and *Ht*: when one of these variables increases, the other two do the same (on average). On the graphs, this is made obvious by plots displaying clouds of points spreading roughly along the first diagonal (some *y* = *α**x* with *α* &gt; 0). This is no mystery: as kids grow up (variable *Age*), they become taller (variable *Ht*) and tend to have an increased respiratory capacity (variable *FEV*). We can confirm this through calculation of our good old Pearson coefficients:

``` r
cor(dat1$Age, dat1$Ht, method="spearman")
```

    ## [1] 0.818892

``` r
cor(dat1$Age, dat1$FEV, method="spear")
```

    ## [1] 0.7984229

``` r
cor(dat1$Ht, dat1$FEV, method="s")
```

    ## [1] 0.8878245

All three values indicate significant positive correlations. As it is often the case with R, the textual option `method` can be abbreviated as much as possible, as long as it remains unambiguous. As possible values here are `"pearson"`, `"kendall"` or `"spearman"`, the initial letter is enough.

Back to the main dataset of this tutorial, we will see how does poor correlation measures look like:

``` ̀``{r} pairs(mydat[,c("AGE","SYSBP","BMI","CIGPDAY")], cex=0.4) ```̀\`\`

These clouds having more or less the shape of a circle or a rectangle are typically what you get when the two variables plotted against the x- and y-axis are uncorrelated (correlation coefficient ≃0). A good example of that is the plot of *BMI* versus *Age* (Pearson correlation coefficient is −0.0064).

Linear regression
=================

Formulae
--------

An R **formula** is something that is written using a tilde symbol (`~`) separating a left-hand term and a right-hand expression. On the left hand side of the symbol stands the **response**, a.k.a.~**outcome** or **dependent variable**. On the right hand we have an expression containing the **predictors**, or **independent variables**. For instance, the formula `y ~ x` denotes a model by which we intend to "explain" the behaviour of the *y* variable from the behaviour of the *x* variable, as if we had *y* = *f*(*x*) with some unknown function *f*.

By the way, when `x` and `y` are two numerical vectors of equal lengths, the function calls `plot(x, y)` and `plot(y ~ x)` are strictly equivalent: they draw a graph where points are plotted at the abscissas taken from the vector `x` (this is the independent variable), with the corresponding ordinates taken from the vector `y` (the dependent variable).

In the formula `z ~ x + y`, the outcome is `z`, while the predictors are `x` and `y`. Now you remember we just said that when we write the formula `y ~ x` we mean *y* = *f*(*x*) with an unknown function *f*? That is not exactly accurate, as what we really mean in this case is a more specific **linear** relationship *y* = *α* *x* + *γ* with unknowns (*α*, *γ*)∈ℝ<sup>2</sup>,  *α* ≠ 0. With the formula `z ~ x + y`, we mean the model *z* = *α* *x* + *β* *y* + *γ*, NOT *z* = *α*(*x* + *y*)+*γ*. If you want the "plus" sign to retain its meaning of a regular arithmetic operator, you have to write `z ~ I(x+y)` and it will mean *z* = *α* (*x* + *y*)+*γ*. The colon is used to describe interactions between two variables (which are essentially multiplicative effects): `z ~ x:y` builds the model *z* = *α* *x**y* + *γ*. In table we give a short list of example formulae along with the corresponding mathematical model.

<table style="width:57%;">
<colgroup>
<col width="16%" />
<col width="29%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">R formula</th>
<th align="center">mathematical model</th>
<th>notes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>z ~ x + y</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em> <em>x</em> + <em>β</em> <em>y</em> + <em>γ</em></span></td>
<td>additive effect</td>
</tr>
<tr class="even">
<td align="left"><code>z ~ I(x+y)</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em> (<em>x</em> + <em>y</em>)+<em>γ</em></span></td>
<td>predictors are tied together</td>
</tr>
<tr class="odd">
<td align="left"><code>z ~ x:y</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em> <em>x</em><em>y</em> + <em>γ</em></span></td>
<td>interactive (multiplicative) effect</td>
</tr>
<tr class="even">
<td align="left"><code>z ~ x*y</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em> <em>x</em> + <em>β</em> <em>y</em> + <em>δ</em> <em>x</em><em>y</em> + <em>γ</em></span></td>
<td>additive and interactive effects</td>
</tr>
<tr class="odd">
<td align="left"><code>z ~ poly(x,3) + y</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em> <em>x</em><sup>3</sup> + <em>β</em> <em>x</em><sup>2</sup> + <em>δ</em> <em>x</em> + <em>κ</em> <em>y</em> + <em>γ</em></span></td>
<td>polynomial effect up to degree 3</td>
</tr>
<tr class="even">
<td align="left"><code>z ~ 1</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>γ</em></span></td>
<td>no predictors, only the intercept</td>
</tr>
<tr class="odd">
<td align="left"><code>z ~ x + 0</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em> <em>x</em></span></td>
<td>no intercept (regression line through the origin)</td>
</tr>
<tr class="even">
<td align="left"><code>z ~ log(x)</code></td>
<td align="center"><span class="math inline"><em>z</em> = <em>α</em>log(<em>x</em>)+<em>γ</em></span></td>
<td>log-transformed predictor</td>
</tr>
</tbody>
</table>

In the table above are some examples of R formulae along with the corresponding mathematical model. Greek letters denotate these unknown coefficients (*γ* is called the **intercept**) that the model fitting procedure is going to estimate.

Linear regression model fitting
-------------------------------

The key function to perform a linear regression analysis in R is `lm`. Its first argument is a formula describing the model that we want to fit. For instance, in our "respiratory performance" dataset, if we want to test a model whereby the FEV value is the dependent variable and the Height, Gender and Smoke variables are the independent variables, we would write:

``` r
regress1 = lm(FEV ~ Ht + Gender + Smoke, data=dat1)
regress1
```

    ## 
    ## Call:
    ## lm(formula = FEV ~ Ht + Gender + Smoke, data = dat1)
    ## 
    ## Coefficients:
    ## (Intercept)           Ht       Gender        Smoke  
    ##    -5.36208      0.12969      0.12764      0.03414

This tells us that, given the data in `dat1`, the best fit for a model whereby the FEV is the result of the linear combination of effects from the Height, Gender and Smoke variables would be:

    $$\textrm{FEV} = -5.36208 + 0.12969\;\textrm{Ht} + 0.12764\;\textrm{Gender} + 0.03414\;\textrm{Smoke}$$

At the first glance, we see that:

1.  the FEV and height are in positive correlation (hence the coefficient 0.12969 &gt; 0);
2.  the FEV and gender are also in a positive correlation, which means (remember the coding Girls=0 and Boys=1) that on average, all other things being equal, boys tend to have a higher FEV than girls;
3.  there is no clear influence of the Smoke variable on the FEV (hence the coefficient 0.03414 ≃ 0).

The object `regress1` that we have created from the call to the `lm` function contains more than the four coefficient values above. Let's gets its summary:

``` r
names(regress1)
```

    ##  [1] "coefficients"  "residuals"     "effects"       "rank"         
    ##  [5] "fitted.values" "assign"        "qr"            "df.residual"  
    ##  [9] "xlevels"       "call"          "terms"         "model"

``` r
summary(regress1)
```

    ## 
    ## Call:
    ## lm(formula = FEV ~ Ht + Gender + Smoke, data = dat1)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.66819 -0.25393  0.00088  0.23749  2.07863 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -5.362078   0.186553 -28.743  < 2e-16 ***
    ## Ht           0.129693   0.003106  41.756  < 2e-16 ***
    ## Gender       0.127643   0.034093   3.744 0.000197 ***
    ## Smoke        0.034138   0.058581   0.583 0.560265    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4268 on 650 degrees of freedom
    ## Multiple R-squared:  0.7589, Adjusted R-squared:  0.7577 
    ## F-statistic: 681.9 on 3 and 650 DF,  p-value: < 2.2e-16

This summary confirms that the value for the coefficient associated with the *Smoke* independent variable **should not** be trusted (p-value is equal to 0.56): from the overall dataset one **cannot** contend that there is a significant influence of the exposure to an environment with smoking parents on the respiratory capacity of a child.

The R-squared values are called "coefficients of determination". They tell you how well the model fits the reality, in other terms how much of the variance observed in the outcome variable is accounted for by the model. Here an adjusted *R*<sup>2</sup> value of 0.76 means that the model accounts for some 76% of the total variance in the FEV, which is a pretty good fit.

To get a graphical idea of this goodness of fit, we can represent the cloud of points with coordinates (*x*, *y*) where *y* is the response *FEV* and *x* is the predictor *Ht*. Showcasing another nice feature of plots in R, we colour-code the points according to the *Gender* variable. Finally we superimpose to the plot the fitting line.

``` r
plot(FEV ~ Ht, data=dat1, col=(Gender+1)*2, cex=0.6, pch=19)
legend("topleft", legend=c("boys", "girls"), bty="n", pch=19, col=c(4,2))
regress1$coefficients
```

    ## (Intercept)          Ht      Gender       Smoke 
    ## -5.36207814  0.12969288  0.12764341  0.03413801

``` r
abline(regress1$coefficients["(Intercept)"], regress1$coefficients["Ht"], lwd=3, col="pink")
abline(regress1$coefficients["(Intercept)"]+regress1$coefficients["Gender"], regress1$coefficients["Ht"], lwd=3, col="lightblue")
```

![](tutorial_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-86-1.png)

The couple of commands we used above deserve some explanations:

1.  the `plot` command plots *y* = *F**E**V* as a function of *x* = *H**t*;
2.  its `data` option allows a more concise naming of the variables, avoiding to write in full `dat1$FEV ~ dat1$Ht`;
3.  the `col` option takes its values from the Gender column of the `dat1` dataset. In this, "0" means a girl and "1" a boy. Adding 1 to it and multiplying the result by two is a little trick to have a red colour (coded as 2 in R) for the girls and a blue dye for the boys (coded as 4 in R);
4.  `pch=19` gives a full bullet as plotting symbol, ans `cex=0.6` reduces the symbol size from standard to 60% thereof;
5.  then we draw a legend using the `legend` command we already saw in section ;
6.  `abline` is the function to overlay a straight line on an existing graph. Its first two arguments are respectively the intercept and slope of the line. Here because one of the predictors (the Gender) is a categorical with two possible values being 0 and 1, it means we have two regression lines, one for the boys and another for the girls. The boys have a higher intercept because of the added (0.1276 × *G**e**n**d**e**r*) component of the model. That is why we draw two regression lines, and why they have the same slope but different intercepts.

Logistic regression
===================

In this chapter we will be using the `glm` function, which is an extension of `lm` to other types of models (`glm` stands for "generalized linear models"). Specifying the option `family="binomial"` will enable us to perform logistic regression. Logistic regression is suitable when the outcome is a dichotomous variable (success or failure, TRUE or FALSE, 1 or 0).

On our `mydat` dataset concerning diabetes and its possible risk factors, let us consider "death for any cause during followup" as the outcome (variable *DEATH*) and the age (variable *AGE*), systolic blood pressure (*SYSBP*), body mass index (*BMI*), number of cigarettes per day (*CIGPDAY*) and diabetes disease (*DIABETES)* as five possible predictors. We want to fit a logistic regression with this model.

``` r
logmod = glm(DEATH ~ AGE + SYSBP + BMI + CIGPDAY + DIABETES,
               data=mydat, family="binomial")
summary(logmod)
```

    ## 
    ## Call:
    ## glm(formula = DEATH ~ AGE + SYSBP + BMI + CIGPDAY + DIABETES, 
    ##     family = "binomial", data = mydat)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.2962  -0.6581  -0.6404  -0.6286   1.8779  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.474098   0.455220  -3.238   0.0012 ** 
    ## AGE          0.002305   0.005725   0.403   0.6873    
    ## SYSBP       -0.001023   0.002131  -0.480   0.6312    
    ## BMI         -0.000277   0.011506  -0.024   0.9808    
    ## CIGPDAY      0.007466   0.003634   2.055   0.0399 *  
    ## DIABETES1    1.368637   0.138910   9.853   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 3238.0  on 3108  degrees of freedom
    ## Residual deviance: 3142.5  on 3103  degrees of freedom
    ## AIC: 3154.5
    ## 
    ## Number of Fisher Scoring iterations: 4

The result line concerning the *DIABETES* predictor can be worded like that: the fact of having diabetes (`DIABETES == 1`) increase by exp(1.37)=3.93 the odds ratio of mortality.

The interpretation of the goodness of fit in the logistic regression is done using the information present on the two lines "Null deviance" and "Residual deviance": the null deviance shows how well the outcome would be predicted by a model with no predictor, only an intercept (i.e. the model being a constant equal to the mean of all observations of the outcome). Under some assumptions of normality, that null deviance follows a chi-square distribution with (*n* − 1) degrees of freedom, where *n* is the number of observations (here *n* = 3109). Adding our 5 predictors, the number of degrees of freedom drop by 5 and becomes 3103, as indicated in the "Residual deviance" line.

A good model will yield a dramatic decrease of the residual deviance, which is not the case here, where we observe a decrease of 95.5 points on 5 degrees of freedom. After fitting the model, we get a residual variance of 3142.5 for a chi-square distribution with 3103 degrees of freedom, leaving `1 - pchisq(3142.5, df=3103)` =0.306 in the tail of the distribution. This means we have a p-value of 0.306 when we consider *H*<sub>0</sub> as being our model: we cannot reject this model, which is good enough.

Beware, this is different from the individual p-values you get for each of the coefficients of the model: here it seems that only *DIABETES* (which is the only predictor really making a difference, with almost a four-fold in odds ratios for the outcome) and *CIGPDAY* (which plays a minor but significant role) really make sense as predictors, suggesting that we could drop the other predictors from our model:

``` r
logmod2 = glm(DEATH ~ CIGPDAY + DIABETES, data=mydat, family="binomial")
summary(logmod2)
```

    ## 
    ## Call:
    ## glm(formula = DEATH ~ CIGPDAY + DIABETES, family = "binomial", 
    ##     data = mydat)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.2890  -0.6610  -0.6391  -0.6391   1.8379  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.484818   0.054941 -27.026   <2e-16 ***
    ## CIGPDAY      0.007502   0.003634   2.065    0.039 *  
    ## DIABETES1    1.368226   0.138760   9.860   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 3238.0  on 3108  degrees of freedom
    ## Residual deviance: 3142.9  on 3106  degrees of freedom
    ## AIC: 3148.9
    ## 
    ## Number of Fisher Scoring iterations: 4

We see that the prediction is almost as good, with a residual deviance of 3142.9 for two predictors against 3142.5 formerly, with a plethora of useless predictors.
