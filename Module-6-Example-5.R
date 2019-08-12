# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
# install.packages("aod")
# install.packages("pROC")
library(aod)
library(stats)
library(pROC)
data<-read.csv("Datasets/cevent.csv")

m <- glm(data$event ~ data$chol, family = "binomial")
summary(m)

# Another way to do logistic regression in R is to use rms package. 
# install.packages("rms")
library(rms)
# see 
?lrm
lrm(event ~ chol, data=data)


fit <- lrm(event ~ chol, data = data, x=TRUE, y=TRUE)
print(fit)
# find influence points 
which.influence(fit, cutoff=.3)


# Multiple Logistic Regression. 
lrm(event~ chol + age, data = data)