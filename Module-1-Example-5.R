# This is a visualization example. 
# We want to visualize the normal distribution cure and color some part of it. 

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