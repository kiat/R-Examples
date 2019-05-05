# Breast Mass 

BreastMass<-read.csv("Datasets/BreastW.csv")
View(BreastMass)
attach(BreastMass)

BreastMass$Mass_level<-ifelse(Clump_Thickness>=6,1,0)
View(BreastMass)

table(Clump_Thickness,BreastMass$Mass_level)
prop.test (342 , 499 , p=0.6 , conf.level=0.95 , correct=FALSE)
prop.test (342 , 499 , p=0.6 , conf.level=0.95 , correct=TRUE)
