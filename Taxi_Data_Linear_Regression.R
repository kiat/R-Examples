# set your own working directory. This is mine. 
# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

# get the Taxi dataset from 
# http://www.nyc.gov/html/tlc/html/about/trip_record_data.shtml 
# Be carefull because the data files are large. 
# green taxi data is smaller than yellow taxis. 
# For example this one https://s3.amazonaws.com/nyc-tlc/trip+data/green_tripdata_2017-01.csv 

taxi <- read.csv("green_tripdata_2017-01.csv" )

head(taxi, n=4)

# plot(taxi$total_amount~taxi$trip_distance)

# filter the taxi data 
# we want to have only trip records that the total amoint is between 15 and 50 dollar 
# and trip distance is 
taxi<-taxi[ which(taxi$total_amount > 15 & taxi$total_amount < 50 & taxi$trip_distance > 5 & taxi$trip_distance < 20), ]

# taxi<-taxi[taxi$total_amount < 200, ]
# taxi<-taxi[taxi$trip_distance > 5, ]
# taxi<-taxi[taxi$trip_distance < 50, ]
#  &&  taxi$total_amount<200 && taxi$trip_distance > 50 && taxi$trip_distance<50 

# find the correlation 
cor(taxi$total_amount , taxi$trip_distance)

# plot the scatterplot 
plot(taxi$total_amount~taxi$trip_distance)

my.model<-lm(taxi$total_amount~taxi$trip_distance)

print(my.model)

abline(my.model, col="blue")

boxplot(taxi$total_amount)
