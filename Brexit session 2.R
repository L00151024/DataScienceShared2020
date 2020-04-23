# I'm going to split the data into the following:
# 2 groups of age - below and above 45
# 2 groups of ethnicity - white and non-white
# 2 groups of education (high and low level of education)

# Below 45
file_data$Age_18to44 <- (file_data$Age_18to19 + 
                           file_data$Age_20to24 + 
                           file_data$Age_25to29 + 
                           file_data$Age_30to44)

# Above 45
file_data$Age_45_above <- (file_data$Age_45to59 + 
                             file_data$Age_60to64 + 
                             file_data$Age_65to74 + 
                             file_data$Age_75to84 + 
                             file_data$Age_85to89 + 
                             file_data$Age_90plus)

# Data for white voters already exists under "White" variable
# Creating non-white data variable
file_data$non_white <- (file_data$Black + 
                          file_data$Asian + 
                          file_data$Indian + 
                          file_data$Pakistani)

# Creating 2 education levels
file_data$High_education_level <- file_data$L4Quals_plus
file_data$Low_education_level <- file_data$NoQuals

# Now I want to remove all other data
# First I'll extract out all column names
col_names <- colnames(file_data)
col_names

# Now I'm going to build a vector that will contain TRUE for each element
# within it. The logical() command creates a logical vecotr of a specified length
# Each element of the vector is equal to FALSE. I can reverse the logic to create a vector equal to TRUE 
# for each variable in the dataframe.
?logical
# variabes_list is now a vector of the length of col_names with each element equal to TRUR
variables_list <- !logical(length(col_names))
variables_list

# Now I'll use the command "setNames" to match the column names to each element in the
# variables_list vector
?setNames
variables_list <- setNames(variables_list, col_names)
variables_list

# We want to remove all columns with the word "age" in them except for "Age_18to44" and "Age_45_above"
# We can use sapply() to run the grepl() function with a search vaue of "Age" that replaces the input value "x"

age_variables <- sapply(col_names, function(x) grepl("Age", x))
age_variables

# Next I'll set all of the elements in "variables_list" to FALSE where the word "Age" is contained in it.
# I'm using "age_variables" to do this as an indexer of when to assign "FALSE" to each element in 
# variables_list
variables_list[age_variables] <- FALSE
variables_list

# This will cause an issue right now as I've also found the word "age" in "Age_18to44" and "Age_45_above"
# variables. I'm going to set these manaully to TRUE
variables_list["Age_18to44"] <-TRUE
variables_list["Age_45_above"] <- TRUE
# And I want to keep "AdultMeanAge" variable
variables_list["AdultMeanAge"] <- TRUE

# Finally I want to remove the other variables that I combined earlier
# into 6 groups of interest
# Remove ethnicity variables
variables_list["Black"] <- FALSE
variables_list["Asian"] <- FALSE
variables_list["Indian"] <- FALSE
variables_list["Pakistani"] <- FALSE

# Remove education-related variables
variables_list["NoQuals"] <- FALSE
variables_list["L4Quals_plus"] <- FALSE

# Finally I have a vector of the variables I'd like to keep
# so I'm going to create a new data frame and then save it 
# as a csv file.
adjusted_data <- file_data[, variables_list]
nrow(adjusted_data)

# Write adjusted file as csv file for future work
write.csv(adjusted_data, file = "data_brexit_referendum_adjusted.csv")
