# Read the data first
states <- read.csv("https://raw.githubusercontent.com/kiat/R-Examples/master/Datasets/states.csv")

attach(states)

# data <-data.frame(poverty, metro_res, white, hs_grad, female_house)


m <- lm(poverty~female_house)

# Summar function can calculate almost everything that you need. 
summary(m)

# Calulate R squared Manually and the P-Value

# Total Sume of Squared. 
totalss <- sum((poverty - mean(poverty))^2)

# Regression and Residual Sum of the Squered. 
regss <- sum((fitted(m) - mean(poverty))^2)

# Calulate R squared.
R2 <- regss/totalss

adjusted_R2<-1- (regss/totalss )

# Using anova table 
anova_table <-anova(m)
anova_table
totalss_anova <-anova_table$`Sum Sq`[1]+anova_table$`Sum Sq`[2]
totalss_anova

# A second model - Simple Linear Regression Only considering the age 
m2 <- lm(salary1~age)
anova_table2<-anova(m2)
anova_table2

totalss_anova2 <-anova_table2$`Sum Sq`[1]+anova_table2$`Sum Sq`[2]
totalss_anova2

# A third  model - Simple Linear Regression Only considering the height  
m3 <- lm(salary1~height)
anova_table3<-anova(m3)
anova_table3

totalss_anova3 <-anova_table3$`Sum Sq`[1]+anova_table3$`Sum Sq`[2]
totalss_anova3


