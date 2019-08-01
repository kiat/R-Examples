# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

data <- read.csv("Datasets/CEO_salary.csv")
attach(data)

# Divid the Salary by 1000 to be able to better show the values.
salary1 <- salary/1000

# Now we create a New Data frame out of age, heit and Salary
data1 <- data.frame(age, height, salary1)

plot(salary1, age)

plot(salary1, height)

# You can also the following command to replace the column inside the original dataframe.
# data[,"salary"] <- salary1

# Calulate Correlation Coefficient
cor(data1)

# Plot Scatterplot Matrix
pairs(data1)

# Fit a Multiple Linear Regression model into data.
# Variables are Salary and age
lm(formula = salary1 ~ age + height)

# or better store the resulted model into a variable for further use.

m <- lm(salary1~age+height)

# Summar function can calculate almost everything that you need.
summary(m)

# Calulate R squared Manually and the P-Value

# Total Sume of Squared.
totalss <- sum((salary1 - mean(salary1))^2)

# Regression and Residual Sum of the Squered.
regss <- sum((fitted(m) - mean(salary1))^2)
resiss <- sum((salary1-fitted(m))^2)

# Calulate the F Value.
fstatistic <- (regss/2)/(resiss/97)

# The P-Value for F-Statistic.
pvalue <- 1-pf(fstatistic, df1=2, df2=97)

# Calulate R squared.
R2 <- regss/totalss

# Regression Diagnostics
# Residual Plots
resid(m)
par(mfrow=c(2,2))


plot(age, resid(m), axes=TRUE, frame.plot=TRUE, xlab='age', ylab='residue')
plot(height, resid(m), axes=TRUE, frame.plot=TRUE, xlab='height', ylab='residue')

plot(fitted(m), resid(m), axes=TRUE, frame.plot=TRUE, xlab='fitted values', ylab='residue')

hist(resid(m))



# influence function 
# This function provides the basic quantities which are used in forming a wide variety
# of diagnostics for checking the quality of regression fits.
influence(m)


# Checking for influence points 

# Cooks distance
cooks.dist <- cooks.distance(m)

# Where the cook's distance is higher than 4/(n-k-1) (k is the number if parameters in equation)
# 4/(102 - 2 -1) = 4/97

which(cooks.dist > (4/(nrow(data1)-2-1)))

#############################################################
# Identifying Influential Data Points
# https://newonlinecourses.science.psu.edu/stat501/node/340/




# Finding outliers 


# IQR Outlier detection.
outlier_iqr <- function(x){
  iqr <- IQR(x,na.rm = T,type = 7)
  q <- quantile(x)
  upper_bound = q[4]+(iqr*1.5)
  lower_bound = q[2]-(iqr*1.5)
  outliers <- which ((x > upper_bound) | (x < lower_bound))
  return(outliers)
}

# The two axises , X_1 and X_2
print(outlier_iqr(age))

print(outlier_iqr(height))


# The Y-Axis outlers 
print(outlier_iqr(salary1))


# How to remove data row from a dataframe 

dataRemoved <-  data1

dataRemoved <- dataRemoved[-c(1),]
  