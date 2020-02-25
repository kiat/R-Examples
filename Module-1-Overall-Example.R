# The following code is implemented by Anna Bissell. 


##### Install R/RStudio #####
### Download R from: CRAN: https://cran.r-project.org/
###   For WINDOWS: cran.r-project.org/bin/windows/base/
###   For MAC: ): cran.r-project.org/bin/macosx/

### Download RStudio from: https://www.rstudio.com/products/rstudio/download/


rm(list=ls())  # clear all objects
cat("\014") # clear the console

# type   java -version     in terminal to see my java is 32 or 64 bits
.Machine$sizeof.pointer    # Check if R is 64 or 32 bits. 8 bytes for address is 64 bits - 


# Set your 
# setwd("/Volumes/Seagate/Documents Anna/BU Online Course/CS555/Module 1/2019 - Spring 01")  #I'm a mac user



# histogram
# use pi2000
help(pi2000)    # first 2000 digits of pi


# show the frequencies of the differences of primes
table(pi2000)

hist(pi2000)                           # Notice the # of bins (9) vs # of frequency (10)
# intervals closed on the left - bins for the count of 0's and 1's are together (181+213)

hist(pi2000, right=TRUE)               # right-closed intervl - same as above
hist(pi2000, right=FALSE)              # left-closed interval - same thing for the last bin

hist(pi2000, breaks = c(-1:9), ylim = c(0, 250))         # e.g.add another bin - now there is 10 bins
hist(pi2000, breaks = seq(from = -1, to = 9, by = 1), ylim = c(0, 250), col = "palegreen2")  # a different way to add another bin. 
                                                                                             #adding a color

hist(pi2000, breaks = seq(min(pi2000), max(pi2000), l=11), ylim = c(0, 250))         # make l = # of bins +1


boxplot(pi2000)     # don't see outliers

summary(pi2000)

sd(pi2000)

f <- fivenum(pi2000)

# Finding outliers manually
lower <- f[2] - 1.5*(f[4] - f[2])
upper <- f[4] + 1.5*(f[4] - f[2])

outliers <- pi2000[pi2000 < lower | pi2000 > upper]

# horizontal boxplot with 5 numbers
boxplot(pi2000, col = hcl(0), horizontal = TRUE, xlab = "first 2000 digits of pi")     # or  main = "first 2000 digits of pi" for title
values <- unique(sort(c(lower, f, upper, outliers)))
text(x = values, y = 1.3, label = as.character(values), cex = 0.5)




### getting and setting the working directory
# Let's see where the working directory is currently set.  This is where R will look to load files and where R will save any files.
getwd()  

# Let's change the working directory to my folder for the class
setwd("/Volumes/Seagate/Documents Anna/BU Online Course/CS555/Module 1/2019 - Spring 01")

# Let's double check that we changed the working directory correctly
getwd()

# Let's see what files are in the current working directory
list.files()




#   Save the data to excel and read into R for analysis.
##  install.packages("xlsx", dependencies = TRUE)
##  library(xlsx)
##  data <- read.xlsx("hospital.xlsx",1, header=FALSE)

## OR
## save data as csv and use read.csv()


## OR
library(gdata)
data <- read.xls("hospital.xlsx",1)


# xlsx package and read.xlsx() function that people are having trouble installing.
# A perfectly fine workaround is to save the data as a .csv file and use read.csv()
data.class() = read.csv("hospital.xlsx", header = FALSE)

# Let's see the contents of hwdata, it is a bit of a mess so we will need to clean up.
data
# First, the data is stored as a data.frame (which is secretly a list under the hood of R)
# so let's unlist() it to get it into a single vector of data
data = unlist(read.csv("hospital.csv"))

# Let's take another look at the contents of hwdata.  It is a vector now, but has nasty looking variable
# names that got carried over from the data.frame.
data

# Let's remove the variable names
names(data) = NULL

# Let's take another look at the contents.  There are still some NA's that crept into the csv file.
data

# Let's find which observations are NA
is.na(data)

# Let's find which observations are *not* NA using the negation operator "!"
!is.na(data)

# Let's subset hwdata to just the observations that are *not* NA, i.e. let's get rid of the NA's
data = data[ !is.na(data) ]

# An easier approach without having to clean up the NA's is to save the data to a .txt file and use
# the read.table() function instead.
# Read in the data using read.table()
hwdata = read.table("HW1-data.txt", header = FALSE)

# Let's check the contents, looks cleaner than read.csv() result
hwdata

class(hwdata) # same as with read.csv(), the resulting object is a data.frame
typeof(hwdata) # as above, data.frames are secretly list objects under the hood of R

# Let's unlist the data.frame and get rid of the variable names
hwdata = unlist(hwdata)
names(hwdata) = NULL

# Let's check the contents...clean vector of data and now we can work on it
hwdata


mean(hwdata)
summary(hwdata)




### plotting the density curve over a histogram
# Plot the histogram first, then add more plot features over top using 
hist(x = hwdata, main = "Histogram", freq = FALSE)

# Get the smooth density curve
dens = density(hwdata)

# Add the density curve (which is a line) to the existing histogram plot using the lines() function
lines(dens)

# We can also add things like straight lines using the abline() function.  Here is an example of adding a
# vertical line at x = 5 by using the "v = " argument to add a vertical line.  Look at the help file for 
# abline(), i.e. ?abline, for other options like horizontal lines, slope-intercept forms, etc.
abline(v = 5, col = "red")

# Side note: the points() function is also super useful for adding points, i.e. scatterplot points
# to an existing plot.  

# Sometimes other packages have nice functions built in to do cool plots like these packages, but in many
# cases, the graphics package in base R is sufficient:
# lattice
# ggplot2






### dnorm() function which leads into the other functions like rnorm(), pnorm(), qnorm().
# xnorm() functions
# rnorm() generates psuedo-random normal observations
normals = rnorm(n = 1000) # Standard Normal Dist = z-score
normals = rnorm(n = 1000, mean = 15, sd = 3)
hist(normals)

# dnorm() gives you the density or height of the continuous normal distribution curve at a point x.  So the
# height of the standard normal curve at the mean = 0 is 1/sqrt(2*pi), i.e. when x = 0.
dnorm(x = 0)
1/sqrt(2*pi)


# the "d" family functions are not super useful for continuous distributions but for discrete distributions
# they give you the probabilties (which are heights for discrete variables).  Here is an example to find 
# the probability that x = 3 for a binomial distribution with n = 10 and p = 0.7.
dbinom(x = 3, size = 10, prob = 0.7)


# pnorm() tells you the probablility to the left of a quantile point q, i.e. a point on the x-axis
pnorm(q = 0)
pnorm(q = 1.96)

# More generally, the "p" family of functions tells you the probablility to the left of a quantile point q
# which is also referred to as the CDF or Cumulative Distribution Function.  Here is an example for binomial.
pbinom(q = 3, size = 10, prob = 0.7)


# qnorm() is the inverse CDF, i.e. tells you which quantile point on the x-axis corresponds to a given
# probability to the left, i.e. it is the inverse of pnorm()
qnorm(p = 0.5)
qnorm(p = 0.975)






