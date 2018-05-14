# PART - ONE - Generate random data for each student 

# First we generate for each student a different data set. 
#  install.packages("randomNames")
library("randomNames")

names <- randomNames(32, which.names = "first")
hours <- round(abs(rnorm(32, mean = 3, sd=2)), 1)



score <- 5 * hours  + 50 +  runif(32, 0, 30)
score <- ifelse(score>100, 100, score )
score <- ifelse(score< 50, 50, score )

data.for.student <- data.frame(names, hours, score)


write.table(data.for.student, file = "students.csv",row.names=FALSE, na="", sep=",", col.names = T, quote = FALSE)
# We provide each student with this data set. 
# Data is stored in a file name students.csv





# PART - TWO  - Assignment for each Student. 



# We provide each student a separate dataset and ask the following questions. 



# Now we can read it back
# 
# A research is interested to know if there is an association between the number of hours spent studying and the performance 
# on the final exam of a specific exam. 
student <- read.csv("students.csv")

# attach(student)
study.hours<-hours

# Provide a scotterplot of your data 
plot(hours, score, main="Scatterplot of exam score vs. hours of study", xlab="Hours of study", ylab="Score", 
     xlim=c(0,10), ylim=c(40,100), pch=1, col="red", cex.lab=1.5)


# Caclucate the correlation coefficient between hours of study and final score 
print(cor(study.hours, score))
# OR 
print(cor(score, study.hours)) 



# Fit a simple linear regression model 
my.model<-lm(student$score~student$hours)

# or and use the intercept and score to draw a line 
# abline(51.515, 5.012)

# or just pass the result values of the lm function to draw a line 
# abline(my.model)

# report a summary of my model 
summary(my.model)

# Model p-value: If you want to obtain the p-value of the overall regression model 
lmp <- function (modelobject) {
  if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
  f <- summary(modelobject)$fstatistic
  p <- pf(f[1],f[2],f[3],lower.tail=F)
  attributes(p) <- NULL
  return(p)
}


# Provide a values of the goblal F test. 
# HERE Answer 
print(summary(my.model)$fstatistic[1])

# Provide a values of the goblal F test. 
print(lmp(my.model))



# What is the R Squared of your simple linear regression model 
print(summary(my.model)$r.squared)





# Calculate Confidence Intervals for Model Parameters
confint(my.model)[1]
confint(my.model)[2]

# default level is .95
confint(my.model, level = .90)[1]
confint(my.model, level = .90)[2]


# fitted values of my model 
fitted(my.model)

# residuals of my model 
resid(my.model)



