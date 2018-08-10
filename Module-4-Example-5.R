# Read the data first
states <- read.csv("https://raw.githubusercontent.com/kiat/R-Examples/master/Datasets/states.csv")

attach(states)

# data <-data.frame(poverty, metro_res, white, hs_grad, female_house)


m <- lm(poverty~female_house+white)

# Summar function can calculate almost everything that you need. 
summary(m)



# Using anova table 
anova_table <-anova(m)
anova_table

SSE <-anova_table$`Sum Sq`[3]
SSE


SST <-anova_table$`Sum Sq`[1]+anova_table$`Sum Sq`[2]+anova_table$`Sum Sq`[3]
SST

R2 <- (anova_table$`Sum Sq`[1]+anova_table$`Sum Sq`[2]) / SST


# adjusted R^2
# adjusted_R2 <-  1 - (SSE/SST )  * (( n - 1 ) / ( n - k - 1) )
# n number of samples
# k number of independent varaibles 

adjusted_R2 <-  1 - (SSE/SST )  * (( length(poverty) - 1 ) / ( length(poverty) - 2 - 1) )



# A second model - Simple Linear Regression Only considering the age 
m2 <- lm(poverty~female_house)
anova_table2<-anova(m2)
anova_table2

totalss_anova2 <-anova_table2$`Sum Sq`[1]+anova_table2$`Sum Sq`[2]
totalss_anova2

# A third  model - Simple Linear Regression Only considering the height  
m3 <- lm(poverty~white)
anova_table3<-anova(m3)
anova_table3

totalss_anova3 <-anova_table3$`Sum Sq`[1]+anova_table3$`Sum Sq`[2]
totalss_anova3
