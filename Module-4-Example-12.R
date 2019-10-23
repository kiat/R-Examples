
# Transformation illustration. 

# Let us generate an example data 
set.seed(123456789)
# Create sequence of data between 1 and 50
x<-seq(1, 50)
y <- (runif(1, 0.1, 2.5) * x+ rnorm(50, mean = 2, sd = 6))^2

# The plot shows that this data does not have a linear pattern. 
plot(x, y)


m1 <- lm(y~x)
summary(m1)
# We see also in the residual plot that the data does not show a linear pattern. 
plot(x , resid(m1) )



# Now, let us transform the data to a new form. 
# We calculate the square root of y 
y1 <- sqrt(y)

# Now, data has a linear pattern. 
plot(x, y1)

m2 <- lm(y1~x)
summary(m2)

# Residual plot also shows a clear linear pattern. 
plot(x , resid(m2))

# It is important to know that after transformation, 
# we need to interepret all of the prediction results using the transformation function. 



