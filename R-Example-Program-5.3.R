# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

states <- read.csv("Datasets/states.csv")

attach(states)


data <-data.frame(poverty, metro_res, white, hs_grad, female_house)


## put correlations on the upper panels,
## with size proportional to the correlations.
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- cor(x, y)
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  # txt <- paste0(prefix, txt)
  
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

pairs(data, upper.panel = panel.cor)


