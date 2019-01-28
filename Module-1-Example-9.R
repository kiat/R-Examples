#  The Skew-Normal and Related Distributions

# the following library can also be used to generate skewed data 
# install.packages("sn")
# library(sn)
# rightSkewed <- rsn(n=10000, xi = 9,  omega = 10, alpha = 7)
# leftSkewed <- rsn(n=10000, xi = 1,  omega = 5, alpha = 1, tau = 1)


# we use beta distribution to generate skewed data 

# set the random initial start as constant value 
set.seed(1)

# generate 3 different data sets. 

leftSkewed <- rbeta(4000,9,1.2)*40
rightSkewed <- rbeta(4000,1,9)*40
normalData<-rnorm(4000, mean = 20, sd=5)


# Begin with visualization. 

######################################################

par(mfrow=c(1,3))
######################################################

hist(leftSkewed, 
     probability=T, nclass=max(leftSkewed)-min(leftSkewed)+1, 
     col='lightblue', 
     main='Left Skewed' , border = F)

lines(density(leftSkewed,bw=1), col='red', lwd=3)

# plot(density(leftSkewed), main='Left Skewed' , col='red', lwd=3, type="l")


abline(v=mean(leftSkewed), col='blue', lwd=3)
abline(v=median(leftSkewed), col='green', lwd=3)

text(mean(leftSkewed)+2, .19, "Mean", cex = 1.6, col='blue')
text(mean(leftSkewed)+2, .20, "Median", cex = 1.6, col='green')


######################################################



hist(normalData, 
     probability=T, nclass=max(normalData)-min(normalData)+1, 
     col='lightblue', 
    main='Normal', border = F)


lines(density(normalData,bw=1), col='red', lwd=3)

#plot(density(normalData), main='Normal' , col='red', lwd=3, type="l")

abline(v=mean(normalData), col='blue', lwd=3)
abline(v=median(normalData), col='green', lwd=3)


######################################################




hist(rightSkewed, 
     probability=T, nclass=max(rightSkewed)-min(rightSkewed)+1, 
     col='lightblue', 
     main='Right Skewed', border = F)
ines(density(rightSkewed,bw=1), col='red', lwd=3)

# plot(density(rightSkewed), main='Right Skewed' , col='red', lwd=3, type="l")


abline(v=mean(rightSkewed), col='blue', lwd=3)
abline(v=median(rightSkewed), col='green', lwd=3)


text(mean(rightSkewed)-3, .12, "Mean", cex = 1.6, col='blue')
text(mean(rightSkewed)-3, .13, "Median", cex = 1.6, col='green')


######################################################
#     Optional Material - Skeweness tests 
######################################################

# Some good reference to read about it 
# https://en.wikipedia.org/wiki/Skewness
# https://help.gooddata.com/display/doc/Normality+Testing+-+Skewness+and+Kurtosis


# Test implementation in R 
# https://www.r-bloggers.com/measures-of-skewness-and-kurtosis/


# One time installation of moments package is needed. 
# install.packages("moments")
library(moments)



# SKEWNESS Test. 
# As a general rule of thumb:
# If skewness is less than -1 or greater than 1, the distribution is highly skewed.
# If skewness is between -1 and -0.5 or between 0.5 and 1, the distribution is moderately skewed.
# If skewness is between -0.5 and 0.5, the distribution is approximately symmetric.


# KURTOSIS
# Kurtosis tells you the height and sharpness of the central peak, relative to that of a standard bell curve.

# Values for a right Skewed, Positive  Skewed. 
skewness(rightSkewed)
kurtosis(rightSkewed)


# Values for a left Skewed, Negative Skewed 
skewness(leftSkewed)
kurtosis(leftSkewed)


# Values for a normal Skewed
skewness(normalData)
kurtosis(normalData)


