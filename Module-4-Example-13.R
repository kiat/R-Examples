
# Create a Materix in R
a <- matrix(c(2, -2, 1, 4), nrow = 2, ncol = 2)

c <- matrix(c(2, 3, 1, 1, 6, 5), nrow = 2, ncol = 3)

print(a)
print(c)

f <- a %*% c 

# Print transpose 
print(t(a))

# Calcualte invese matrix of it
b <- solve(a)

print(b)


# Adjucate of a 
a.conj <- Conj(a)

# Calculate determinat 
a.det <- det(a)

print(a.det)


# Calculate the invese matrix 
c <- 1/a.det * a.conj

print(c) 

# as we can see b and c are equal 


