library(ggplot2)
library(car)
library(ggpubr)
dataset = read.csv(file = "206836009 – 318862398.csv")

####      Question Two

countries <- c("Brazil", "India", "Indonesia", "United States")
#creating a factor defining groups vector
groupings <- dataset$Main.Demographic[dataset$Main.Demographic %in% countries]
#creating the ordered values vector
values <- dataset$Engagement.avg[dataset$Main.Demographic %in% countries]
#combining into dataframe
data.for.test <- data.frame(values,groupings)

###  Testing assumptions
##  Normality
#QQplot visual test
ggqqplot(values)
#Shapiro-wilk test
shapiro.test(values)

##  Independency of variables (chi squared test)
chisq.test(data.for.test$values, data.for.test$groupings)

##  Equal variance
#Boxplot for visual confirmation
boxplot(values ~ groupings, xlab='Countries', ylab='Engagment', data=data.for.test)

#Bartlett test of homogeneity of variances
bartlett.test(values ~ groupings, data=data.for.test)

###  Preforming Levene test (F test for multiple groups)
leveneTest(values, as.factor(groupings), data = data.for.test, center = mean)


####      Question Three
#finding mean followers count
music_mean_followers <- mean(dataset$Followers)
#Getting engagement ratios for bigger and smaller accounts
bigger_music_ratio <- dataset$Engagement.ratio[dataset$category_1 == "Music" & dataset$Followers > music_mean_followers]
smaller_music_ratio <- dataset$Engagement.ratio[dataset$category_1 == "Music" & dataset$Followers <= music_mean_followers]
#Calculating standard deviation for both groups
sd_bigger <- sd(bigger_music_ratio)
sd_smaller <- sd(smaller_music_ratio)
#Creating dataframe for tests
a <- data.frame(values = bigger_music_ratio, groups = rep("Big", length(bigger_music_ratio)))
b <- data.frame(values = smaller_music_ratio,groups = rep("Small", length(smaller_music_ratio)))
data.for.test2 <- rbind(a,b)

###  Testing assumptions
##  Independency of variables (chi squared test)
chisq.test(data.for.test2$values, data.for.test2$groups)

##  Equal variance
#Boxplot for visual confirmation
boxplot(data.for.test2$values ~ data.for.test2$groups, xlab='Accounts', ylab='Engagment Ratio', data=data.for.test2)
#Bartlett test of homogeneity of variances
bartlett.test(data.for.test2$values ~ data.for.test2$groups, data = data.for.test2)

##  Normality
#QQplot visual test
ggqqplot(data.for.test2$values)
#Shapiro-wilk test
shapiro.test(data.for.test2$values)

### Preforming T test
t.test(bigger_music_ratio, smaller_music_ratio)