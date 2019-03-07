#########################################
##
##  Module 6 Live Office Hour
##    Katherine Grzesik, 3/3/19
##
#########################################


# install.packages("aod")
# install.packages("pROC")
library(aod)
library(pROC)




## Creating a fake data set of men and women with how much they spent on gas 
##  and whether or not they purchases a slice of pizza

sex=rep(c(1,2),each=50)
set.seed(38281)
data<-data.frame(sex=sex,
           gas=c(rnorm(50,12,2),rnorm(50,20,3)),
           pizza=factor(c(rbinom(50,1,.50),rbinom(50,1,.20)),levels = c(0,1),labels=c("No","Yes")))

str(data)

data$sexDummy<-ifelse(data$sex==2,1,0)
data$sexFactor<-factor(ifelse(data$sex==2,"F","M"))

str(data)





## Let's take a look at the data
summary(data)

tt<-table(Pizza=data$pizza, Sex=data$sexDummy)

prop.male.pizza<-tt[2,1]/colSums(tt)[1]

prop.female.pizza<-tt[2,2]/colSums(tt)[2]

abs(prop.male.pizza-prop.female.pizza)









## Do the same proportion of men and women buy pizza when getting gas?

prop.test(x=tt["Yes",], n=colSums(tt), correct=FALSE)




## Do women buy pizza more or less frequently?

# Ha: first group prop > second group prop
prop.test(x=tt["Yes",], n=colSums(tt), correct=FALSE, alternative = "greater")

# Ha: first group prop < second group prop
prop.test(x=tt["Yes",], n=colSums(tt), correct=FALSE, alternative = "less")


## Chi-Square
sum((Exp - Obs)^2/Exp))
where Expectation assumes independence

addmargins(tt)


## Can we predict whether a person will get pizza based on their sex?

str(data)
m<-glm(pizza ~ sexDummy, data=data, family = binomial)
summary(m)


coef(m)
exp(coef(m)) # Females are less likely to get pizza since < 1
1/.1387 # Males are 7.2 times as likely as females to get pizza!

exp(confint.default(m))


## Reference Levels!
# If numeric, lowest number is reference
# If factor, defaults to alphabetical UNLESS you tell it which to use.

data$sexFactorFlipped<-relevel(data$sexFactor,ref = "M") # Makes MALE as reference

m.factor<-glm(pizza ~ sexFactor, data=data, family = binomial)
m.flipped<-glm(pizza ~ sexFactorFlipped, data=data, family = binomial)
coef(m.factor)
coef(m.flipped)

exp(confint.default(m.factor))


## Check how well the model predicts pizza purchasing

data$ProbofPizza<-predict(m, type="response") # Vector of P(getting pizza)

(g<-roc(data$pizza~data$ProbofPizza))
# C-statistics = 0.7228



## Create the ROC curve
plot(g, main="AUC=0.7228")




## Does how much a person spends on gas impact the pizza purchase?
## How does the sex of a person predict pizza purchase after adjusting for 
#  how much they spent in gas?

str(data)
m1<-glm(pizza~sexDummy + gas, data=data, family=binomial)
summary(m1)

exp(coef(m1))
1/.0628 # Males are ~16 times as likely to buy pizza than females, after accounting
# for the amount spent on gas
# Can only do this flip trick on DICHOTOMOUS CATEGORICAL VARIABLES


## What about for every 10 cents spent on gas? *Going from 1 penny to 1 dime 
coef(m1)
exp(coef(m1)["gas"]*10)

exp((m1$coefficients[3]-qnorm(.975)*summary(m1)$coefficients[3,2])*10)
exp((m1$coefficients[3]+qnorm(.975)*summary(m1)$coefficients[3,2])*10)

confint.default(m1)

exp(confint.default((m1))*10) # Yes, appropriate way to calculate them FOR ONLY the gas variable


## What about the ROC Curve and the C-Statistic now?

data$ProbofPizza2<-predict(m1, type="response")
(g2<-roc(data$pizza ~ data$ProbofPizza2))

plot(g2, main="AUC=0.7393")
plot(1-g2$specificities, g2$sensitivities, type="line")

g2$thresholds


data$Nonsense<-sample(c(0,1),nrow(data), replace=TRUE)
data$Nonsense2<-sample(c(0,1),nrow(data), replace=TRUE)
m3<-glm(pizza~Nonsense + Nonsense2, data=data, family=binomial)
summary(m3)

wald.test(b=coef(m3), Sigma=vcov(m3), Terms=2:3)


wald.test(b=coef(m), Sigma=vcov(m), Terms=2)  # .000069
wald.test(b=coef(m1), Sigma=vcov(m1), Terms=2:3) # .00032  <- model got worse, marginally so






## Extra Content - if time
## Cutoffs, Sensitivity, Specificity


## Source for these terms: https://www.med.emory.edu/EMAC/curriculum/diagnosis/sensand.htm

# Sensitivity: Probabilty of Detecting True Positive
# Sensitivity= true positives/(true positive + false negative)


# Specificity: Probability of Detecting a True Negative
# Specificity=true negatives/(true negative + false positives)




# Temp is a continuous variable, need to use temp_level
# Logisitic Regression REQUIRES a categorical outcome
> Q3.m3 <- glm(data.heart$temp ~ data.heart$girls, data = data.heart, family=binomial)
Error in eval(family$initialize) : y values must be 0 <= y <= 1











