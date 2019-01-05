days <- read.csv("Datasets/Example_Data.csv", header = FALSE)
# To convert and flatten data from a data frame you can use the unlist command. 

myDays <- unlist(days, use.names=FALSE)
# myDays is now a simple vector data type that I can work with. 

# Now plot the boxplot
boxplot(myDays)

# add manually an outlier here 
myDays <-c(myDays, 45)

# Now plot the boxplot
boxplot(myDays)

# you can turn the outlier detection off by setting outline=FALSE
boxplot(myDays, outline=FALSE)
