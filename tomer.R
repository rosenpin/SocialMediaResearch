library(ggplot2)
dataset = read.csv(file = "dataset.csv")

##### Exercise 1 #####
# pages followed mostly by Indians
india_only <- dataset[dataset$Audience.country.mostly. == 'India', ]
# cinema pages that are mostly followed by Indians
india_only_cinema_category <- india_only[india_only$category_1 == "Cinema & Actors/actresses",]
# number of successes in sample, number of cinema pages that are followed mostly by Indians
p_indians <- nrow(india_only_cinema_category)
# total number of pages from top 1000 that are mostly followed by Indians
total_indians <- nrow(india_only)

# number of cinema pages of top 1000
general_population_cinema_category <- dataset[dataset$category_1 == "Cinema & Actors/actresses",]
# number of successes in population, number of cinema pages followed by general population (including Indians)
p_population <- nrow(general_population_cinema_category)
# number of pages in total (1000*, actually a bit less after cleanup)
total_general_population <- nrow(dataset)

# confidence interval calculation for proportion with right side tail
prop.test(c(p_indians, p_population),
          c(total_indians, total_general_population),
          alternative = c("greater"),
          conf.level = 0.95)