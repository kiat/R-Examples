# Set your own working dir 
# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")


golfBals <- read.csv("Datasets/GolfBals.csv")
attach(golfBals)


# The function factor is used to encode a vector as a factor (the terms ‘category’ and ‘enumerated type’ 
# are also used for factors).
is.factor(golfBals$brand)

my_anova_Model <- aov(golfBals$distance~golfBals$brand)

# Or 
# my_anova_Model <- aov(golfBals$distance~golfBals$brand)
summary(my_anova_Model)


# pairwise test 
# Pairwise comparisons using t tests with pooled SD 
pairwise.t.test(distance, brand, p.adj='none')


# Define Dummy Variables 
golfBals$g0 <- ifelse(brand=='Callaway', 1, 0)
golfBals$g1 <- ifelse(brand=='Nike', 1, 0)
golfBals$g2 <- ifelse(brand=='Titleist', 1, 0)

# Create a multiple linear regression model 
my_linear_regression_model <- lm(distance~g1+g2, data=golfBals)

# Get the summary of the model 
summary(my_linear_regression_model)

