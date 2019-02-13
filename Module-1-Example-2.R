# set the seed so that the random data is generate by this seed 
set.seed(1234)

# Baby Weight Data, let us generate a random dataset with 100 observation 
# We generate random data by using normal distribution. 
babyData <- rnorm(100, mean = 3500, sd=500)

# plot the data to see how your data looks 
plot(babyData)

# make a barplot 
barplot(babyData, ylim  = c(2000, 5000) )

# make a histogram 
hist(babyData)

# Another dataset but larger.  
#Let us generate large dataset with 1000 observation 
babyData1 <- rnorm(1000, mean = 3500, sd=500)

# make a histogram 
hist(babyData1)

# We can see that the histogram is getting closer to a perfect normal distribution curve. 


