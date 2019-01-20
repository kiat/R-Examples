# Assume that I have the following data sets for x and y (independent and dependent variables)
x <- c(1, 2, 3, 4, 5)
y <- c(1, 2, 3, 4, 5)

plot(x, y, xlim=c(0,6), ylim=c(0,6))
# let us put a lable on each point
text(x, y+0.4,labels=x)

errorCal <- function(beta0, beta1, x, y){
  
  errorVal <- sum( (y - (beta1 * x + beta0))^2)
  # print(paste("Beta0= ", beta0))
  # print(paste("Beta1= ", beta1))
  # print(errorVal)
  return(errorVal)
}


# Let us assume that we know the beta0 = 0 

# Know we calculate the error value for 200 different beta1 from -100 to 100. 
# Visualize it at the end and you will a see a convex function :) 

errorValues <-c()
beta1Values <-c()
count<-1
for (beta1 in seq(-100, 100, length.out = 300) ){
    beta1Values[count] <- beta1
    errorValues[count] <- errorCal(0, beta1, x , y)
    count <- count + 1
    
}



plot(errorValues)

# create a nice line 
plot(errorValues, type="l")


# text(beta1Values, errorValues+0.4,labels=x)


# We see that the minimum is on zero point. 
min(errorValues)
index<-which(errorValues == min(errorValues))
beta1Values[index]
##############################################




# In the following example we are looking for both beta1 and beta0
#############################################


errorValues <-c()
beta1Values <-c()
beta0Values <-c()
count<-1

for (beta0 in seq(-2, 2, length.out = 300) ){
  
  for (beta1 in seq(-2, 2, length.out =300) ){
    beta0Values[count] <- beta0
    beta1Values[count] <- beta1
    errorValues[count] <- errorCal(beta0, beta1, x , y)
    count <- count + 1
  }
}

length(beta1Values)

# We see that the minimum is on zero point. 
min(errorValues)
index<-which(errorValues == min(errorValues))
beta1Values[index]
beta0Values[index]


# Now let us visualize this. 
# install.packages("plotly")
library(plotly)


p <- plot_ly(x = ~beta0Values, y = ~beta1Values, z = ~errorValues, type = 'mesh3d')
p
