## ----intro_read,message=FALSE,warning=FALSE,results='hide',echo=FALSE----

### Install packages if you don't have them yet
### Typical install:
# install.packages("ggplot2", dependencies = TRUE)
# install.packages("dplyr", dependencies = TRUE)

### Install personal copy (no admin rights)
# install.packages("ggplot2", lib="/path/to/myfolder")
# install.packages("dplyr", lib="/path/to/myfolder")


### Load packages
library(ggplot2)
library(stats)
library(base)
library(dplyr)


# setwd("SET THE WORKING DIRECTORY TO THE PATH TO THIS DIRECTORY")


### Load personal copy
# library(ggplot2, lib.loc="/path/to/myfolder")
# library(dplyr, lib.loc="/path/to/myfolder")


### Read in data
auto.data <- read.csv(
  "./Datasets/auto/AutoData.csv",
  header = TRUE
)

# tbl_df() isn't necessary here.
# It helps to display the data more clearly.
#
# In modern dplyr, use as_tibble() if you want
# the data to be explicitly converted to a tibble.
auto.data <- as_tibble(auto.data)


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

ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point()


## ----aes_ex1_plot,echo=FALSE,out.width=".45\\linewidth",fig.show='hold'----

# Map color to a factor/categorical variable
ggplot(auto.data, aes(
  x = curb.weight,
  y = price,
  color = factor(num.of.cylinders)
)) +
  geom_point()


# Map color to a continuous variable
ggplot(auto.data, aes(
  x = curb.weight,
  y = price,
  color = bore
)) +
  geom_point()


## ----aes_tryout,eval=FALSE-----------------------------------------------

# Map size to horsepower
ggplot(auto.data, aes(
  x = curb.weight,
  y = price,
  size = horsepower
)) +
  geom_point()


# Map shape to drive wheels
ggplot(auto.data, aes(
  x = curb.weight,
  y = price,
  shape = drive.wheels
)) +
  geom_point()


## ----facet_ex,eval=FALSE-------------------------------------------------

ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point() +
  facet_wrap(~aspiration)


## ----facet_plot,echo=FALSE,out.width=".7\\linewidth"---------------------

ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point() +
  facet_wrap(~aspiration)


## ----grid_plot,echo=FALSE,out.width=".7\\linewidth"----------------------

ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point() +
  facet_grid(drive.wheels ~ num.of.doors)


## ----try_out_facets,eval=FALSE-------------------------------------------

ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point() +
  facet_grid(. ~ drive.wheels)


ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point() +
  facet_grid(drive.wheels ~ .)


ggplot(auto.data, aes(
  x = curb.weight,
  y = price,
  color = factor(num.of.doors)
)) +
  geom_point() +
  facet_grid(drive.wheels ~ .)


## ----scatter_geom_ex,eval=FALSE------------------------------------------

# Explicitly specify the point geometry
ggplot(auto.data, aes(
  x = curb.weight,
  y = price
)) +
  geom_point()


## ----geom_hist_plot,out.width=".7\\linewidth",echo=FALSE,
## message=FALSE,warning=FALSE--------------------------------------------

# geom_histogram() operates with a single continuous variable.
# Let's look at price.

ggplot(auto.data, aes(x = price)) +
  geom_histogram()


# Equivalent histogram using the default binning
ggplot(auto.data, aes(x = price)) +
  geom_histogram()


## ----echo=FALSE,out.width=".6\\linewidth",
## message=FALSE,warning=FALSE--------------------------------------------

# Specify the histogram bin width
ggplot(auto.data, aes(x = price)) +
  geom_histogram(binwidth = 20000)


## ----xlim_plot,echo=FALSE,out.width=".7\\linewidth",
## message=FALSE,warning=FALSE--------------------------------------------

# Note our price distribution is a bit skewed.
# Perhaps we are not interested in higher-priced (>= 20,000) cars.
# We can limit the plot to cars with lower prices.

ggplot(auto.data, aes(x = price)) +
  geom_histogram(binwidth = 450) +
  coord_cartesian(xlim = c(4000, 20000))


## ----hist_aes_plot,echo=FALSE,out.width=".45\\linewidth",
## message=FALSE,warning=FALSE,fig.show='hold'-----------------------------

# Map color to drive wheels
ggplot(auto.data, aes(
  x = price,
  color = drive.wheels
)) +
  geom_histogram()


# Map fill to drive wheels
ggplot(auto.data, aes(
  x = price,
  fill = drive.wheels
)) +
  geom_histogram()


## ----hist_facet_plot,echo=FALSE,out.width=".7\\linewidth",
## message=FALSE,warning=FALSE--------------------------------------------

ggplot(auto.data, aes(x = price)) +
  geom_histogram() +
  facet_wrap(~drive.wheels)


## ----hist_facet_scale_plot,echo=FALSE,out.width=".7\\linewidth",
## message=FALSE,warning=FALSE--------------------------------------------

# This helps us separate the categorical variables much more easily.
# Note that the counts vary quite a bit among the different classes,
# but the count axis is the same for all.
#
# We can change this by modifying the facet_wrap() call.

ggplot(auto.data, aes(x = price)) +
  geom_histogram() +
  facet_wrap(
    ~drive.wheels,
    scales = "free_y"
  )


## ----hist_facet_scale_plot3,echo=FALSE,out.width=".6\\linewidth",
## message=FALSE,warning=FALSE--------------------------------------------

ggplot(auto.data, aes(x = price)) +
  geom_histogram() +
  facet_wrap(
    ~drive.wheels,
    scales = "free_y",
    nrow = 3
  )


## ----hist_density,eval=FALSE---------------------------------------------

# Density plot
ggplot(auto.data, aes(x = price)) +
  geom_density()


# Histogram with density on top
#
# The modern ggplot2 syntax:
# after_stat(density)
#
# replaces the older:
# ..density..

ggplot(auto.data, aes(x = price)) +
  geom_histogram(
    aes(y = after_stat(density))
  ) +
  geom_density()


# 2D density plot
ggplot(auto.data, aes(
  x = height,
  y = price
)) +
  geom_density_2d()


# Scatter plot with 2D density contours
ggplot(auto.data, aes(
  x = height,
  y = price
)) +
  geom_point() +
  geom_density_2d()


## ----boxplot,eval=FALSE--------------------------------------------------

ggplot(auto.data, aes(
  x = drive.wheels,
  y = price
)) +
  geom_boxplot()