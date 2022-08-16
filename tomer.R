library(ggplot2)
dataset = read.csv(file = "dataset.csv")

ratio <- dataset$Engagement.ratio
hist(dnorm(ratio))