library(data.table)

#https://www.kaggle.com/mohansacharya/graduate-admissions
data <- read.csv('Datasets/Admission_Predict.csv', header = T)
head(data)
setnames(data, old=c("Chance.of.Admit"), new=c("admit"))
attach(data)

cor(data)
plot(data$admit, data$CGPA)

#check for outlier
boxplot(data$CGPA)
summary(data)

#remove outlier
CGPA.out <- boxplot(CGPA)
out <- CGPA.out$out
which (data$CGPA %in% out)
data <- data[-59, ] 
data <- data[-59, ]

m <- lm(data$admit ~ data$CGPA + data$Research)
summary(m)
