# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")



# Load the smoker data set. 
data<- read.csv("Datasets/smoker.csv")
attach(data)

data

is.factor(data$group)

# Fit an Analysis of Variance Model
m<- aov(data$SBP~data$group, data=data)
summary(m)

# The F Distribution
# a=0.05 
# F Value for  df1=3, df2=15
qf(.95, df1=3, df2=15)


# Install package car "Companion to Applied Regression"
# one time installation needed only 
# install.packages("car")

library(car)
Anova(lm(data$SBP~data$group+data$age), type=3)



# Install package lsmeans "Companion to Applied Regression"
# install.packages("lsmeans")
# one time installation needed only 
# Least square means
library(lsmeans)
options(contrasts=c("contr.treatment", "contr.poly"))
data

# with none adjustment 
lsmeans(lm(data$SBP~data$group+data$age), pairwise~data$group, adjust="none")


# with none adjust=[method])
# Note: method = “tukey”, “scheffe”, “sidak", "bonferroni", “dunnettx", “mvt", "none")

lsmeans(lm(data$SBP~data$group+data$age), pairwise~data$group, adjust="tukey")


