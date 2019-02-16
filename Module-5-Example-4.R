# Install one time the "car" package. 
# install.packages('car')

library(car)

# Exercise example
exercise <- read.csv("Datasets/exercise.csv")
exercise
attach(exercise)

# Test interactions
# Enegery
model <- lm(Energy~PreStretch + AnkleWeights + PreStretch * AnkleWeights, data=exercise)

# You will get the same with the following model code. 
# model <- lm(Energy ~ PreStretch * AnkleWeights, data=exercise)
# model <- lm(Energy ~ PreStretch + AnkleWeights + PreStretch:AnkleWeights, data=exercise)
summary(model)
Anova(model, type=3)

# Speed
model1 <- lm(Speed~PreStretch+AnkleWeights+PreStretch*AnkleWeights, data=exercise)
summary(model1)
Anova(model1, type=3)

# Oxygen
model2 <- lm(Oxygen~PreStretch+AnkleWeights+PreStretch*AnkleWeights, data=exercise)
summary(model2)
Anova(model2, type=3)



# Generate interaction plots
interaction.plot(PreStretch, AnkleWeights, Energy, col=1:2)
interaction.plot(PreStretch, AnkleWeights, Speed, col=1:2)
interaction.plot(PreStretch, AnkleWeights, Oxygen, col=1:2)

#If interaction is significant, need to stratify (by more of the two factors) 
stretch <- exercise[which(PreStretch=='Stretch'),]
nostretch <- exercise[which(PreStretch=='No stretch'),]

# Enegery
summary(aov(Energy~AnkleWeights, data=stretch))
summary(aov(Energy~AnkleWeights, data=nostretch))

# Speed
summary(aov(Speed~AnkleWeights, data=stretch))
summary(aov(Speed~AnkleWeights, data=nostretch))

# Oxygen
summary(aov(Oxygen~AnkleWeights, data=stretch))
summary(aov(Oxygen~AnkleWeights, data=nostretch))
