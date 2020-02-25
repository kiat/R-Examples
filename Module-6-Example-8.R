# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
rm(list = ls())
library(aod)
library(stats)
library(pROC)

data<-read.csv("Datasets/cevent.csv")
data$male <- ifelse(data$sex =="M", 1, 0)

m <- glm(event ~ chol + age , data=data, family = "binomial")
summary(m)


# http://r-statistics.co/Logistic-Regression-With-R.html
# Find the optimal cutOff
# Default cutoff is 0.5
# Chaning the cutoff can improve the accuracy 
data$prob <-predict(m, type=c("response"))

# The InformationValue::optimalCutoff function provides ways to find 
# the optimal cutoff

# install.packages("InformationValue")
library(InformationValue)
optCutOff <- optimalCutoff(data$prob, m)[1] 


