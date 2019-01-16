
# Create a vector for hights
height <- c(176, 154, 138, 196, 132, 176, 181, 169, 150, 175)

# Create a vector for bodymass 
bodymass <- c(82, 49, 53, 112, 47, 69, 77, 71, 62, 78)

# Create a scotterplot 
plot(bodymass, height)

# A better scotterplot
plot(bodymass, height, pch = 16, cex = 1.3, col = "blue", main = "HEIGHT PLOTTED AGAINST BODY MASS", xlab = "BODY MASS (kg)", ylab = "HEIGHT (cm)")


# Correlation 
cor(bodymass, height)

cor(height, bodymass)

# A simple linear regression

lm(height ~ bodymass)

# A line on the past plot
abline(98.0054, 0.9528)


# A better approach is to use variables and pass data to other functions 
m <- lm(height ~ bodymass)

# better would be to do this - No hard coding of data values.
abline(m)


