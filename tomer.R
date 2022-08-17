library(ggplot2)
dataset = read.csv(file = "newdataset.csv")

##### Exercise 1 #####
india_only <- dataset[dataset$Audience.country.mostly. == 'India', ]
india_only_cinema_category <- india_only[india_only$category_1 == "Cinema & Actors/actresses",]
p_indians <- nrow(india_only_cinema_category)
total_indians <- nrow(india_only)

general_population_cinema_category <- dataset[dataset$category_1 == "Cinema & Actors/actresses",]
p_population <- nrow(general_population_cinema_category)
total_general_population <- nrow(dataset)

prop.test(c(p_indians, p_population),
          c(total_indians, total_general_population),
          alternative = c("two.sided"),
          conf.level = 0.95)