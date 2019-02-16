# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")



# Load the smoker data set. 
data<- read.csv("Datasets/smoking_SBP.csv")
attach(data)

data

is.factor(data$group)

# Fit an Analysis of Variance Model
m<- aov(data$SBP~data$group, data=data)
summary(m)

# The F Distribution
# a=0.05 
# F Value for  df1=3, df2=15
qf(.95, df1=3, df2=15)

# anova model 
m1<- aov(formula = data$SBP ~ group, data = data)
# Calculating TukeyHSD
TukeyHSD(m1)

# Install package car "Companion to Applied Regression"
# one time installation needed only 
# install.packages("car")

library(car)
Anova(lm(data$SBP~data$group+data$age), type=3)


# calculating the lsmeans 
# lsmeans package is deprecated 
# install.packages("lsmeans")
# one time installation needed only 
# Least square means
# library(lsmeans)
# options(contrasts=c("contr.treatment", "contr.poly"))
# lsmeans(lm(data$SBP~data$group+data$age), pairwise~data$group, adjust="none")
# with none adjust=[method])
# Note: method = “tukey”, “scheffe”, “sidak", "bonferroni", “dunnettx", “mvt", "none")
# lsmeans(lm(data$SBP~data$group+data$age), pairwise~data$group, adjust="tukey")

# install.packages("emmeans")
library(emmeans)
my.model<-lm(SBP~group+age,  data = data)
emm_options(contrasts=c("contr.treatment", "contr.poly"))
emmeans(my.model, specs = "group")

# no p value adjustment 
emmeans(my.model, specs = "group" , contr = "pairwise",  adjust="none")

# P value adjustment: tukey method
emmeans(my.model, specs = "group" , contr = "pairwise",  adjust="tukey")

# P value adjustment: bonferroni method for 6 tests 
emmeans(my.model, specs = "group" , contr = "pairwise",  adjust="bonferroni")
