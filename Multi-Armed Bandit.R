# Multi-Armed Bandit.R
# Example of multi-armed bandit on price optimisation
# http://appsilondatascience.com/blog/rstats/2017/11/29/monte-carlo-tree-search.html
# Craeted by Aja Manu on 30/11/17

# clear working environment
rm(list = ls())

# load library
library(bandit) # for multi-armed bandit problems

# Set seed
set.seed(123)

# number of visitors and pruschses at prices for the first day
visits_day1 <- c(4000, 4060, 4011, 4007)
purchase_day1 <- c(368, 355, 373, 230)
prices <- c(99, 100, 115, 120)

# simulate the posterior distribution for each arm at various prices
post_distribution = sim_post(purchase_day1, visits_day1, ndraws = 10000)

# compute probability that each arm is the winner, given simulated posterior results
probability_winning <- prob_winner(post_distribution)
names(probability_winning) <- prices

probability_winning

# continue the experiment to additional days, based on same price and cumulative
# purchases and visits
visits_day2 <- c(8030, 8060, 8027, 8037)
purchase_day2 <- c(769, 735, 786, 420)

post_distribution = sim_post(purchase_day2, visits_day2, ndraws = 1000000)
probability_winning <- prob_winner(post_distribution)
names(probability_winning) <- prices

probability_winning

# we can do prop tests to see signifiance
significance_analysis(purchase_day2, visits_day2)

# Continue fro another set of trials but drop $120 price because it not performing well
visits_day3 <- c(15684, 15690, 15672, 8037)
purchase_day3 <- c(1433, 1440, 1495, 420)

post_distribution <- sim_post(purchase_day3, visits_day3, ndraws = 1000000)
probability_winning <- prob_winner(post_distribution)
names(probability_winning) <- prices
probability_winning

# calculate distribution of improvement amounts that another arm might have over the current best arm
value_remaining <- value_remaining(purchase_day3, visits_day3)
potential_value <- quantile(value_remaining, 0.95)
potential_value

# We are still unsure about the conversion probability for the best price 115$, 
# but whatever it is, one of the other prices might beat it by as much as 2.67% 
#(the 95% quantile of value remaining).
