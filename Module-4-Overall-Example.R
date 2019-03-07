
# 
# The following code is implemented by Heather Shappell
# 
# Set the working directory. 
# setwd("C:\\Users\\hshap\\Documents\\CS 555 Assignments\\Teaching\\Week4")

#Read in data
library(xlsx)
# data<-read.xlsx("salary.xlsx",1)

data <- read.csv("Datasets/CEO_salary.csv")
data

#Correlation and Scatterplots - separately
cor(data$age,data$height)
cor(data$age,data$salary)
cor(data$height,data$salary)
cor(data)

#Scatterplot matrix - everything at once!
pairs(data)

##CODE TO MAKE THE PRETTY PLOT##
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...) {
  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y, use="complete.obs"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * (1 + r) / 2)
}

panel.hist <- function(x, ...) {
  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks
  nB <- length(breaks)
  y <- h$counts
  y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col="white", ...)
}

panel.lm <- function (x, y, col = par("col"), bg = NA, pch = par("pch"),
                      cex = 1, col.smooth = "black", ...) {
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  abline(stats::lm(y ~ x), col = col.smooth, ...)
}

pairs(data,upper.panel=panel.cor, diag.panel=panel.hist, lower.panel=panel.lm)



#Multiple Linear Regression
m<-lm(data$salary~data$age+data$height)
summary(m)

confint(m, level=.99)

#ANOVA table by hand (if you are curious about determine quantities, 
#NOT NECESSARY to do as F test is in the summary output - this is ONLY 
##for comparison with by hand calculations in module)
#DO NOT USE THIS CODE BELOW FOR YOUR HOMEWORK
totalss <-sum((data$salary -mean(data$salary))*(data$salary-mean(data$salary)))
regss <-sum((fitted(m) -mean(data$salary))*(fitted(m) -mean(data$salary)))
residss <-sum((data$salary-fitted(m))*(data$salary-fitted(m)))
fstatistic<- (regss/2)/(residss/97)
pvalue <-1-pf(fstatistic,df1=2,df2=97)

#Confidence Intervals
confint(m, level =.99) 

#Assessing fit/Regression Diagnostics
#Residual plots - Checking constant variance and linearity
plot(fitted(m),resid(m), axes=TRUE, frame.plot=TRUE, xlab = "fitted values", ylab="residuals")
abline(h=0)
plot(data$age,resid(m), axes=TRUE, frame.plot=TRUE, xlab = "age", ylab="residuals")
abline(h=0)
plot(data$height,resid(m), axes=TRUE, frame.plot=TRUE, xlab = "height", ylab="residuals")
abline(h=0)

#Checking Normality of residuals
hist(resid(m), breaks=2)
