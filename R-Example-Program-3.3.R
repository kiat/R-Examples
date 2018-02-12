# First read the data as a dataframe into your R memory 
decay<- read.csv("Datasets/decay.csv" )

#print the dataframe to check the content
# Note, this is only possible if your data is small 
decay
attach(decay)

# Install the R package gplots
# This is a one time installation on your system
# install.packages("gplots")

# you need to load the gplots libarary 
library(gplots)


# Side by side box plots
# We can use the two data categories to make two boxplots side by side. 
boxplot(strength~weeks)

# Bar graph with ionfdenie intervals
means <- tapply(strength, weeks, mean)


lower <- tapply(strength, weeks, function(v) t.test(v)$conf.int[1])

upper <- tapply(strength, weeks, function(v) t.test(v)$conf.int[2])



# 
max(upper)

barplot2(means, plot.ci=TRUE, ci.l=lower, ci.u=upper, ylim = c(0, max(upper)*1.1), 
         names.arg=c("2 weeks", "16 weeks"))

text(0, lower[2], round(lower[2], 0))

abline(h=0)
