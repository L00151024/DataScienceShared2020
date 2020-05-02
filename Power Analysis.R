# Example using mobile phone usage on 
# driver reaction time

# We're examining 2 samples (with and without phone)
# and comparing mean reaction time of both groups
# so we'll use the paired t test


install.packages("pwr")
library(pwr)
power_information <- pwr.t.test(d = 0.8, 
           sig.level = 0.05, 
           power = 0.90, 
           type = "two.sample", 
           alternative = "two.sided")

# results suggest that we need 34 participants in each group 
# (for a total of 68 participants) in order to detect an effect 
# size of 0.8 with 90% certainty and no more than
# a 5% chance of erroneously concluding that a difference exists when 
# in fact, it doesn’t
power_information

# We can plot this information
plot(power_information)

# What if we wanted to have a lower p value?
power_information <- pwr.t.test(d = 0.8, 
                                sig.level = 0.01, 
                                power = 0.90, 
                                type = "two.sample", 
                                alternative = "two.sided")
power_information
# 48 participants needed
plot(power_information)

# coin flip example ----------------------------------------
# Categorical data - heads or tails
# 1 set of data - 1 sample
# We'll compare the data with each group - examining proportions
# Therefore we're going to use a 1 sample proportion test

# We think that the coin is loaded on heads 75% of the time
# instead of 50/50
# Cohen describes effect size as “the degree to which the null hypothesis is false.” 
# In our coin flipping example, this is the difference between 75% and 50%. 
# We could say the effect was 25% but we have to transform the absolute difference 
# in proportions to another quantity using the ES.h function. 
# This is a crucial part of using the pwr package correctly 
# You must provide an effect size on the expected scale. 
# Doing otherwise will produce wrong sample size and power calculations.

h = ES.h(p1 = 0.75, p2 = 0.50)

# We specified alternative = "greater" since we assumed the coin was 
# loaded for more heads (not less). This is a stronger assumption than 
# assuming that the coin is simply unfair in one way or another. 
# In practice, sample size and power calculations will usually make 
# the more conservative “two-sided” assumption (default)
power_information <- pwr.p.test(h = h,
                            sig.level = 0.05,
                            power = 0.80,
                            alternative = "greater")
power_information
# h = 23

# Lets leave the alternative out so that it defaults
# to the conservative 2-sided function

power_information <- pwr.p.test(h = h,
                                sig.level = 0.05,
                                power = 0.80)
# n increases to 29

power_information

# We'll set the p value to 0.01 to lower probability of a type I error

power_information <- pwr.p.test(h = h, 
                                sig.level = 0.01, 
                                n = 40)

# What if we assume the “loaded” effect is smaller? Maybe the coin 
# lands heads 65% of the time. How many flips do we need to perform 
# to detect this smaller effect at the 0.05 level with 80% power and 
# the more conservative two-sided alternative?

h = ES.h(p1 = 0.65, p2 = 0.50)

power_information <- pwr.p.test(h = h,
                                sig.level = 0.05, 
                                power = 0.80)
power_information
# about 85 coin flips

# We can use the cohen.ES to calculate conventional effect size
# These are pre-determined effect sizes for “small”, “medium”, and “large” 
# effects. The cohen.ES function returns a conventional effect size for 
# a given test and size. For example, the medium effect size for the 
# correlation test is 0.3 (see chart on slide 30 of power analysis slides)
cohen.ES(test = "r", size = "medium")


# LYIT and alcohol example
pwr.2p.test(h = ES.h(p1 = 0.55, p2 = 0.50), 
            sig.level = 0.05, 
            power = .80)

# We'll need  to sample 1,565 males and 1,565 females to detect 
# the 5% difference with 80% power.
