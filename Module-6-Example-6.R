# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
rm(list = ls())

# install.packages("aod")
# install.packages("pROC")
library(aod)
library(stats)
library(pROC)

data<-read.csv("Datasets/cevent.csv")
data$male <- ifelse(data$sex =="M", 1, 0)

# Let us assume that we have data about happyness of patients
data$happiness<-cut(data$chol, seq(60,220,40), right=FALSE, labels=c(1:4))
data$happiness <-as.factor(data$happiness)

# 

m <- glm(event ~ chol + age + happiness, data=data, family = "binomial")
summary(m)


# overall test of happiness. 
# install.package("aod")
library(aod)
wald.test(b = coef(m) , Sigma = vcov(m) , Terms = 3:5)

# Terms: An optional integer vector specifying which coefcients 
# should be jointly tested
# Terms defnes to compare which regression coefcients, 
# here we want to compare the 3 to 5 (first is the intercept)

# It gives as a result Chi-Squared test results and p-value of it 
# if p is smaller than 0.05 you can reject the null hypothesis



# Wald Test using multcomp package. 
library(multcomp)
regTermTest(m, "chol")
regTermTest(m, "age")

# 
regTermTest(m, c("chol","age"))
regTermTest(m, ~chol+age)

