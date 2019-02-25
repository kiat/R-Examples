# One and Two Sample Tests for Proportion


# One Sample Tests for a Proportion

# Example:
# We are interested in estimating the proportion of children in the
# county that are vaccinated for measles. We suspect that it may be
# as low as 80%. A random sample is taken of 100 children from the
# county. Of those sampled, only 70 were vaccinated. Formally test
# if the proportion of vaccinated children is different than 80%.

# See the manual page for prop.test() function 
?prop.test

# The procedure gives a chi-square statistic which is equal to the square of the z-statistic.
# http://sphweb.bumc.bu.edu/otlt/MPH-Modules/BS/R/R-Manual/R-Manual13.html 

# One Sample Tests for a Proportion 
prop.test (70 , 100 , p=0.8 , conf.level=0.95 , correct=FALSE)


# One Sample Tests for a Proportion with continuity correction 
prop.test (70 , 100 , p=0.8 , conf.level=0.95 , correct=TRUE)


# Two-Sample Tests for Proportions

# Example:
# An investigator is interested in the long-term effects of preschool
# programs on low-income children. A study was conducted where by two
# groups of children were followed over time. The first group of 61
# children did not attend preschool. The second group of 62 children
# (from similar areas and with similar backgrounds of those in the
# first sample) attended preschool as 3- and 4-year-olds. The need
# for social programs as adults was the outcome of interest. Of the
# group who did not attend preschool, 49 of them needed social
# services (mainly welfare) between the ages of 18 and 30. In the
# preschool group, 38 required social services in the same age range.

# Two Sample Test for Proportion 
prop.test(c(49, 38) , c(61, 62) , conf.level =0.95 , correct=FALSE)

# Two Sample Test for Proportion with Continuity Correction
prop.test(c(49, 38) , c(61, 62) , conf.level =0.95 , correct=TRUE)




