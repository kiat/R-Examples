# install.packages('dplyr')
library(stats)
library(base)
library(dplyr)

# setwd("SET THE Working Director to THE PATH TO THIS DIRECTORY")

DelayDataLocation <- "./Datasets/airline/HoustonAirline.csv"
delay.dat.houston <- read.csv(DelayDataLocation, 
                              header=TRUE,
                              stringsAsFactors = FALSE)

# tbl_df allows for nice printing
delay.dat.houston <- as_tibble(delay.dat.houston)


###
delay.dat.houston

# Airport information
AirDataLocation <- "./Datasets/airline/airports.csv"
airport.dat <- read.table(AirDataLocation,
                          header=TRUE,
                          sep=",",
                          stringsAsFactors = FALSE)

airport.dat <- as_tibble(airport.dat)


###
airport.dat

# Find all flight which occurred in January
filter(delay.dat.houston, Month==1)

# we could of course save this too
# delay.dat.houston.jan <- filter(delay.dat.houston, Month==1)

## ---- filterEx2 -----------------------------------------------
# Using airport data, find a list of iata abbreviations for Houston Texas airports
filter(airport.dat, state=='TX', city=='Houston')

## ---- filterEx3 ------------------------------------------------
# Find the subset of flight departing from Hobby Airport "HOU" for which the Actual
# Elapsed Time was greater than the CRS Elapsed Time.
filter(delay.dat.houston,
       Origin == 'HOU', # iata code for Hobby
       ActualElapsedTime > CRSElapsedTime)

## ---- filterEx4 -----------------------------------------------
# Find the subset of flights departing on the weekend.
weekend.data <- filter(delay.dat.houston, DayOfWeek == 6 | DayOfWeek == 7)

# another alternative
filter(delay.dat.houston,  DayOfWeek %in% c(6,7))



## ---- arrangeEx1 ----------------------------------------------
# arrange, like filter, operates on data.frame rows
# arrange is used for sorting data.frame rows w.r.t. a given column(s)

# sort by DayofMonth, smallest to largest


arrange(delay.dat.houston, DayofMonth)

## ---- arrangeEx2 ----------------------------------------------
# sort by DayofMonth largest to smallest
arrange(delay.dat.houston, desc(DayofMonth))

## ---- arrangeEx3 ----------------------------------------------
# sort by Month, use DayofMonth to break ties
arrange(delay.dat.houston, desc(Month), desc(DayofMonth))

## ---- selectEx1 ------------------------------------------------
select(delay.dat.houston, Year, Month, DayofMonth)
select(delay.dat.houston, Year:DayofMonth)
select(delay.dat.houston, -(Year:DayofMonth))

## ---- helperlist----------------------------------------------
## # will give list of helper functions
?select

## ---- helperex ----------------------------------------------
# search for text string/regular expression
select(delay.dat.houston, contains('Dep'))

## ---- helperex2 -----------------------------------------------
select(delay.dat.houston,
       one_of('UniqueCarrier',
              'FlightNum'))
select(delay.dat.houston,
       ends_with('Time'))

## ---- distinctEx1 ---------------------------------------------
# returns a data.frame with 12 observations
distinct(delay.dat.houston, Month)

distinct(delay.dat.houston, Month,.keep_all=TRUE)

## ---- distinctEx2 ---------------------------------------------
# returns a data.frame with 12*7=84 observations
distinct(delay.dat.houston, Month,DayOfWeek)

select(
  distinct(
    arrange(
      filter(delay.dat.houston,DayOfWeek==6),
      desc(ActualElapsedTime)),
    UniqueCarrier,.keep_all = TRUE),
  UniqueCarrier, ActualElapsedTime)

delay.dat.houston %>%
  filter(DayOfWeek == 6) %>%
  arrange(desc(ActualElapsedTime)) %>%
  distinct(UniqueCarrier,.keep_all=TRUE) %>%
  select(UniqueCarrier,ActualElapsedTime)

## ---- ChainSols1 -----------------------------------------------
# Find a list of the distinct Origin airports
delay.dat.houston %>%
  distinct(Origin) 

# Find a list of distinct (Origin, Dest) pairs
alldest<- delay.dat.houston %>% distinct(Origin, Dest) 

# Origin airport with largest January departure delay
delay.dat.houston %>%
  filter(Month==1) %>%
  arrange(desc(DepDelay)) %>%
  select(Month,Origin, DepDelay) %>%
  distinct(Origin,.keep_all = TRUE)

## ---- ChainSols2 -----------------------------------------------
# largest departure delay for each carrier for each month
delay.dat.houston %>%
  arrange(Month,desc(DepDelay)) %>%
  select(Month,UniqueCarrier,DepDelay) %>%
  distinct(Month,UniqueCarrier,.keep_all=TRUE)

## ---- mutateexs ------------------------------------------------
# create new variable ElapsedDifference:
delay.dat.houston %>% mutate(
  ElapsedDiffernce = ActualElapsedTime - CRSElapsedTime)

# keep only the newly created variable:
delay.dat.houston %>% transmute(
  ElapsedDiffernce = ActualElapsedTime - CRSElapsedTime)

## ---- summariseEx1 --------------------------------------------------------
# Basic example with no grouping
delay.dat.houston %>%
  summarise(
    MeanDistance = mean(Distance,na.rm=TRUE)
    )
# Results identical to transmutate. boring.

## ---- summariseEx2 . --------------------------------------------
# With grouping
# n() is dplyr function counts # obs in each group
delay.dat.houston %>%
  group_by(UniqueCarrier) %>%
  summarise(
    MeanDistance=mean(Distance,na.rm=TRUE),
    NFlights = n())

## ---- summex3 -------------------------------------------------------------
delay.dat.houston %>%
  group_by(Month, UniqueCarrier) %>%
  summarise(MaxDepDelay = max(DepDelay,na.rm=TRUE)) %>%
  head(5)

## ---- plotdley -------------------------------------------------
library(ggplot2)
delay.dat.houston %>%
  group_by(Month,UniqueCarrier) %>%
  summarise(
    Dep = mean(DepDelay,na.rm=TRUE)
  ) -> tmp
qplot(Month,Dep,data=tmp) +
  geom_line() +
  facet_wrap(~UniqueCarrier)


## ---- plotsize2 ------------------------------------------------
delay.dat.houston %>%
  group_by(Month,UniqueCarrier) %>%
  summarise(
    NFlights = n()
  ) -> tmp

qplot(Month,NFlights,data=tmp) +
  geom_line() +
  facet_wrap(~UniqueCarrier,scale='free_y')



## ---- scatter_explot -------------------------------
delay.dat.houston %>%
  group_by(UniqueCarrier) %>%
  summarise(
    NFlights = n(),
    NCancelled = sum(Cancelled)) %>%
  mutate(
    PercentCancelled = (NCancelled/NFlights)*100) %>%
  select(UniqueCarrier,
    PercentCancelled)


## ---- nuthers ------------------------
delay.dat.houston %>%
  group_by(UniqueCarrier) %>%
  summarise(
    Dep = mean(DepDelay,na.rm=TRUE),
    Arr = mean(ArrDelay,na.rm=TRUE),
    NFlights = n()
  ) %>%
  select(Dep,Arr,NFlights) -> tmp
qplot(Dep,
      Arr,
      data=tmp,
      size=log(NFlights))+
  geom_abline(intercept=0,slope=1,color='red')

## ---- merge_toy_read .  ----------------------------
people.info <- read.table('./Datasets/mergedata/PeopleInfo.csv',
                          sep=',',
                          header=TRUE)
occup.info <- read.table('./Datasets/mergedata/OccupationInfo.csv',
                          sep=',',
                          header=TRUE)



## ---- look_at_toy ---------------------------------------------------------
people.info
occup.info

## ---- join_try1 ------------------------------------------------
# What do you think the following snippets will do
# Try to guess before running, then run to confirm
left_join(people.info, occup.info)
right_join(people.info, occup.info)
inner_join(people.info, occup.info)

# Do the following return the same data set?
left_join(people.info, occup.info)
right_join(occup.info, people.info)

# Do you think this will work?
people.info %>% left_join(occup.info)

## ---- weird_joins ----------------------------------------------
semi_join(people.info, occup.info)
anti_join(people.info, occup.info)
full_join(people.info, occup.info)

## ---- mergit ---------------------------------------------------
delay.dat.houston %>%
  left_join(airport.dat,
            by=c("Dest" = 'iata'))


## ---- plotmregereal  ------------------
delay.dat.houston %>%
  left_join(airport.dat,
            by=c("Dest" = 'iata')) %>%
  group_by(state) %>%
  summarise(
    NFlights = n()
  ) %>%
  select(state,NFlights)

## ----   mregeplots25   ---------------------------------------------
# one option
delay.dat.houston %>%
  left_join(airport.dat,
            by=c("Dest" = 'iata')) %>%
  group_by(UniqueCarrier, state) %>%
  summarise(
    AvgDelay = mean(DepDelay,na.rm=TRUE)
  ) %>%
  select(state,UniqueCarrier, AvgDelay) %>%
  arrange(UniqueCarrier, desc(AvgDelay)) %>%
  distinct(UniqueCarrier,.keep_all = TRUE)


