
babyData <- rnorm(100, mean = 3500, sd=500)


# Create two plots side by cide 
# First we set the par
par(mfrow=c(1,2)) # Make device region 1 by 2

# Here the first plot which is a histogram 
hist(babyData, prob=TRUE, col="cyan", main="You Type Something Here")

# Line is not a plot command so that it goes to the previous plot command. 
lines(density(babyData),lwd=3,col="red")

# Here is the second plot command
plot(density(babyData),lwd=3,col="red",main="")

# now the title 
title(main="Density Plot")

# And now set back the par to the originial setting. 
# This step is a good practice so that you set the par back to what it was. 
par(mfrow=c(1,1))


