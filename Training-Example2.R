
# Data is from https://archive.ics.uci.edu/ml/datasets/Credit+Approval

creditAppData  <- read.csv("https://bit.ly/2HRjkxj")


head(creditAppData)
summary(creditAppData)

attach(creditAppData)



m<-glm(Approved~Employed ,  family = binomial )
summary(m)



library(aod)
library(stats)
library(pROC)


# calculating the ODDs ratio 
exp(cbind(OR = coef(m)))




m2<-glm(Approved~Employed+Debt ,  family = binomial )
summary(m2)

# OR per 10 unit increase 
# m$coefficients gives me access to coefficient values
exp(m2$coefficients[3]*10)


creditAppData$prob.m2<-predict(m2,  type=c("response") )
g <-roc(creditAppData$Approved ~ creditAppData$prob.m2) 

print(g)
plot(g)


plot( 1-g$specificities, g$sensitivities,    xlab = "1 - Specificity", ylab="Sensitivity", main="ROC Curve")
abline(a=0, b=1)




# Is there a correlation between Age, Income, Credit Score, and YearsEmployed and the credit approval status? 
# Can this relationship be used to predict if a person is granted credit? 

IncomeLog<-log(Income+0.001)
CreditScoreLog<-log(CreditScore+0.001)
YearsEmployed<-log(YearsEmployed+0.001)

m3<-glm(Approved~Age+IncomeLog+CreditScoreLog+YearsEmployed ,  family = binomial )

summary(m3)

# Global test 
# install.package("aod")
library(aod)

wald.test(b=coef(m3), Sigma = vcov(m3), Terms = 2:5)

