setwd("/home/kia/Dropbox/Teaching/BU-Teaching/BU-CS555-Data-Analytics-Class/R-Examples/")

# install.packages("aod")
# install.packages("pROC")

library(aod)
library(stats)
library(pROC)




data<-read.csv("cevent.csv")

attach(data)
# print a small part of the data 
head(data)


m <- glm(data$event ~ data$chol, family = binomial) 

summary(m)

# ORs per 1 unit increase 
# same as calculation by hand (OR): exp(0.02119)
exp(cbind(OR = coef(m), confint.default(m)))



# OR per 10 unit increase 
exp(m$coefficients[2]*10)
exp((m$coefficients[2]-qnorm(0.975)*summary(m)$coefficients[2,2])*10)
exp((m$coefficients[2]+qnorm(0.975)*summary(m)$coefficients[2,2])*10)

# predict risk for each patient
risk <-predict(m, type=c("response"))

risk 


# predict risk for patient with chol of 190: exp(-3.12716+0.02119*190)/(1+exp(-3.12716+0.02119*190))
risk[41]
exp(m$coefficients[1] + m$coefficients[2]*190) / (1+exp(m$coefficients[1] + m$coefficients[2]*190))



# multiple logistic regression 
data$male <- ifelse(data$sex =="M", 1, 0)
m2<-glm(data$event ~ data$chol + data$male + data$age, family=binomial)
summary(m2)

# Global test 
# install.package("aod")
library(aod)

wald.test(b=coef(m2), Sigma = vcov(m2), Terms = 2:4)

# ORs per 1 unit increase 
exp(cbind(OR = coef(m2), confint.default(m2)))

# ROC curve 
# install.package("pROC")
library(pROC)

# using model with chol and sex and age 
data$prob <-predict(m2, type=c("response"))

# ROC Curve 
g <- roc(data$event ~ data$prob)
plot(g)



plot(1- g$specificities, g$sensitivities, type="l", xlab="1-Specifity", ylab="Sensivity", main="ROC Curve")
abline(a=0, b=1)
grid()
