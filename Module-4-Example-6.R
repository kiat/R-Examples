# Matrix Operations in R  https://www.statmethods.net/advstats/matrix.html 
# Some good example https://datascienceplus.com/linear-regression-from-scratch-in-r/


data <- read.csv("Datasets/CEO_salary.csv")
salary1 <- data$salary/1000

y <- salary1
X <- as.matrix(cbind(data$age, data$height))

# vector of ones with same length as rows in y
int <- rep(1, length(y))

# Add intercept column to X
X <- cbind(int, X)

# Implement closed-form solution
betas <- solve(t(X) %*% X) %*% t(X) %*% y

# Round for easier viewing
betas <- round(betas, 2)

print(betas)



# Linear regression model
lm.mod  <- lm(salary1~ data$age + data$height)

# Round for easier viewing
lm.betas <- round(lm.mod$coefficients, 2)

# Create data.frame of results
results <- data.frame(our.results=betas, lm.results=lm.betas)

print(results)




