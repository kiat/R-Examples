# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
rm(list = ls())

# https://www.r-bloggers.com/evaluating-logistic-regression-models/

# If you have some trouble with packages on MacOS use the following link 
# https://swvanderlaan.github.io/post/getting-r-with-tcl-tk-on-my-mac/

library(aod)
library(stats)
library(pROC)

library(survey)

# Heart disease is a comprehensive disease that many factors can contribute to its morbidity.
# To figure out the relationship between some common factors or heart related factors and the incidence, a study group set the Cleverland database of about 300 
# people about their sex, age and so on, and whether they have heart disease.
# First they want to know whether there are some common factors that influence the morbidity.

# Link to original data set https://archive.ics.uci.edu/ml/datasets/Heart+Disease
# The link to the original data:  https://www.kaggle.com/ronitf/heart-disease-uci/version/1

data<-read.csv("Datasets/heart-disease.csv")

head(data)

# Now let us separate the data set into two parts of train and test. 

## 75% of the sample size
smp_size <- floor(0.75 * nrow(data))

## set the seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train.Data <- data[train_ind, ]
test.Data <- data[-train_ind, ]


m <- glm(heart.target ~ heart.age  + heart.sex + heart.chol,   data=train.Data, family = "binomial")
summary(m)


# Find the optimal cutOff
# Default cutoff is 0.5
# Chaning the cutoff can improve the accuracy 
# prob <-predict(m, type=c("response"))
predictValues <- predict(m , newdata = test.Data,  type = "response")
# log_predict <- predict(m , newdata = test.Data)


final.prediction <- ifelse(predictValues > 0.5, 1, 0)

# install.packages("caret")
# install.packages('e1071', dependencies=TRUE)
library(caret)

cm <- confusionMatrix(as.factor(final.prediction), as.factor(test.Data$heart.target))
print(cm)


#plot ROC
library(ROCR)
library(Metrics)
pr <- prediction(predictValues,  test.Data$heart.target)
perf <- performance(pr, measure = "tpr",x.measure = "fpr")
plot(perf)
auc(test.Data$heart.target, predictValues)


# The InformationValue::optimalCutoff function provides ways to find 
# the optimal cutoff

# install.packages("InformationValue")
library(InformationValue)
optCutOff <- optimalCutoff(actuals=test.Data$heart.target, predictedScores=predictValues, optimiseFor="Both", returnDiagnostics=TRUE)

optCutOff$optimalCutoff
# optCutOff$optimalCutoff
# [1]0.4014107







