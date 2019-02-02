
# t test with R 

# A scientist wishes to test the claim that great white sharks average 20 feet in length. 
# To test this, he measures 10 great white sharks. The measurements are 18.1, 23.4, 23.8, 24.1, 22.5, 19, 25.4, 23.1, 16.5, 26.7.

shark_len <- c(18.1, 23.4, 23.8, 24.1, 22.5, 19, 25.4, 23.1, 16.5, 26.7)

# calculate the t statistic 
t <- (mean(shark_len) - 20)/(sd(shark_len)/sqrt(length(shark_len)))

# calculate the probability from the t statistic pt
?pt

# calculate the p-value , we are doing a one-sided greater t-test 
p <- 1 - pt(t, df=length(shark_len)-1)



# print the p value 
print(p)

# Using the t.test function directyl 
# Please note that conf.level in the t.test function is used only to calculate the confidence intervals
t.test(shark_len, mu=20, alternative="greater", conf.level = 0.90)

# It is a good idea to put the results in a variables 
results<-t.test(shark_len, mu=20, alternative="greater")

# You can use the 
names(results)

