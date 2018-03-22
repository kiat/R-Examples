# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")



# Load the smoker data set. 
data<- read.csv("Datasets/smoker.csv")
attach(data)

data

# The function factor is used to encode a vector as a factor (the terms ‘category’ and ‘enumerated type’ 
# are also used for factors).
is.factor(data$group)

# Calculate mean, SD of SBP by groups
aggregate(data$SBP, by=list(data$group), summary)
aggregate(data$SBP, by=list(data$group), sd)

# Boxplot data 
boxplot(data$SBP~data$group, data=data, main="SBP by smoking status", xlab="group",  ylab="SBP", ylim=c(100, 160))


# aov 
m <- aov(data$SBP~data$group, data=data)
summary(m)

# pairwise t test 
pairwise.t.test(data$SBP, data$group, p.adj="none")

# pairwise t test with bonferroni adjustment 
pairwise.t.test(data$SBP, data$group, p.adj="bonferroni")


# Compute Tukey Honest Significant Differences
?TukeyHSD

# Create a set of confidence intervals on the differences between the means of the levels of a factor 
# with the specified family-wise probability of coverage. 
# The intervals are based on the Studentized range statistic, Tukey's ‘Honest Significant Difference’ method.

# pairwise test with TukeyHSD
TukeyHSD(m)



