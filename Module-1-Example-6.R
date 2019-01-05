# This is a visualization example. 
# We want to visualize the normal distribution cure and color some part of it. 

# Define a vector
x <- seq(from = -3, to = 3, length.out = 100)

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

# Now, we can use the polygon function and color parts in skyblue color. 
polygon(cord.x, cord.y, col="skyblue")




