library(ggplot2)
dataset = read.csv(file = "206836009 – 318862398.csv")

##### Exercise 1 #####
# pages with Indian demographic
india_only <- dataset[dataset$Main.Demographic == 'India', ]
# cinema pages that have Indian demographic
india_only_cinema_category <- india_only[india_only$category_1 == "Cinema & Actors/actresses",]
# number of successes in sample, number of cinema pages that are followed by Indians
p_indians <- nrow(india_only_cinema_category)
# total number of pages from top 1000 that are followed by Indians
total_indians <- nrow(india_only)

# calculate standard error
q_indians <- total_indians - p_indians
se <- sqrt((p_indians * q_indians)/total_indians)

# validate assumptions
if (total_indians * p_indians >= 5 & total_indians * q_indians >= 5){
  print("normality assumption valid")
} else {
  print("normality assumption invlaid")
}

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



#### Excercise 4 for Excercise 1 ####
# Load ggplot2
library(ggplot2)
library(hash)

india_genres <- hash()
for (category in unique(india_only$category_1)){
  india_genres[category] <- nrow(india_only[india_only$category_1 == category,])
}
print(india_genres)

# Create Data
data <- data.frame(
  group=keys(india_genres),
  value=values(india_genres)
)

# Basic piechart
ggplot(data, aes(x="", y=value, fill=group)) +
  ggtitle("Indian Demographic Sample") +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  
  theme_void() # remove background, grid, numeric labels


### For general population
total_generes <- hash()
for (category in unique(dataset$category_1)){
  total_generes[category] <- nrow(dataset[dataset$category_1 == category,])
}
print(total_generes)

# Create Data
data <- data.frame(
  group=keys(total_generes),
  value=values(total_generes)
)

# Basic piechart
ggplot(data, aes(x="", y=value, fill=group)) +
  ggtitle("General Demographic Sample") +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  
  theme_void() # remove background, grid, numeric labels
