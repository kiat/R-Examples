# The following code is implemented by Teresa Filshtein 


#### Module 3 Office Hour ####

#install.packages('dplyr')
library(dplyr)
library(ggplot2)

### Generate Sample Data ###
set.seed(20190210)

sampdf = data.frame(
  Height = sample(50:80,size = 100, replace = TRUE)) %>%
  mutate(
    Weight = 100 + 1.7*Height + rnorm(100,mean = 0, sd = 10) # weight = b0 + b1*height + error
  )

head(sampdf) # lets look at the data

head(sampdf %>% arrange(Height)) # arrange in ascending order by height

#notice that two people can have the same height but won't have the exact same weight. 
#This is due to random error.


#(2) Let's get a sense of how our data looks and the way these two variables move together. 
# generate a scatterplot to see the form, direction, and strength of the association between the variables.
# Think about which variable is the independent variable (x axis), and which one is the dependent (y axis)?

# base R

plot(sampdf$Height,sampdf$Weight, main="Scatterplot of Weight vs Height",
xlab = "Height (inches) ", ylab="Weight (lbs)")

# ggplot

ggplot(data = sampdf, aes(x = Height, y = Weight)) + geom_point() + 
  labs(title = "Scatterplot of Weight vs Height", subtitle = "Weight increases with Height") +
  xlab("Height (inches)") + 
  ylab("Weight (lbs)") + 
  theme_bw()  

## You can see a lot in a graphic. 
## Remember - a picture is worth 1000 words - think about how much time you put into 1000 words of text. 
## what do you think about the direction?
## form? strength?
## This looks like a strong linear association. What would we expect to see if there was
## no association?
sampdf_non = data.frame(Height = sample(50:80,size = 100, replace = TRUE)) %>%
  mutate(
    Weight = 100 + rnorm(100,mean = 0, sd = 20) # weight = b0 + error
  )

ggplot(data = sampdf_non, aes(x = Height, y = Weight)) + geom_point() + 
  labs(title = "Scatterplot of Weight vs Height", subtitle = "Not a clear association") +
  xlab("Height (inches)") + 
  ylab("Weight (lbs)") + 
  theme_bw()  

## notice that knowing someone's height does not give you any information about a person's weight. 

###############


# Strength of the relatioship
# The correlation coefficient is one measure of the strength of the relationship

cor(sampdf$Height, sampdf$Weight) # pretty highly correlated. 

# lets get the correlation coefficient in the non associated data.

cor(sampdf_non$Height, sampdf_non$Weight)


## Now - we created this data - so we know exactly what the relationship is between 
## Height and Weight. But this is never usually the case in a real setting. 

## We use linear regression to estimate the relationship between and independent and dependent variable. 

# Simple Linear Regression: Y = b0 + b1X + error. One independent variable, one dependent variable. error ~ N(0,sigma) 
# We estimate three things: b0, b1, sigma. What are these variables?

# b0 = You can think of this as the baseline measurement. What would you expect a person's Weight to be if their Height was 0?
# This doesn't always make sense though. Can someone's height ever be zero? Often times people will center their X variable so that the 
# b0 is a meaninful number. 

# b1 is the amount that the dependent variable changes with every 1 unit increase in the independent variable
# for every inch increase, how much does your weight go up? (on average)

# sigma. Remember - due to measurment error, natural differences between individuals, etc., there will always be two individuals with the same 
# Height and different weights. This is captured and estimated by the error variable. In linear regression we assume that the error is normally distributed with a mean of zero and a standard deviation of sigma. 
# We want to estimate what sigma is (how much variation is there?)
# Notice that the error term has nothing to do with the height. What does this mean?
# One assumption of this model is that the independent variable and the error term are independent. 
# That means there is the same amount of natural variation for each level of height. 

#ok lets fit our model: 
# we use the lm() function (linear model)

fit1 = lm(Weight ~ Height, data = sampdf)

fit1 = lm(sampdf$Weight ~ sampdf$Height)


#use the summary function to get information about the fit
summary(fit1)

# recall what the true values were (bo = 100, b1 = 1.7, sigma = 10)

# In terms of testing the association, which parameter do we care about?
# b1. 

# so we want to test whether or not there is an association. Let's rephrase: 
# we want to know if there is a statistically significant linear association. 
# there could be an association but we might be not be able to find it with this test. 
# Why is that? Think of the assumptions of this test. 
# Maybe the association is non linear (will give you an example later)
# Maybe there is too much 'noise' (or error) and we can't find the association. Imagine if sigma was 50?
# maybe the error is highly correlated with the independent variable

# there are two ways we can test whether or not there is a signficiant association between
# height and weight (b1).


# Before performing any test you should think about the 5 step process: 

# 1. Set up Hypotheses, what is the null, what is the alternative. This is not just 
# a formality, it guides the rest of the process. 

# 2. Select the appropriate test-statistic (this depends on 1.)

# 3. State the decision rule (alpha level, p value)
# 4. Compute the test statistic
# 5. Conclusion: Make your decision.

# ANOVA or t-test
anova(fit1)

summary(fit1)

#confidence intervals
confint(fit1)




