## ----intro_read,message=FALSE,warning=FALSE,results='hide',echo=FALSE----
### Install packages if you don't have them yet
### Typical install:
# install.packages('ggplot2',  dependencies = T)
# install.packages('dplyr', dependencies = T)

### Install personal copy (no admin rights)
# install.packages('gpplot2',lib="/path/to/myfolder")
# install.packages('dplyr',lib="/path/to/myfolder")

### Load packages
# Load packages
library(ggplot2)

library(stats)
library(base)
library(dplyr)


# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")



# Load personal copy
# library(ggplot2,lib.loc="/path/to/myfolder")
# library(dplyr,lib.loc="/path/to/myfolder")
# Read In data
auto.data <- read.csv("./Datasets/auto/AutoData.csv",
                      header = TRUE)
# tbl_df() isn't necessary here
# It helps to display the data more clearly
auto.data <- tbl_df(auto.data)


## ----intro_dataExamine,eval=FALSE----------------------------------------
# Find the dimensions
dim(auto.data)
# Look at the structure
str(auto.data)
# Examine the top
head(auto.data)
# Find out about a function
?str


## ----scatter_explot,echo=FALSE,out.width=".7\\linewidth"-----------------
qplot(curb.weight,price,data=auto.data)


## ----aes_ex1_plot,echo=FALSE,out.width=".45\\linewidth",fig.show='hold'----
# map color to factor/categorical variable
qplot(curb.weight,
      price,
      data=auto.data,
      color=num.of.cylinders)

# map color to continuous variable
qplot(curb.weight,
      price,
      data=auto.data,
      color=bore)

## ----aes_tryout,eval=FALSE-----------------------------------------------
qplot(curb.weight,
      price,
      data=auto.data,
      size=horsepower)

qplot(curb.weight,
      price,
      data=auto.data,
      shape=drive.wheels)

## ----facet_ex,eval=FALSE-------------------------------------------------
qplot(curb.weight,
      price,
      data=auto.data) + facet_wrap(~aspiration)

## ----facet_plot,echo=FALSE,out.width=".7\\linewidth"---------------------
qplot(curb.weight,
      price,
      data=auto.data) + facet_wrap(~aspiration)


## ----grid_plot,echo=FALSE,out.width=".7\\linewidth"----------------------
qplot(curb.weight,
      price,
      data=auto.data) +
  facet_grid(drive.wheels~num.of.doors)

## ----try_out_facets,eval=FALSE-------------------------------------------
qplot(curb.weight,
      price,
      data=auto.data) + facet_grid(.~drive.wheels)

qplot(curb.weight,
      price,
      data=auto.data) + facet_grid(drive.wheels~.)

qplot(curb.weight,
      price,
      data=auto.data,
      color=num.of.doors) + facet_grid(drive.wheels~.)

## ----scatter_geom_ex,eval=FALSE------------------------------------------
qplot(curb.weight,price,data=auto.data,geom='point')


## ----geom_hist_plot,out.width=".7\\linewidth",echo=FALSE,message=FALSE,warning=FALSE----
# geom_histogram operates with a single continuous variable.
# Let's look at price

# geom_histogram operates with a single continuous variable.
# Let's look at price
qplot(price,
      data=auto.data,
      geom='histogram')

# or via qplot's defaults
qplot(price,data=auto.data)



## ----echo=FALSE,out.width=".6\\linewidth",message=FALSE,warning=FALSE----
qplot(price,
      data=auto.data,
      geom='histogram',
      binwidth=20000)


## ----xlim_plot,echo=FALSE,out.width=".7\\linewidth",message=FALSE,warning=FALSE,warning=FALSE----

# Note our price distribution is a bit skewed 
# Perhaps we are not interested in higher priced (≥ 20, 000 say) cars 
# We can limit our plot cars with lower price by setting limits 

qplot(price,
      data=auto.data,
      geom='histogram',
      binwidth=450) +
  xlim(4000,20000)


## ----hist_aes_plot,echo=FALSE,out.width=".45\\linewidth",message=FALSE,warning=FALSE,fig.show='hold'----
qplot(price,
      data=auto.data,
      color=drive.wheels)

qplot(price,
      data=auto.data,
      fill=drive.wheels)


## ----hist_facet_plot,echo=FALSE,out.width=".7\\linewidth",message=FALSE,warning=FALSE----
qplot(price,
      data=auto.data) +
  facet_wrap(~drive.wheels)


## ----hist_facet_scale_plot,echo=FALSE,out.width=".7\\linewidth",message=FALSE,warning=FALSE----

# This helps us separate out the categorical variables much easier.
# Note the counts vary quite a bit among the different classes, but yet the
# count axis is the same for all. We can change this by modifying the
# facet_wrap call:

qplot(price,
      data=auto.data) +
  facet_wrap(~drive.wheels,
             scales = 'free_y')

## ----hist_facet_scale_plot3,echo=FALSE,out.width=".6\\linewidth",message=FALSE,warning=FALSE----
qplot(price,
      data=auto.data) +
  facet_wrap(~drive.wheels,
             scales = 'free_y',
             nrow=3)

## ----hist_density,eval=FALSE---------------------------------------------
qplot(price,data=auto.data,
      geom='density')
qplot(price,
      ..density.., # don't use counts
      data=auto.data,
      geom='histogram') +
  geom_density()
qplot(height,price,
      data=auto.data,
      geom='density2d')
qplot(height,price,
      data=auto.data)+
  geom_density2d()

## ----boxplot,eval=FALSE--------------------------------------------------
qplot(drive.wheels,
      price,
      data=auto.data,
      geom='boxplot')
