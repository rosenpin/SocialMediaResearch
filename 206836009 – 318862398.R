library(ggplot2)
library(car)
library(ggpubr)
dataset = read.csv(file = "206836009 – 318862398.csv")

    ##Question Two
countries <- c("Brazil", "India", "Indonesia", "United States")
#creating a factor defining groups vector
groupings <- dataset$Audience.country.mostly.[dataset$Audience.country.mostly. %in% countries]
#creating the ordered values vector
values <- dataset$Authentic.engagement[dataset$Audience.country.mostly. %in% countries]
#combining into dataframe
data.for.test <- data.frame(values,groupings)

  ##Testing assumptions
##Testing for normality
#Shapiro-wilk test
shapiro.test(values)
#qqplot test
ggqqplot(values)

##Testing for independency of variables (chi squared test)
chisq.test(data.for.test$values, data.for.test$groupings)

##Testing for equal variance
var1 <- dataset$Authentic.engagement[dataset$Audience.country.mostly. == countries[1]]
var2 <- dataset$Authentic.engagement[dataset$Audience.country.mostly. == countries[2]]
var3 <- dataset$Authentic.engagement[dataset$Audience.country.mostly. == countries[3]]
var4 <- dataset$Authentic.engagement[dataset$Audience.country.mostly. == countries[4]]
dat1 <- data.frame(var1, rep('a', length(var1)))
dat2 <- data.frame(var2, rep('b', length(var2)))
dat3 <- data.frame(var3, rep('c', length(var3)))
dat4 <- data.frame(var4, rep('d', length(var4)))


testforVar <- function(vr1){
  a <- data.frame(vr1, as.factor(rep("a", length(vr1))))
  return(a)
}


#preforming Levene test (F test for multiple groups)
leveneTest(values, groupings, data = data.for.test, center = mean)
