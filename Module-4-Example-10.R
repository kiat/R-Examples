# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")
library(car)

data <- read.csv("Datasets/CEO_salary.csv")
attach(data)

# Divid the Salary by 1000 to be able to better show the values.
salary1 <- salary/1000

# Now we create a New Data frame out of age, heit and Salary
data1 <- data.frame(age, height, salary1)

# Fit a Multiple Linear Regression model into data.
# Variables are Salary and age
lm(formula = salary1 ~ age + height)

# or better store the resulted model into a variable for further use.
m <- lm(salary1~age+height)

# See documentation of plot.lm 
# https://www.rdocumentation.org/packages/stats/versions/3.6.1/topics/plot.lm

par(mfrow = c(2,2))

plot(m, ask=F)

# Good resource for understanding the lm plots 

# https://data.library.virginia.edu/diagnostic-plots/


# Here we do some advanced regression diagnostics. 

par(mfrow = c(1,1))
# 
# https://www.statmethods.net/stats/rdiagnostics.html 

# Assessing Outliers
outlierTest(m) # Bonferonni p-value for most extreme obs
qqPlot(m, main="QQ Plot") #qq plot for studentized resid 
leveragePlots(m) # leverage plots



# Influential Observations
# added variable plots 
av.Plots(m)
# Cook's D plot
# identify D values > 4/(n-k-1) 
cutoff <- 4/((nrow(data1)-length(m$coefficients)-2)) 
plot(m, which=4, cook.levels=cutoff)

# Influence Plot 
influencePlot(m, id.method="identify", main="Influence Plot",
              sub="Circle size is proportial to Cook's Distance" )



# Normality of Residuals
# qq plot for studentized resid
qqPlot(m, main="QQ Plot")
# distribution of studentized residuals
library(MASS)
sresid <- studres(m) 
hist(sresid, freq=FALSE, 
     main="Distribution of Studentized Residuals")
xfit<-seq(min(sresid),max(sresid),length=40) 
yfit<-dnorm(xfit) 
lines(xfit, yfit)

# Evaluate homoscedasticity
# non-constant error variance test
ncvTest(fit)
# plot studentized residuals vs. fitted values 
spreadLevelPlot(fit)




