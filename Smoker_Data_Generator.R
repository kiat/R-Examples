# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

# Current Heavy Smokers
chs<-rnorm(4, mean=143.3, sd=10.2)
chs_type<-rep("chs", 4)

# Current Light Smokers
cls<-rnorm(5, mean=135.0, sd=6.5)
cls_type<-rep("cls", 5)

# Former Smokers 
fs <-rnorm(4, mean=124.3, sd=3.5)
fs_type<-rep("fs", 4)

# Never Smokers 
ns <-rnorm(6, mean=111.8, sd=5.0)
ns_type<-rep("ns", 6)

# creating vector for blood pressure 
SBP<-c(chs, cls, fs, ns)
group<-c(chs_type, cls_type,  fs_type, ns_type)

smoker<-data.frame(SBP, group)

write.csv(smoker, file = "smoker.csv", quote = F, row.names = FALSE)



