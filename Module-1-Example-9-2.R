# Read data from a CSV file with header as Dataframe.
customers<-read.csv("customers.csv")

# Access the content of each column
mean(customers$income)
median(customers$income)

# Create histogram of it
hist(customers$income/1000)

# Filter the data using subset command
female_customers <- subset(credit, Gender == "Female")

