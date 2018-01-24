
# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

decay<- read.csv("Datasets/decay.csv" )

decay 


# Print out a summary of the data for the 2 weeks sample data 
summary(decay$strength[decay$weeks==2])


# Print out a summary of the data for the 16 weeks sample data 
summary(decay$strength[decay$weeks==16])

# read the manual of t-test function 
?t.test 

# Compute the test t statistic and the associated p-value
t.test(decay$strength[decay$weeks==2], decay$strength[decay$weeks==16], alternative="greater", conf.level=0.9)


# Using higher confidence level of 0.95
# Two Sample t-test
t.test(decay$strength[decay$weeks==2], decay$strength[decay$weeks==16], alternative="two.sided", conf.level=0.95)


