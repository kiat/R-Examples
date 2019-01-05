# There a lots of good data sets available in R. 
# You can get a list of them by using command data()
# data()

# You can read about each of them by using help command. 
?AirPassengers

# You can load them into the memory by using the command 
data("AirPassengers")

# first take a look at the histogram with no additional parameters. 
hist(AirPassengers)

?hist

# axes	logical. If TRUE (default), axes are draw if the plot is drawn.
# We set here axes to FALSE 
# We make a vector for the lables of x-axis. 
x <- seq(100, 700, by = 50)

results <- hist(AirPassengers, breaks = x, axes = FALSE, main="Histogram for Air Passengers 1949-1960", 
                xlab = "Monthly Airline Passenger Numbers",  
                border="blue", 
                col="green", 
                ylim=c(0,25), xlim = c(100, 700)  )

# You can read some of the properties of histogram.
print(results)

# Read the documentation about axis 
?axis

# Now, we make the x-asis labels
axis(1, las=1, at = x, labels=x)

# Now, we make a vector for the y-axis lables based on our own requirments. 
ylables<- c(0, 2, 4, 5, 10, 13, 15, 20, 25)

# And this is the y-axis labels.
# axis(2, las=1, at = ylables, labels=ylables,  cex.axis = 1.2, font = 2)

# Or you can use the counts of your histogram result values 
axis(2, las=1, at = results$counts, labels=results$counts,  cex.axis = 1.2, font = 2)

# Here, we make some horizontal lines on the histogram. Just for fun :) 
# In the case that you want to have some horizontal lines on the histogram. 
abline(h = 4, col = "red" )

# a Dashed Line 
# abline(h=13,  col = "blue", lwd=1, lty=3)

abline(h=13,  col = "blue", lwd=3, lty="dashed")

# Values for lty are the strings "blank", "solid", "dashed", "dotted", "dotdash", "longdash", and "twodash". 
# Alternatively, the numbers 0 to 6 can be used (0 for "blank", 1 for "solid", ...).




