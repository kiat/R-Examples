# Read data from csv file 
data <- read.csv("Datasets/titanic_refined_500records.csv", header = TRUE)
attach(data)

#add a dummy group for Sex, female =1 , male =0
data$Sex1 <- ifelse ( data$Sex == "female",1,0)

#read data set basic information
length(data$Survived)

#create sub data set basic on data characters
library(dplyr)
library(pROC)

#all female data sub set
femaleData <- subset(data, data$Sex1 == 1)

#all male data sub set
maleData <- subset(data, data$Sex1 == 0)

#all survivors data sub set
surviveData <- subset(data, data$Survived == 1)

#get female survivors dataset
surviveFemale <- subset(surviveData, surviveData$Sex1 == 1)

#get male survivors dataset
surviveMale <- subset(surviveData, surviveData$Sex1 == 0)

#data summary
summary(data)

#female data summary
summary(femaleData)

#male data summary
summary(maleData)

#survived female data summary
summary(surviveFemale)

#survived male data summary
summary(surviveMale)

#aggregate survived people by Pclass
aggregate(surviveData$Survived, by = list(surviveData$Pclass), length)

#aggregate all passengers by Pclass
aggregate(data$Survived, by = list(data$Pclass), length)

#aggregate all passengers by Sex
aggregate(data$Survived, by = list(data$Sex), length)

#aggregate survived passengers by Sex
aggregate(surviveData$Survived, by = list(surviveData$Sex), length)

#survivors age range of female
summary(surviveFemale$Age)

#survivors age range of male 
summary(surviveMale$Age)

#draw histogram of survived males based on age
hist(surviveMale$Age, breaks = seq(0,80, by =10),main = "Histogram of Survived Male on Age Ranges", xlab = "Age range", border = "blue", col = "green")

#draw histogram of male passengers based on age
hist(maleData$Age, breaks = seq(0,80, by =10),main = "Histogram of Survived Male on Age Ranges", xlab = "Age range", border = "blue", col = "red")

#draw histogram of survived males based on Pclass
hist(surviveMale$Pclass, breaks = seq(0,3,by=1),main = "Histogram of Survived Male on Pclass", xlab = "Pclass", border = "blue", col = "green")

#draw histogram of male passengers based on Pclass
hist(maleData$Pclass, breaks = seq(0,3,by=1),main = "Histogram of Survived Male on Pclass", xlab = "Pclass range", border = "blue", col = "red")

#run prop test for male and female survivors compare
prop.test(c(143,64),c(188,312),conf.level = 0.95,correct = FALSE)

#Perform a logistic regression with sex as the only explanatory variable
m1 <- glm(data$Survived ~ data$Sex1, family = binomial)
summary(m1)

exp (cbind (OR = coef (m1), confint.default (m1)))

#check c-statistic (ROC) for the model
data$prob <- predict(m1, type = c("response"))
g <- roc(data$Survived ~ data$prob)
print(g)

#run prop test for Pclass and survivors compare
prop.test(c(82,63,62), c(132,122,246),conf.level = 0.95,correct = FALSE)

#Perform a logistic regression with Pclass as the only explanatory variable
m2 <- glm(data$Survived ~ data$Pclass, family = binomial)
summary(m2)

exp ( cbind (OR = coef (m2), confint.default (m2)))

data$prob <- predict(m2, type = c("response"))
g2 <-roc(data$Survived ~ data$prob)
print(g2)

#run prop test for Pclass and survived males compare
prop.test(c(25,11,28), c(72,66,174),conf.level = 0.95, correct = FALSE)

#Perform a logistic regression with Pclass as the only explanatory variable
m3 <- glm(surviveMale$Survived ~ surviveMale$Pclass, family = binomial)
summary(m3)

exp(cbind (OR = coef (m3), confint.default (m3)))


