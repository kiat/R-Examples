# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
# emmeans:::convert_scripts()
# Load the smoker data set. 
data<- read.csv("Datasets/smoking_SBP.csv")
# Print out the data and check what it is inside
print(data)
# View(data)


attach(data)

# Create dummy variables
data$g0 <- ifelse(data$group=='Current heavy smoker', 1, 0)
data$g1 <- ifelse(data$group=='Current light smoker', 1, 0)
data$g2 <- ifelse(data$group=='Former smoker', 1, 0)
data$g3 <- ifelse(data$group=='Never smoker', 1, 0)


print("Our Data after addomg Dummy Variables")
print(data)
# View(data)


# One-way ANOVA using lm() function
m2 <- lm(data$SBP~data$g0+data$g1+data$g2, data=data)
summary(m2)

m3 <- lm(data$SBP~data$g1+data$g2+data$g3, data=data)
summary(m3)

m4 <- lm(data$SBP~data$g0+data$g2+data$g3, data=data)
summary(m4)



# First run a normal one way anova 
anova.model <- aov(data$SBP~group, data=data)
summary(anova.model)


# Install one time the "car" package. 
# install.packages('car')
# Re-run ANOVA adjusting for Age
library(car)

# ANCOVA
# Now we run ANVOA with adjusting for age 
Anova(lm(data$SBP ~ data$group + data$age), type=3)

# Type should be type 3 sum of squares. 
# It defines the different types of sums of squares.  Read more about it here 

# https://www.r-bloggers.com/anova-%E2%80%93-type-iiiiii-ss-explained/ 
  
# Least square means
# install.packages('lsmeans')  # one time installation only 

library(lsmeans)

# Set the options for lsmeans
options(contrasts=c("contr.treatment", "contr.poly"))

# Calculate the lsmeans 
lsmeans( lm(data$SBP~ data$group + data$age), pairwise~data$group, adjust="none")



# https://cran.r-project.org/web/packages/emmeans/vignettes/transition-from-lsmeans.html
# install.packages('emmeans')
library(emmeans)
my.model<-lm(SBP~group+age,  data = data)
emm_options(contrasts=c("contr.treatment", "contr.poly"))
emmeans(my.model, specs = "group")

# or with pairwise comnparisions 
emmeans(my.model, specs = "group", contr = "pairwise")



