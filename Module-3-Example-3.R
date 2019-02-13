# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
student <- read.csv("Datasets/students.csv")
student

attach(student)

study.hours<-hours

plot(hours, score, main="Scatterplot of exam score vs. hours of study", xlab="Hours of study", ylab="Score", 
     xlim=c(0,10), ylim=c(40,100), pch=1, col="red", cex.lab=1.5)


#calculate sample correlation
cor(study.hours, score)

cor(score, study.hours)

a <- cor(score, study.hours)
print(a)

my.model <- lm(student$score~student$hours)

# print the linearValues
print(my.model)

# or and use the intercept and score to draw a line 
# abline(51.515, 5.012)

# OR

# or just pass the result values of the lm function to draw a line 
abline(my.model)

# Calculate Confidence Intervals for Model Parameters
confint(my.model)

?confint


# default level is .90
confint(my.model, level = .90)


# report a summary of my model 
summary(my.model)

# create Analysis of Variance Table
anova(my.model)



# fitted values of my model 
fitted(my.model)

# residuals of my model 
resid(my.model)



# plot fitted values 
plot(fitted(my.model), residuals(my.model), axes = T, frame.plot = T, xlab = "fitted values", ylab="residue")


plot(score,  residuals(my.model), axes = T, frame.plot = T)


# histogram of the residuals
hist(residuals(my.model))


# Something more - not required for the class 
# As an extra task describe what these plots are 
layout(matrix(c(1,2,3,4), 2, 2 ))

plot(my.model)
