
x1<-1:9
y1<-91:99
l1<- rep.int(1, 9)

df1 <- data.frame("x"=x1, "y"=y1, "label"=l1)
df1

x2<-91:99
y2<-1:9
l2<- rep.int(0, 9)

df2 <- data.frame("x"=x2, "y"=y2, "label"=l2)
df2

df <- rbind(df1, df2)
print(df)

m <- glm(label ~ x + y, data = df, family = "binomial")
summary(m)

predict(m, type=c("response"))



