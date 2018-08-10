# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

data <- read.csv("Datasets/CEO_salary.csv")
attach(data)

# Divid the Salary by 1000 to be able to better show the values. 
salary1 <- salary/1000

# Now we create a New Data frame out of age, heit and Salary
data1 <- data.frame(age, height, salary1)

# Install the package 
# install.packages("rgl")
# on MacOS install XQuartz

library(rgl)

# then you can create a 3D plot. 
plot3d(age, height, salary1, type = "s", size = .75, xlab="Age", ylab="Height", 
       zlab="Annual Salary")

