
# Read and Writing to Files, see Slides of Lecture 1 for additional info. 

# Reading from comma separated volume (CSV) file. We assume that our data is stored in a simple CSV text file.  
# Provide the specific file path on your computer  like this   days<-read.csv("/home/kia/Desktop/Example_Data.csv")
# or have the file in your current working directory
# This command will read the data into a special data type named "data frame".

# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

days<-read.csv("Datasets/Example_Data.csv", header = FALSE)

# To convert and flatten data from a data frame you can use the unlist command. 
myDays <-unlist(days, use.names=FALSE)

# myDays is now a simple vector data type that I can work with. 

# generate a histogram form data 
hist(myDays)


#################################
#################################
####   Another Example   ########
#################################
#################################


# set the seed so that the random data is generate by this seed 
set.seed(1234)

# Baby Weight Data, let us generate a random dataset with 100 observation 
babyData <- rnorm(100, mean = 3500, sd=500)

# plot the data to see how your data looks 
plot(babyData)

# make a barplot 
barplot(babyData)

# make a histogram 
hist(babyData)

#Let us generate large dataset with 1000 observation 
babyData <- rnorm(1000, mean = 3500, sd=500)

# make a histogram 
hist(babyData)


#################################
#################################
####   Another Example   ########
#################################
#################################

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


utils::str(hist(my.NiceData))

#################################
#################################
#### Another Example     ########
#################################
#################################

par(mfrow=c(1,2)) # Make device region 1 by 2

hist(babyData, prob=TRUE, col="cyan", main="You Type Something Here")

lines(density(babyData),lwd=3,col="red")

plot(density(babyData),lwd=3,col="red",main="")

title(main="Density Plot")

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




