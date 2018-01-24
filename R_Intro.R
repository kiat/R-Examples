## ----con_test,eval=FALSE-------------------------------------------------
?lm
??linear
plot(1:20, 1:20)

## ----Rwds,eval=FALSE-----------------------------------------------------
getwd()
list.files()

## ----Rsetwd,eval=FALSE---------------------------------------------------
## setwd("/path/to/directory")


## ----readsyn,eval=FALSE--------------------------------------------------
?read.table
?read.csv
## read.table("/path/to/your/file.ext",
##            header=TRUE,
##            sep=",",
##            stringsAsFactors = FALSE)

## ----readin1,eval=FALSE--------------------------------------------------
# read.table's default seperator ok for this one
set0 <- read.table("../../data/readin/ReadMeIn0.txt",
                   header=TRUE)
# specify new seperator
set1 <- read.table("../../data/readin/ReadMeIn1.txt",
           header=TRUE,
           sep=',')
# Or use read.csv
set1 <- read.csv("../../data/readin/ReadMeIn1.txt",
           header=TRUE)

## ----readin2,eval=FALSE--------------------------------------------------
## # another change of seperator
set2 <- read.table("../../data/readin/ReadMeIn2.txt",
           header=TRUE,
           sep=';')
# check for missing
set3 <- read.table("../../data/readin/ReadMeIn3.txt",
           header=FALSE,
           sep=',',
           na.strings = '')

## ----writesyn,eval=FALSE-------------------------------------------------
?write.csv
## write.csv(myRObject,
##           file="/path/to/save/spot/file.csv",
##           row.names=FALSE)

## ----rdsex,eval=FALSE----------------------------------------------------
## # save our data set
saveRDS(set1,file="TstObj.rds")
## # get it back
newtst <- readRDS("TstObj.rds")
## # can save any R object. Try a vector
my.vector <- c(1,8,-100)
saveRDS(my.vector, file="JustAVector.rds")

## ----workspace,eval=FALSE------------------------------------------------
## # Save all our work
save.image("AllMyWork.RData")
## # Reload it
load("AllMyWork.RData")
## # name given to default save
# load(".RData")

## ----datatypes,eval=FALSE------------------------------------------------
# numeric types: interger, double
348
# character
"my string"
# logical
TRUE
FALSE

# artithmetic as you'd expect
43 + 1 * 2^4
# so too logical operators/comparison
TRUE | FALSE
1 + 7 != 7
# Other logical operators:
# &, |, !
# <,>,<=,>=, ==, !=

## ----datatypes2----------------------------------------------------------
# variables assignment is done with the <- operator
my.number <- 483
# the '.' above does nothing. we could have done:
# mynumber <- 483
# instead
# it's an Rism to use .'s in variable names.

# typeof() tells use type
typeof(my.number)
# we can convert between types
my.int <- as.integer(my.number)
typeof(my.int)
# we can test for types
is.logical(my.int)

## ----vectors1,size='tiny'------------------------------------------------
# the vector is the most important data structure
# create it with c()
my.vec <- c(1,2,67,-98)
# get some properties
str(my.vec)
length(my.vec)
# access elements with []
my.vec[3]
my.vec[c(3,4)]
# can do assignment too
my.vec[5] <- 41.2

## ----vectors3,size='tiny'------------------------------------------------
# other ways to create vectors
x <- 1:6
y <- seq(7,12,by=1)
# Operations get recycled through whole vector
x + 1
x > 3
# Can do component wise operations between vectors
x * y
x / y
y %/% x

## ----struc_tryout1,eval=FALSE,size='small'-------------------------------
## # Try guess what the following lines will do
## # Will it run at all? If so, what will it give?
## # Think about it and run to confirm
7 -> w
w <- z <- 44
1 + TRUE
0 | 15 & 3
my.vec[2:4]
my.vec[-2]
my.vec[c(TRUE,FALSE,FALSE,TRUE,FALSE)]
my.vec[
  sum(
    c(TRUE,FALSE,FALSE,TRUE,TRUE)
  )
] <- TRUE
my.vec[3] <- "I'm a string"
as.numeric(my.vec)
x[x>3]
x + c(1,2)

## ----mats1,size='tiny'---------------------------------------------------
# matricies are 2d vectors.
# create using matrix()
my.matrix <- matrix(rnorm(20),nrow=4,ncol=5)
# rnorm() draws 20 random samples from a n(0,1) distribution
my.matrix
# note matricies loaded by column

# Get details
dim(my.matrix)
nrow(my.matrix)
ncol(my.matrix)

## ----mats2,size='tiny'---------------------------------------------------
# Indexing is similar to vectors but with 2 dimensions
# get second row
my.matrix[2,]
# get first,last columns of row three
my.matrix[3,c(1,4)]
# transposing done with t()

## ----lists,size='tiny'---------------------------------------------------
# lists similar to vectors but contain different types
# create with list
my.list <- list("just a string", 
                44,
                my.matrix,
                c(TRUE,TRUE,FALSE))
# access items via double brackets  [[]]
my.list[[4]]
# access multiple items 
my.list[1:2]
# list items can be named too
named.list <- list(Item1="my string",
                   Item2=my.list)
# access of named item is via dollar sign operator
# [[]] also works
c(named.list$Item1,named.list[[1]])

## ----getiris,eval=FALSE--------------------------------------------------
data("iris")
head(iris)
str(iris)

## ----pca1,eval=TRUE------------------------------------------------------
data("iris")
# get numeric portions of list and make a matrix
X <- as.matrix(iris[1:4])
# center and scale
X <- scale(X,center = TRUE,scale=TRUE)
# get the number of rows
n <- nrow(X)
# compute correlation matrix
R <- (1/(n-1))*t(X)%*%X
# perform eigen decomposition
Reig <- eigen(R)
# get eigen vectors
Reig.vecs <- Reig$vectors
# create principle components
pc1 <- X%*%Reig.vecs[,1]
pc2 <- X%*%Reig.vecs[,2]

## ----pcacomp,eval=TRUE,size='tiny'---------------------------------------
# compare to R's PCA function
their.pcs <-prcomp(iris[1:4],center = TRUE,scale. = TRUE)
head(their.pcs$x[,1:2])
# our result
head(cbind(pc1,pc2))

## ----pcascatter,echo=TRUE,out.width=".6\\linewidth"----------------------
plot(pc1,pc2,col=iris$Species)

## ----factors,size='tiny'-------------------------------------------------
# Factors are like vector, but with predefined allowed values called levels
# Factors are used to represent categorical variables in R
# create a factor
factor1 <- factor(c('Good','Bad','Ugly'))
# find it's levels
levels(factor1)
# below gives warning, but not error
factor1[4] <- 17
# see what happened
factor1
factor1[4] <- 'Bad'
# get the breakdown
table(factor1)

## ----mat_fac_Qs,eval=FALSE-----------------------------------------------
my.matrix[3:4,1:2] <- c(4,5)
my.matrix[4,5] <- 'string'

mf.strings <- c('F','F','M','F')
factor2 <- as.factor(mf.strings)

c(factor1, factor2)
factor1 == 'Ugly'
my.list[[3]][2,]

sum(c(1,2,3,NA))
sum(c(1,2,3,NA),na.rm = TRUE)

## ----df1-----------------------------------------------------------------
# create your own
my.df <- data.frame(
  age = c(45,27,19,59,71,13,5),
  gender = factor(c('M','M','M','F','M','F','F'))
)
str(my.df)

## ----df2,size='tiny'-----------------------------------------------------
my.df$age
summary(my.df$age)
table(my.df$gender)
# data frames are really just lists
my.df[[2]]

## ----df3,size='tiny'-----------------------------------------------------
# data.frames can be subsetted like matrcies
my.df[1:3,c("age")]
# logical subsetting especially useful for .data.frames
# get ages over 40
age.logic <- my.df$age > 40
# take a subset of these rows
my.df[age.logic,]
# create a new variable age.sq
my.df$age.sq <- my.df$age^2

## ----iris,results='hide'-------------------------------------------------
my.iris <- iris
my.iris

## ----iris_sol1-----------------------------------------------------------
my.iris$Length.Sum = my.iris$Sepal.Length + 
  my.iris$Petal.Length
my.iris$Width.Sum = my.iris$Sepal.Width + 
  my.iris$Petal.Width
setosa.inds <- my.iris$Species == 'setosa'
mean(my.iris[setosa.inds,]$Length.Sum)

## ----control_syn,eval=FALSE----------------------------------------------
## if(logical_expression){
##   execute_code
## } else{
##   executre_other_code
## }
## 
## for(value in sequence){
##   work_with_value
## }
## 
## while(expression_is_true){
##   execute_code
## }
## 

## ----fundef--------------------------------------------------------------
# use function key word with assignment <-
my.mean <- function(input.vector){
  sum = 0
  for(val in input.vector) {
    sum = sum + val
  }
  # the expression get  retuned
  return.me <- sum / length(input.vector)
}
my.mean(1:10)
ans <- my.mean(1:10)
ans
## ----fundef2-------------------------------------------------------------
my.mean <- function(input.vector){
  sum = 0
  for(val in input.vector) {
    sum = sum + val
  }
  # returns 1 now
  retrun.me <- sum / length(input.vector)
  1
}
my.mean(1:10)

## ----create_fun----------------------------------------------------------
my.summary <- function(x) {
  list(
    mean = mean(x),
    sd = sd(x),
    max = max(x),
    min = min(x)
  )
}

## ----loop_sol,eval=FALSE-------------------------------------------------
for(var in my.iris) {
  if(is.numeric(var)){
    tmp <- my.summary(var)
    print(tmp$max)
  }
}

