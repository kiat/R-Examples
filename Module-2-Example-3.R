
# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")


# In order to assess how quickly polyester decays over time in landfills, a researcher buried strips of the material in the soil
# for different lengths of time and then tested the force required to break them (as a measure of decay). Lower breaking strength 
# is indicative of decay


# Test whether or not the breaking strengths of polyester strips buried for 2 weeks is greater than the breaking strengths of
# those buried for 16 weeks. 

# Perform the test at the α=0.10 level of significance.

# First read the data as a dataframe into your R memory 
decay<- read.csv("Datasets/decay.csv" )

#print the dataframe to check the content
# Note, this is only possible if your data is small 
decay


# Print out a summary of the data for the 2 weeks sample data 
summary(decay$strength[decay$weeks==2])

# Print out a summary of the data for the 16 weeks sample data 
summary(decay$strength[decay$weeks==16])

# Or you can do 
aggregate(decay$strength, by =list(as.factor(decay$weeks)), FUN=summary)
aggregate(decay$strength, by =list(as.factor(decay$weeks)), FUN=sd)

# read the manual of t-test function 
?t.test 

# Compute the test t statistic and the associated p-value
# Reject H0 if p <= alph, p<=0.1
t.test(decay$strength[decay$weeks==2], decay$strength[decay$weeks==16], alternative="greater", conf.level=0.9)


# p-value = 0.1857

# Using higher confidence level of 0.95
# Two Sample t-test
t.test(decay$strength[decay$weeks==2], decay$strength[decay$weeks==16], alternative="two.sided", conf.level=0.95)

# the same command as above because of default variables. 
t.test(decay$strength[decay$weeks==2], decay$strength[decay$weeks==16])
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
# -12.2789  27.0789

#  90% confidence interval
t.test(decay$strength[decay$weeks==2], decay$strength[decay$weeks==16], alternative="two.sided", conf.level=0.90)

# 90 percent confidence interval:
# -7.932851 22.732851
# We are 90% confident that the mean difference in breaking strengths is between -7.932851 and 22.732851

# Manual implementation of 

mean.diff <- (mean(decay$strength[decay$weeks==2]) -  mean(decay$strength[decay$weeks==16])) 
minLeanght <- min(length(decay$strength[decay$weeks==2]), length(decay$strength[decay$weeks==16]))

margin.Off.error <- qt(0.05 , df = 4, lower.tail = F ) * sqrt( sd(decay$strength[decay$weeks==2])^2 / minLeanght  +  sd(decay$strength[decay$weeks==16])^2 / minLeanght    )

lower.bound <- mean.diff - margin.Off.error
upper.bound <- mean.diff + margin.Off.error

# Conculsion: 90% mean difference in breaking strengths is between -8.56 and 23.36
# This is a good correct estimate of the above 


# return value has some contents 
# names(ttest2)


