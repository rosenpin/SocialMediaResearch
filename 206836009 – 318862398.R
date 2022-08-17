library(ggplot2)
library(car)
library(ggpubr)
dataset = read.csv(file = "206836009 – 318862398.csv")

countries <- c("Brazil", "India", "Indonesia", "United States")
#creating a factor defining groups vector
groupings <- dataset$Audience.country.mostly.[dataset$Audience.country.mostly. %in% countries]
#creating the ordered values vector
values <- dataset$Authentic.engagement[dataset$Audience.country.mostly. %in% countries]
#combining into dataframe
data.for.test <- data.frame(values,groupings)

##Testing for normality
#Shapiro-wilk test
shapiro.test(values)

#qqplot test
ggqqplot(values)

#preforming Levene test (F test for multiple groups)
leveneTest(y = values, group = groupings, data = data.for.test, center = mean)

