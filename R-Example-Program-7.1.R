# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")



# Load the smoker data set. 
data<- read.csv("Datasets/smoker.csv")

attach(data)

print(data)


# Create dummy variables
data$g0 <- ifelse(data$group=='currentHeavySmokers', 1, 0)
data$g1 <- ifelse(data$group=='currentLightSmoker', 1, 0)
data$g2 <- ifelse(data$group=='formerSmoker', 1, 0)
data$g3 <- ifelse(data$group=='neverSmoker', 1, 0)

print("Our Data after addomg Dummy Variables")
print(data)



# One-way ANOVA using lm() function
m2 <- lm(data$SBP~data$g0+data$g1+data$g2, data=data)
summary(m2)

m3 <- lm(data$SBP~data$g1+data$g2+data$g3, data=data)
summary(m3)

m4 <- lm(data$SBP~data$g0+data$g2+data$g3, data=data)
summary(m4)



