# Read and Writing to Files, see Slides of Lecture 1 for additional info. 
# Reading from comma separated volume (CSV) file. We assume that our data is stored in a simple CSV text file.  
# Provide the specific file path on your computer  like this   days<-read.csv("/home/kia/Desktop/Example_Data.csv")
# or have the file in your current working directory
# This command will read the data into a special data type named "data frame".

days <- read.csv("Datasets/Example_Data.csv", header = FALSE)

# To convert and flatten data from a data frame you can use the unlist command. 
my.days <- unlist(days, use.names = FALSE)


# Print basic statistics

mean (my.days)
median (my.days )
min (my.days )
max ( my.days )
quantile ( my.days )
var( my.days )
sd( my.days )

# Summary
summary(my.days)

# Create a boxplot
boxplot(my.days,
        main = "Boxplot of Data",
        ylab = "Values",
        col = "lightblue",
        border = "darkblue")

# my.days is now a simple vector data type that I can work with. 
# generate a histogram form data 
hist(my.days)



# Create a histogram
hist(my.days,
     main = "Histogram of Data",
     xlab = "Values",
     col = "lightgreen",
     border = "black",
     breaks = 10)

# Create a vector using seq function. 
break.points <- seq(from = 10, to = 36, by = 2)

# Create a histogram
hist(my.days,
     main = "Histogram of Data",
     xlab = "Values",
     col = "lightgreen",
     border = "black",
     breaks = break.points)

