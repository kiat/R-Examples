
hospitals <- read.table("https://bit.ly/2qZwdMn", header =T) 

# remove the first column 
hospitals <- hospitals[,-1]


# Create factors variables   
hospitals$Region <- as.factor(hospitals$Region)
hospitals$Med.school <- as.factor(hospitals$Med.school)

attach(hospitals)

# remove categorical variables for the purposes of graphing
hospitals_num <- hospitals[,c(-7,-8)]
pairs(hospitals_num)

library(psych)
# create a scatter plot matrix 
pairs.panels(hospitals_num)


lm <- lm(Infection.risk ~ hospitals_num$Culture, data = hospitals_num)
summary(lm)

# How well your model fits the data? 



# Which other variables would you use to predicit infection risk using Multiple Linear Regression?
lm1 <- lm(Infection.risk ~ . , data = hospitals)
summary(lm1)



# Facilities, Culture, Length.of.stay
# Select significant variables and build your multiple 
lm2 <- lm(Infection.risk ~ hospitals_num$Length.of.stay + hospitals_num$Culture + hospitals_num$Facilities+hospitals$X.ray, data = hospitals)
summary(lm2)







# H_0 is that mean of all group are the same 
# H_1 at least one mean that is different 

m<-aov(Infection.risk~Region, data=hospitals)
summary(m)


pairwise.t.test(Infection.risk, Region, p.adjust.method = "none")
pairwise.t.test(Infection.risk, Region, p.adjust.method = "bonferroni")
TukeyHSD(m, conf.level = 0.90)



library(car)
library(lsmeans) # is depricated 
library(estimability)
library(emmeans)

Anova(lm(Infection.risk~Region+Nurses, data=hospitals), type=3)

# after adjusting for Nurses we see the Region is not siginificat here 
# And Number of nurses is drving here 



options(contrasts =c("contr.treatment","contr.poly") )
lsmeans(lm(Infection.risk~Region+Nurses, data=hospitals), pairwise~Region, adjust="Tukey" )



m<-aov(Infection.risk~Nurses, data=hospitals)
summary(m)


m<-aov(Infection.risk~Region+Nurses, data=hospitals)
summary(m)

