# Before using this code, load the "data_brexit_referendum_adjusted.csv"
# file from Blackboard. Read through "brexit example.R" for full details
# on how this file was generated

data_file <- read.csv("data_brexit_referendum_adjusted.csv")

# Principal Component Analysis (PCA) wrks best with numerical data
# so I'm checking that all data is now numeric first

data_numeric_variables <- sapply(data_file, is.numeric)
data_numeric_variables

# In the earlier lecture I created a "Proportion" variable using
# the variables "NVotes" and "Leave". Both these variables are correlated
# with "Proportion" and will produce false relationships in PCA.
data_numeric_variables["NVotes"] <- FALSE
data_numeric_variables["Leave"] <- FALSE

# Now I'll remove all non-numeric data and the other 2 variables
data_file_adjusted <- data_file[, data_numeric_variables]

# Passing this numeric data (23 variables) into the prcomp() function
# and setting two arguments, center and scale, to be TRUE. 
# Then we can have a peek at the PCA object with summary().
pca <- prcomp(data_file_adjusted, center = TRUE, scale. = TRUE)
summary(pca)

# We obtain 23 principal components, which are called PC1-23. Each of these 
# explains a percentage of the total variation in the dataset. 
# That is to say: PC3 explains 44% of the total variance, which means that 
# nearly half of the information in the dataset (23 variables) can be 
# encapsulated by just that one Principal Component. 
# PC2 explains 22% of the variance. So, by knowing the position of 
# a sample in relation to just PC1 and PC2, you can get a very 
# accurate view on where it stands in relation to other samples, 
# as just PC1 and PC2 can explain 66% of the variance.

# We can look at the "cumulative proportion" line to see this
# value across all variables eg PC1-3 = 75% of data

# This plot shows the variamces in squared standard deviations
# from the summary() results.
# We can see how each subsequent principal component captures a lower
# amount of total variance.
plot(pca, type = "l", main = "Principal Components' Variances")


# Let's call str() to have a look at your PCA object.
# The center point ($center), 
# scaling ($scale), 
# standard deviation(sdev) of each principal component
# The relationship (correlation or anticorrelation, etc) between the 
# initial variables and the principal components ($rotation)
# The values of each sample in terms of the principal components ($x)

str(pca)

# Plot the PCA
# We will make a biplot, which includes both the position of each 
# sample in terms of PC1 and PC2 and also will show you how the 
# initial variables map onto this. We will use the ggbiplot package, 
# which offers a user-friendly and pretty function to plot biplots. 
# A biplot is a type of plot that will allow you to visualise how 
# the samples relate to one another in our PCA (which samples are 
# similar and which are different) and will simultaneously reveal how 
# each variable contributes to each principal component.
install.packages("devtools")
library(devtools)
# Choose "1" to install all packages
# See https://www.rdocumentation.org/packages/ggbiplot/versions/0.55

# May need to manaully delete folders from your local
# library first
.libPaths() # shows library paths

# You must have R version 3.6.3 for this to work
install_github("vqv/ggbiplot")
library(ggbiplot)
biplot <- ggbiplot(pca, groups = data_file$Vote,
                   obs.scale = 1,
                   var.scale = 1,
                   varname.size = 5
)
biplot <- biplot + scale_color_discrete(name = "")

biplot <- biplot + theme(legend.position = "top", 
                         legend.direction = "horizontal")


biplot <- biplot + xlim(-10, 10) + ylim(-10, 10)
print(biplot)
