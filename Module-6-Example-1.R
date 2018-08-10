

clinical.trial <-  data.frame(patient = 1:100, 
                              age = rnorm(100, mean = 60, sd = 6),
                              treatment = gl(2, 50, labels = c("Treatment", "Control")),
                              center = sample(paste("Center", LETTERS[1:5]), 100, replace = TRUE))

## set some ages to NA (missing)

is.na(clinical.trial$age) <- sample(1:100, 20)

summary(clinical.trial)


## a simple example of a table call
table(clinical.trial$center)



# For example 2, we need to create a logical vector indicating whether or not a patient is under 60 or not. 
# We can then pass that into the table function. Also, since there are missing ages, we might be interested 
# in seeing those in the table also. It is shown both ways by setting the “useNA” argument to table.

## a logical vector is created and passed into table
table(clinical.trial$age < 60)

## the useNA argument shows the missing values, too
table(clinical.trial$age < 60, useNA = "always")


table(clinical.trial$age > 60)
