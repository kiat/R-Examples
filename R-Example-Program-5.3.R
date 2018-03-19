# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

states <- read.csv("Datasets/states.csv")

attach(states)


data <-data.frame(poverty, metro_res, white, hs_grad, female_house)

# Data is about poverty in 50 states plus district of Colombia. 
# 
# The variables are percentage living in poverty in each state, 
# percentage of residents living in a metropolitan area, percentage white, 
# percentage of high school graduates, and percentage of female head of householders. 

## put correlations on the upper panels,
## with size proportional to the correlations.


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


pairs(data, upper.panel = panel.cor)

# See read the five ways to visualize pairwise comparisions
# https://www.r-bloggers.com/five-ways-to-visualize-your-pairwise-comparisons/

