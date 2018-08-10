# Generate 200 random data points by using normal distribution function. (Default Values)
my.NiceData <- rnorm(200)

# Check the content of variable 
head(my.NiceData)

# Generate 200 random data points by using normal distribution function. Mean=0.8, SD=1
my.NiceData2 <- rnorm(200, mean=.8)

# See some data of this variable 
head(my.NiceData2)

# Draw a Histogram
hist(my.NiceData)

# Use 8 bins to plot a histogram
hist(my.NiceData, breaks=8, col="#CCCCFF")

# Instead of showing count, make area sum to 1, (freq=FALSE)
hist(my.NiceData, breaks=8, col="#CCCCFF", freq=FALSE)


# Create a variables for breaks and put breaks at every 0.6
# use seq function. read ?seq

boundaries <- seq(-3, 3.6, by=.6)

hist(my.NiceData, breaks=boundaries)


# Kernel density plot
plot(density(my.NiceData))

# str fucntion prints some good details about every object in R. 
utils::str(hist(my.NiceData))

