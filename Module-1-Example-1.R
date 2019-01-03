
# Read and Writing to Files, see Slides of Lecture 1 for additional info. 

# Reading from comma separated volume (CSV) file. We assume that our data is stored in a simple CSV text file.  
# Provide the specific file path on your computer  like this   days<-read.csv("/home/kia/Desktop/Example_Data.csv")
# or have the file in your current working directory
# This command will read the data into a special data type named "data frame".

# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

days <- read.csv("Datasets/Example_Data.csv", header = FALSE)

# To convert and flatten data from a data frame you can use the unlist command. 
myDays <- unlist(days, use.names=FALSE)

# myDays is now a simple vector data type that I can work with. 

# generate a histogram form data 
hist(myDays)

