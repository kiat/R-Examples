
data  <- read.csv("datasets/project-46.csv", header=T)
head(data)
tail(data)
attach(data)
data = data.frame(�..country,year,sex,gdp_per_capita....,suicides.100k.pop)
data = aggregate(data, by = list(�..country,year), FUN=mean)
attach(data)
data = data.frame(Group.1,year,gdp_per_capita....,suicides.100k.pop)
EU = c("Belgium","France","Germany")
dataEU = data[Group.1 %in% EU,]
colnames(dataEU)=c("Country","Year","GDP_per_capita","Suicide_rate")
dataEU$GDP_per_capita = dataEU$GDP_per_capita/1000
m=lm(dataEU$Suicide_rate~dataEU$GDP_per_capita)
summary(m)
plot(dataEU$GDP_per_capita,dataEU$Suicide_rate, xlab="GDP per capita, $1000", ylab = "Suicide rate")
abline(m)
