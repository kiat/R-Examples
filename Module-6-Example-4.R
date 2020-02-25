# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
# install.packages("aod")
# install.packages("pROC")
library(aod)
library(stats)
library(pROC)
data<-read.csv("Datasets/cevent.csv")

attach(data)
# print a small part of the data 
head(data)

# multiple logistic regression 
data$male <- ifelse(data$sex =="M", 1, 0)
m2<-glm(data$event ~ data$chol + data$male + data$age, family=binomial)
summary(m2)

# ROC curve 
# install.package("pROC")
library(pROC)

# using model with chol and sex and age 
data$prob <-predict(m2, type=c("response"))

roc.info <-roc(data$event ~ data$prob, legacy.axes=T)

# different thresholds 
roc.info$thresholds


roc.df <-data.frame(
  tpp=roc.info$sensitivities * 100,
  fpp=(1-roc.info$specificities) * 100,
  threshholds = roc.info$thresholds
)

# look at the head of this dataframe
head(roc.df)

# look at the tail of this dataframe 
tail(roc.df)

# Filter all of the values bigger than 40 and smaller than 80 
roc.df[roc.df$tpp > 40 & roc.df$tpp < 80, ]


############# 
# Partial ROC curve 
############

par(pty="s")

roc(data$event ~ data$prob, plot=TRUE, legacy.axes=T, percent=T, 
    xlab="False Positive (%)", ylab="True Positive (%)", col="blue", lwd=4, 
    print.auc=T, print.auc.x=45, partial.auc=c(100, 80), 
    auc.polygon = T, auc.polygon.col="gray"
    )

# 
# Compare ROC curves 
# 

# Let us do another classification like randomForest 
# install.packages("randomForest")
library(randomForest)

# Build the model for randomForest
rf.model <- randomForest(formula = factor(event) ~ . , data=data, importance = TRUE)
rf.model


par(pty="s")

# Logistic 
roc(data$event ~ data$prob, plot=TRUE, legacy.axes=T, percent=T, 
    xlab="False Positive (%)", ylab="True Positive (%)", col="blue", lwd=4,  print.auc=T, print.auc.x=45)

# Random Forest
plot.roc(data$event, rf.model$votes[,1], percent=T, col="green", lwd=4, print.auc=T, add=T, print.auc.y=40)
