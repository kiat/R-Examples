# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
data <- read.csv("Datasets/FIFA2019.csv", header = TRUE)

attach(data)
# histogram of Overall and Age to get idea of data
par(mfrow=c(2,1))
hist(Overall, main = "Frequency of Overall Ratings")

hist(Age, main = "Frequency of Player Age"
     ,xlim = c(15,40))
# both appear normal with a slight skew

par(mfrow=c(1,1))

plot(Age, Overall, 
     main="Overall Player Rating vs. Player Age", 
     xlab="Age", 
     ylab="Overall Rating", 
     xlim=c(15,40), ylim=c(45,80),
     pch=18, col="blue", cex.lab=1)

#linear, check with residuals, positive association

r <- cor(Overall, Age)
print(r)

# positive association, not very strong

# Formal Test of Correlation
# 1.  State  hypotheses and select the alpha
# H0: rho = 0, there is no linear association
# HA: rho <> 0 there is a linear assoctiation
alpha <- 0.05

# 2. Sekect the appropriate test statistic
t <- r*sqrt((nrow(data)-2)/(1-r**2))
#with df = n-2

# 3. State Decision Rule
ttest <- qt(p=0.025,df=nrow(data)-2, lower.tail = FALSE)
#Reject H0 if |t| >= ttest, otherwise do not reject
abs(t)>=ttest
# Reject H0 since 10.01 >= 1.966.  We have significant evidence at the alpha = 0.05 
# level that rho <> 0.  That is, there is evidence of a significant linear association
#between Age and Overall Rating in FIFA19

#Create Model - simple linear regression, age is the explanatory variable as our hypothesis
#is that Overall Rating increases as age increases.
my.model<-lm(Overall~Age, data = data)
summary(my.model)

plot(Age, Overall, 
     main="Overall Player Rating vs. Player Age", 
     xlab="Age", 
     ylab="Overall Rating", 
     xlim=c(15,40), ylim=c(45,80),
     pch=18, col="blue", cex.lab=1)
abline(my.model, col= "red")

# testing assumptions of linear regression - residuals should have normal distribution
hist(residuals(my.model),main= "Histogram of Residuals"
     ,xlab="Residuals")

# Regression Diagnostics - ensure relationship is not curved
# Residual Plots
par(mfrow=c(2,1))

plot(Age, resid(my.model), axes=TRUE, frame.plot=TRUE, xlab='age', ylab='residue')

plot(fitted(my.model), resid(my.model), axes=TRUE, frame.plot=TRUE, xlab='fitted values', ylab='residue')
#show that the distribution is skewed, but no apparent curvature



