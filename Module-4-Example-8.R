# This example will generate an animation. 
# It will first generate lots of png image files 
# and then use ImageMagick software to convert them into an animation. 

# Generate Animations
# Linear Regression with Gradient Descent
# https://www.r-bloggers.com/linear-regression-by-gradient-descent/

# generate random data in which y is a noisy function of x
x <- runif(1000, -5, 5)
y <- x + rnorm(1000) + 3

# Look at the scotterplot 
plot(y, x)

# fit a linear model
res <- lm( y ~ x )
print(res)

# plot the data and the model
plot(x,y, col=rgb(0.2,0.4,0.6,0.4), main='Linear Regression ')
abline(res, col='blue')


# squared error cost function
cost <- function(X, y, theta) {
  sum( (X %*% theta - y)^2 ) / (2*length(y))
}

# learning rate and iteration limit
alpha <- 0.01
num_iters <- 1000

# keep history
cost_history <- double(num_iters)
theta_history <- list(num_iters)

# initialize coefficients
theta <- matrix(c(0,0), nrow=2)

# add a column of 1's for the intercept coefficient
X <- cbind(1, matrix(x))


# gradient descent
for (i in 1:num_iters) {
  error <- (X %*% theta - y)
  delta <- t(X) %*% error / length(y)
  theta <- theta - alpha * delta
  cost_history[i] <- cost(X, y, theta)
  theta_history[[i]] <- theta
}

print(theta)



# function for creating file name with leading zeros
# makes it easier to process them sequentially
rename <- function(x){
  if (x < 10) {
    return(name <- paste('000',i,'plot.png',sep=''))
  }
  if (x < 100 && i >= 10) {
    return(name <- paste('00',i,'plot.png', sep=''))
  }
  if (x >= 100) {
    return(name <- paste('0', i,'plot.png', sep=''))
  }
}



# plot data and converging fit
for (i in c(1,2,3, seq(4, num_iters, by=2))) {
  name <- rename(i)
  
  #saves the plot as a .png file in the working directory
  
  png(name)
  plot(x,y, col=rgb(0.2,0.4,0.6,0.4), main='Linear Regression by Gradient Descent')
  # print(theta_history[[i]])
  abline(coef=theta_history[[i]], col=rgb(0.8,0,0,0.3),  lwd = 5)
  dev.off()
}
abline(coef=theta, col='blue')




# The following command will work if you have ImageMagick on your machine. 
#run ImageMagick
my_command <- 'convert *.png -delay 20 -loop 0 animation.gif'
system(my_command)




plot(cost_history, type='line', col='blue', lwd=2, main='Cost function', ylab='cost', xlab='Iterations')





      
      