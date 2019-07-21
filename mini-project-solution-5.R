data <- read.csv("Datasets/2018_-_2019_Class_Size_Pct_District_MSHS.csv")

#Get a sample of the dataset to review
head(data)

#Review the grade level column
unique(data$Grade.Level)

#Review the department column
unique(data$Program.Type)

#Review the department column
unique(data$Department)

#Cut data to only get first 500 rows
data.formatted500 <- data[1:500,]

#View new data to see if any issues
head(data.formatted500)

# It looks like the class size column has some non-numeric values. This will cause issues if we want to create a histogram
class(data.formatted500$Class.Size)

# To resolve, we can either force the column to convert to a numeric data type or we could create
# a new column which has the class size number. Since I want precision in my numbers that the 
# current class size column does not have (might mention less than a number), I am going to 
# manual create a new column for us with the more precise class size number
data.formatted500$Class.Size.Precise <- data.formatted500$Number.of.Students / data.formatted500$Number.of.Classes

# Review to ensure accuracy of changes
head(data.formatted500)



# Now let's create our histograms and boxplots at the aggregate level
hist(data.formatted500$Class.Size.Precise, main = "Class Size Histogram", xlab = "Size of Classroom")
boxplot(data.formatted500$Class.Size.Precise, main = "Class Size", xlab = "All Departments")

# Now let's create our histograms and boxplots at the departmental level: English, Science, Math, and Social Studies

# First let's do the boxplot
boxplot(data.formatted500$Class.Size.Precise[data.formatted500$Department == "Math"],
        data.formatted500$Class.Size.Precise[data.formatted500$Department == "Science"],
        data.formatted500$Class.Size.Precise[data.formatted500$Department == "Social Studies"],
        data.formatted500$Class.Size.Precise[data.formatted500$Department == "English"],
        main = "Class Size per Department", names = c("Math", "Science", "Social Studies", "English"), 
        ylab = "Class Size")


#Next let's do the histogram. To start we must format the viewing area appropriately 
par(mfrow = c(2,2))

# Display histograms in viewing area
hist(data.formatted500$Class.Size.Precise[data.formatted500$Department == "Math"], main = 
       "Class Size Histogram - Math", xlab = "Class Size", ylab = "Frequency")
hist(data.formatted500$Class.Size.Precise[data.formatted500$Department == "Science"], main = 
       "Class Size Histogram - Science", xlab = "Class Size", ylab = "Frequency")
hist(data.formatted500$Class.Size.Precise[data.formatted500$Department == "Social Studies"], main = 
       "Class Size Histogram - Social Studies", xlab = "Class Size", ylab = "Frequency")
hist(data.formatted500$Class.Size.Precise[data.formatted500$Department == "English"], main = 
       "Class Size Histogram - English", xlab = "Class Size", ylab = "Frequency")


x <- aov(Class.Size.Precise ~ Department, data = data.formatted500)
summary(x)

#You can see very high values for each variable 
pairwise.t.test(data.formatted500$Class.Size.Precise, data.formatted500$Department)