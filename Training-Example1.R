
hospitals <- read.table("https://bit.ly/2qZwdMn", header =T) 

# remove the first column 
hospitals <- hospitals[,-1]


# Create factors variables   
hospitals$Region <- as.factor(hospitals$Region)
hospitals$Med.school <- as.factor(hospitals$Med.school)

attach(hospitals)

# remove categorical variables for the purposes of graphing
hospitals_num <- hospitals[,c(-7,-8)]
pairs(hospitals_num)

library(psych)
# create a scatter plot matrix 
pairs.panels(hospitals_num)

# Better maybe to use 


panel.cor <- function(x, y, digits=2, prefix="", cex.cor) 
{
  usr <- par("usr"); on.exit(par(usr)) 
  par(usr = c(0, 1, 0, 1)) 
  r <- abs(cor(x, y)) 
  txt <- format(c(r, 0.123456789), digits=digits)[1] 
  txt <- paste(prefix, txt, sep="") 
  
  if(missing(cex.cor)) 
    cex <- 0.8/strwidth(txt) 
  
  test <- cor.test(x,y) 
  # borrowed from printCoefmat
  Signif <- symnum(test$p.value, corr = FALSE, na = FALSE, 
                   cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                   symbols = c("***", "**", "*", ".", " ")) 
  
  text(0.5, 0.5, txt, cex = cex * r) 
  text(.8, .8, Signif, cex=cex, col=2) 
}


pairs(hospitals_num, upper.panel = panel.cor)



lm <- lm(Infection.risk ~ hospitals_num$Culture, data = hospitals_num)
summary(lm)

# How well your model fits the data? 



# Which other variables would you use to predicit infection risk using Multiple Linear Regression?
lm1 <- lm(Infection.risk ~ . , data = hospitals)
summary(lm1)



# Facilities, Culture, Length.of.stay
# Select significant variables and build your multiple 
lm2 <- lm(Infection.risk ~ hospitals_num$Length.of.stay + hospitals_num$Culture + hospitals_num$Facilities+hospitals$X.ray, data = hospitals)
summary(lm2)






# Q6 Are the infection risks in us Regions different? Write your Hypothesis and provide significant tests.
# 
# H_0 is that mean of all group are the same 
# H_1 at least one mean that is different 

m<-aov(Infection.risk~Region, data=hospitals)
summary(m)

#              Df Sum Sq Mean Sq F value Pr(>F)  
# Region        3   14.0   4.666   2.714 0.0484 *
# Residuals   109  187.4   1.719   

# We see that region factor variable is signinficant so that at least two of the regions are different in 
# terms of infection ratio. 


# If we want to know which exact regions are different we can do the pairwise comparision. 
# And if we want to be more correct we can adjust the p-value. 
pairwise.t.test(Infection.risk, Region, p.adjust.method = "none")
pairwise.t.test(Infection.risk, Region, p.adjust.method = "bonferroni")
# data:  Infection.risk and Region 
#     1     2     3    
#   2 1.000 -     -    
#   3 0.032 0.859 -    
#   4 1.000 1.000 1.000
# P value adjustment method: bonferroni 
#
#
# We can  see that region (1 and 3) are different after bonferroni adjustment. 

TukeyHSD(m, conf.level = 0.90)

# Fit: aov(formula = Infection.risk ~ Region, data = hospitals)

# $Region
# diff        lwr        upr     p adj
# 2-1 -0.4669643 -1.2537701  0.3198415 0.5168684
# 3-1 -0.9336873 -1.6952799 -0.1720946 0.0269952
# 4-1 -0.4794643 -1.4323334  0.4734048 0.6489580
# 3-2 -0.4667230 -1.2007205  0.2672746 0.4563333
# 4-2 -0.0125000 -0.9434612  0.9184612 0.9999891
# 4-3  0.4542230 -0.4555290  1.3639749 0.6545991
# 
# Also in Tuky procedure we can see that two regions 3-1 are different. 



# Q7: Is number of Nurses in each hospital a significan covariate? Are the differences in different
# region driven by the number of Nureses?
# To answer the above question we need to do ANCOVA and consider the number of nurses as a covariate. 
# We check if the number of nurses is a covariate or not. 

library(car)
# library(lsmeans) # is depricated 
library(estimability)
library(emmeans)

Anova(lm(Infection.risk~Region+Nurses, data=hospitals), type=3)


# > Anova(lm(Infection.risk~Region+Nurses, data=hospitals), type=3)
# Anova Table (Type III tests)

#  Response: Infection.risk
#  Sum Sq  Df  F value    Pr(>F)    
#  (Intercept) 329.78   1 223.9144 < 2.2e-16 ***
#  Region       11.06   3   2.5028   0.06314 .  
#  Nurses       28.32   1  19.2287 2.703e-05 ***
#  Residuals   159.06 108 

# We see that region is no more significant and number of nurses is significant. 
# This means that the differences that we see in infection ratios is due to the differences in number of nurses 
# and not due to differences in region. 


# After adjusting for Nurses we see the Region is not siginificat here 
# And Number of nurses is drving here 
# We can adjust for number of nurses. 
emm_options(contrasts=c("contr.treatment", "contr.poly"))
my.model<-lm(Infection.risk~Region+Nurses, data=hospitals)
lsmeans(my.model, specs = "Region", contr = "pairwise" )



# Q8: Considering the case that Hospitals are affiliated medical school and they are in different reigons,
# are all of these hospitals different in terms of infection risks? 

# Med school (Yes or not) is categorical variable. 
# We need here to do two-way anova with two categorical variables (region and MedSchool) and one continous variable infection risks. 

typeof(Med.school)
# "integer" 
# We need to convert it to factor 

factorMed.School <- ifelse(Med.school==1, TRUE, FALSE)


typeof(factorMed.School)

model<-lm(Infection.risk~Region + factorMed.School + Region * factorMed.School, data=hospitals)
summary(model)

# We can see from the summary that none of the combinations are siginificant

interaction.plot(Region , Med.school, Infection.risk, col=1:2)

# We can see that the there is some interaction between some of the regions and med school 

# Two-way Anova 
Anova(model, type=3)



