
# One sample test using asbio library 

# install.packages("asbio")
library(tcltk)
library(asbio)

?one.sample.z
# Read the documentation and make sure you understand it. 
# Provides a one-sample hypothesis test. 
# The test assumes that the underlying population is normal and furthermore that σ is known.




#################################
#################################
####      An Example     ########
#################################
#################################



# A gym is interested in whether a 6-week weight loss training program they launched has
# been successful in helping their clients lose weight. To assess this, they took a sample of
# 30 participants. They are interested in testing the following hypotheses:
  

# H_0 :μ=0 (there is no efect on weight change of program participants)
# H_1 :μ<0 (program participants lose weight on average)


one.sample.z(null.mu = 0, xbar = -2.98, sigma = 6, n = 30, alternative = "less")

# One sample z-test 
# z*            P-value
# -2.720355  0.00326059

# This is a small P-value. Thus we have strong evidence agians the null hypothesis. 





#################################
#################################
####   Another Example   ########
#################################
#################################

# Samples from 50 water sources throughout the county are taken and the levels of this
# chemical are measured. 
# They are interested in testing the following hypotheses:


# H0:μ=15 (the mean level of the chemical is normal)
# H1:μ≠15 (the mean level of the chemical is abnormal)
# Suppose we know that the population standard deviation is 6.2. The sample mean from
# the 50 samples was 16.4 ppm.
# 
# Calculate the value of the test statistic and the associated p-value.




one.sample.z(null.mu = 15, xbar = 16.4, sigma = 6.2, n = 50, alternative = "two.sided")

# One sample z-test 
# z*            P-value
# 1.596693     0.1103342

# It appears that the sample mean that we observed 
# (xbar=16.4) is moderately likely to have occurred if the true
# population mean was 15 ppm (if μ=15). 
# 
# This means we don’t have strong evidence against the null hypothesis.


