
# The following code is implemented by Sarah Michelle Leatherman. 

Input = ("
Species   Temp   Pulse
 ex       20.8   67.9 
 ex       20.8   65.1 
 ex       24     77.3 
 ex       24     78.7 
 ex       24     79.4 
 ex       24     80.4 
 ex       26.2   85.8 
 ex       26.2   86.6 
 ex       26.2   87.5 
 ex       26.2   89.1 
 ex       28.4   98.6 
 ex       29    100.8 
 ex       30.4   99.3 
 ex       30.4  101.7 
 niv      17.2   44.3 
 niv      18.3   47.2 
 niv      18.3   47.6 
 niv      18.3   49.6 
 niv      18.9   50.3 
 niv      18.9   51.8 
 niv      20.4   60 
 niv      21     58.5 
 niv      21     58.9 
 niv      22.1   60.7 
 niv      23.5   69.8 
 niv      24.2   70.9 
 niv      25.9   76.2 
 niv      26.5   76.1 
 niv      26.5   77 
 niv      26.5   77.7 
 niv      28.6   84.7
")

data <- read.table(textConnection(Input),header=TRUE)

data$group<-factor(data$Species)
summary(data$Species)
summary(data$Species)/nrow(data)*100

# Summarize by species #
library(plyr)
ddply(data, "Species", summarise,
               N    = length(Pulse),
               mean = mean(Pulse),
               sd   = sd(Pulse) )

boxplot(Pulse~Species, data = data, main = "Pulse by Species",
        xlab = "Species",
        ylab = "Pulse")

ddply(data, "Species", summarise,
               N    = length(Temp),
               mean = mean(Temp),
               sd   = sd(Temp) )

boxplot(Temp~Species, data = data, main = "Temp by Species",
        xlab = "Species",
        ylab = "Temp")

# ANOVA #
m<-aov(Pulse~Species, data = data)
summary(m)

# Dummy variables #
data$n<-ifelse(data$Species == "niv", 1, 0)

m2<-lm(Pulse~n, data = data) #ex as reference
summary(m2)

# ANCOVA #
library(car)
library(lsmeans)

options(contrasts=c("contr.treatment","contr.poly"))

m3 <-lm(Pulse~n+Temp, data=data)
summary(m3)
Anova(lm(Pulse~Species+Temp, data=data), type =3)


# simple plot #
plot(x   = data$Temp, 
     y   = data$Pulse, 
     col = data$Species, 
     pch = 16,
     xlab = "Temperature",
     ylab = "Pulse")

legend('bottomright', 
       legend = levels(data$Species), 
       col = 1:2, 
       cex = 1,    
       pch = 16)

# simple plot with regression lines #

I.nought = -7.21091
I1 = I.nought + 0
I2 = I.nought + -10.06529
B  = 3.60275 

plot(x   = data$Temp, 
     y   = data$Pulse, 
     col = data$Species, 
     pch = 16,
     xlab = "Temperature",
     ylab = "Pulse")

legend('bottomright', 
       legend = levels(data$Species), 
       col = 1:2, 
       cex = 1,    
       pch = 16)

abline(I1, B,
       lty=1, lwd=2, col = 1)

abline(I2, B,
       lty=1, lwd=2, col = 2)
