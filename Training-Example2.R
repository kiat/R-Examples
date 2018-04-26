
# Data is from https://archive.ics.uci.edu/ml/datasets/Credit+Approval


credits  <- read.csv("Datasets/CreditApprovalData.cvs")

head(credits)

summary(credits)


# Create factors variables   
credits$Male <- as.factor(credits$Male)
credits$Married <- as.factor(credits$Married)



nrow(credits)
summary(credits)



