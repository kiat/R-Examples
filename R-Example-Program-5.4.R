# This R program requires the following two packages. 
# Install the following packages before running this program. 

# install.packages("openintro")
# OpenIntro data sets and supplemental functions

# install.packages("psych")
# A package for personality, psychometric, and psychological research

require(openintro)
require(psych)
require(tibble)


# SAT and GPA data for 1000 students at an unnamed college.
data(satGPA)

# Take a look at this data set 
?satGPA
# it includes the following attributes 
# sex , Gender of the student.
# SATV, Verbal SAT percentile.
# SATM, Math SAT percentile.
# SATSum, Total of verbal and math SAT percentiles.
# HSGPA, High school grade point average.
# FYGPA, First year (college) grade point average.



satGPA <- as.tibble(satGPA)

# Scatterplot matrix of SAT and GPA data set.
pairs.panels(satGPA[,-4], ellipse=F, col="red", lwd=2)
