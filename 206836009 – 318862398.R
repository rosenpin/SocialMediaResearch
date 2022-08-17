library(ggplot2)
library(car)
library(ggpubr)
dataset = read.csv(file = "206836009 – 318862398.csv")

      ####Question Two
countries <- c("Brazil", "India", "Indonesia", "United States")
#creating a factor defining groups vector
groupings <- dataset$Audience.country.mostly.[dataset$Audience.country.mostly. %in% countries]
#creating the ordered values vector
values <- dataset$Authentic.engagement[dataset$Audience.country.mostly. %in% countries]
#combining into dataframe
data.for.test <- data.frame(values,groupings)

  ##Testing assumptions
##Testing for normality
#QQplot visual test
ggqqplot(values)
#Shapiro-wilk test
shapiro.test(values)

##Testing for independency of variables (chi squared test)
chisq.test(data.for.test$values, data.for.test$groupings)

##Testing for equal variance
#Boxplot for visual confirmation
boxplot(values ~ groupings, xlab='Countries', ylab='Engagment', data=data.for.test)

#Bartlett test of homogeneity of variances
bartlett.test(values ~ groupings, data=data.for.test)

  ##Preforming Levene test (F test for multiple groups)
leveneTest(values, groupings, data = data.for.test, center = mean)
