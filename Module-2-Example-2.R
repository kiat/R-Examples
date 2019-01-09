# Let us remove all variables from the memory to have nothing in memory 
rm(list=ls())

# Pearson and Lee's data on the heights of parents and children classified by gender
# 

# set the working directory to the folder that you have stored the data files. 
# This is only on my laptop, for your latop it is the folder that you stored the files. 
# On windows machines, you need to replace the \ backslash with a slash. 

# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")


# Load up your dataset 
data <- read.csv("Datasets/PearsonLee.csv")

# print(data)

# print out the column names so that you can view and check what is inside the dataframe
colnames(data)

# If that was too much printing, you can print out the first 4 lines of your dataset and not all of that. 
# print first 4 rows of mydata
head(data, n=4)

# By using the attach command, we can attach the whole dataframe and access the columns as variable names, like height and make 
attach(data)


# The data is selected first based on the column name height and then based on the column name toyota. 
heightsOfBoys <- data$child[data$chl=="Son"]
heightsOfGirls <- data$child[data$chl=="Daughter"]

# Note that this is a filtering functionality, we first filter the child column that includes the heights of kids and then we divid that column in two groups of Son and Daughter based on the valriable name chl. 

# We can also extract the heights of fathers and mothers from the data frame. 
heightsOfFathers <- data$parent[data$par=="Father"]
heightsOfMothers <- data$parent[data$par=="Mother"]


# check the lenght of each variables that you have created 
# this should return 20 
length(heightsOfBoys)

# This should return 20
length(heightsOfGirls)


# We can use the aggregate function to generate the summary for each different group, girls and boys 
aggregate(data$child, by =list(data$chl), FUN=summary)

aggregate(data$parent, by =list(data$par), FUN=summary)


# read more aboute the aggregate by using the ?aggregate command 
# aggregate splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.

# aggregate function can be used to generate the standard deviation for each subset 
aggregate(data$child, by =list(data$chl), FUN=sd)


# Now, let us make a set of plots to present some of the important summary of our autot dataset. 
# we want to make 4 plots side by side in 2 rows and 2 columns 
par(mfrow=c(2,2))

# Now we can make boxplot to see the heitghts. 
# we use the "~" to seperate the height of each child groups in to subsets based on their genders
boxplot(data$child~data$chl)



# print out the earning
child

# print out ageGroup
parent

# We can use the tapply function to calculate the means of each group 
# Here we want to calculate the mean, but subset it based on their group  
means <- tapply(child, chl, mean)  


# To understand how I get the lower bound of my data from t.test function, you can take a look on the return values that t test function returns. 

# then we run t.test and print out the results
# Read the results of this test and try to understand the details 
results<-t.test(heightsOfBoys)

# The result of the t-test is something like the following. 
#Result os
# One Sample t-test
#
# data:  heightsOfBoys
# t = 40.129, df = 18, p-value < 2.2e-16
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
#  63.21792 70.20313
# sample estimates:
#  mean of x 
# 66.71053 

# And the following command returns the confidence intervals 
# It simply includes a lower bound and upper bound interval of my data 
t.test(heightsOfBoys)$conf.int

# By using the following lowe bound, the first index of conf.int variable is the lower bound and second is the higher bound
t.test(heightsOfBoys)$conf.int[1]

# this is the higher bound 
t.test(heightsOfBoys)$conf.int[2]

# Now, we find out the lower bound of the heights for each group
# Please note that we use here a function that we defined and inside that function we use the t.test the t test to 
# We want to use this function to present the lowerbound and upperbound of the heights of our data to add that to our bar plot and have a nice bar plot.  
# For this purpose we combine it with tapply command 
lower <- tapply(child, chl, function(v) t.test(v)$conf.int[1])
upper <- tapply(child, chl, function(v) t.test(v)$conf.int[2])

# install the package gplots 
# if you have done this one time before you do not need it again. 
# install.packages("gplots")

# the we need to load the library 
library("gplots")

# This is a nice plot that shows also the upper and lower bound of mean in addition to the bar plot. 
# click on the zoom to see the graph better. 
barplot2(means, plot.ci = TRUE, ci.l = lower, ci.u =upper, names.arg = c("Boys", "Grils") 
         , xlab="Heights of Kids",
         main= "Means of heights of Childs by their group", ylab="Heights of Childs", col= "seagreen2", ylim = c(0, 70) ) 

hist(heightsOfBoys)
hist(heightsOfGirls)


