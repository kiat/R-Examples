

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





#################################
#################################
#### Another Example     ########
#################################
#################################


# Define a vector
x <- seq(from = -3, to = 3, length.out = 100)

# Apply the distribution density function to the vector
y <- dnorm(x)

# Plot it
plot(x, y, type="l")

# Shade an area from -1 to 1: define the area by specifying points along the outer edges and then use polygon function to fill the shape
xvalues <- x[x>=-1 & x<=1]
yvalues <- y[x>=-1 & x<=1]
region.x <- c(xvalues[1], xvalues, tail(xvalues, 1))
region.y <- c(0, yvalues, 0)

# print out the region.x to see what is inside. 
region.x

region.y

polygon(region.x, region.y, col="navy")


# Define a vector
curve(dnorm(x), xlim=c(-3,3), main='Normal Density')

# To shade the region represented by P(-3 < X < -2). 

# The first vertex we want for our polygon is (-3,0). 
cord.x <- c(-3)
cord.y <- c(0)

# The 2nd vertex will be (-3, f(-3)), f(-3) is the normal density evaluated at -3. 
cord.x <- c(cord.x, -3) 
cord.y <- c(cord.y, dnorm(-3)) 

# The 3rd and 4th vertices are (-2,f(-2)) and (-2,0)
cord.x <- c(cord.x, -2, -2)
cord.y <- c(cord.y, dnorm(-2), 0)

polygon(cord.x, cord.y, col="skyblue")




