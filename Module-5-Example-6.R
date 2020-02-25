# Install one time the "car" package. 
# install.packages('car')

library(car)

# Exercise example
exercise <- read.csv("Datasets/exercise.csv")
exercise
attach(exercise)


# Multivariate Analysis of Variance (MANOVA)
# Manova 
# Effect of PreStretch on 3 dependent varaibles 
mymodel.manova.PreStretch <-manova(cbind(Speed, Oxygen,Energy) ~ PreStretch )
summary(mymodel.manova.PreStretch)

# Summarize an Analysis of Variance Model
summary.aov(mymodel.manova.PreStretch)



# Effect of AnkleWeights on 3 dependent varaibles 
mymodel.manova.AnkleWeights <-manova(cbind(Speed, Oxygen,Energy) ~ AnkleWeights )
summary(mymodel.manova.AnkleWeights)

# Summarize an Analysis of Variance Model
summary.aov(mymodel.manova.AnkleWeights)

