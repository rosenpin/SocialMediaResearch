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
mean_music_followers <- mean(dataset$Followers)
#Getting engagement ratios for bigger and smaller accounts
ratio_music_bigger <- dataset$Engagement.ratio[dataset$category_1 == "Music" & dataset$Followers > mean_music_followers]
ratio_music_smaller <- dataset$Engagement.ratio[dataset$category_1 == "Music" & dataset$Followers <= mean_music_followers]
#Calculating standard deviation for both groups and estimating standard error
sd_bigger <- sd(ratio_music_bigger)
sd_smaller <- sd(ratio_music_smaller)
sd_est <- sqrt((sd_bigger*length(ratio_music_bigger)+sd_smaller*length(ratio_music_smaller))/(length(ratio_music_smaller)+length(ratio_music_bigger)-2))
se_est <- sd_est*sqrt(1/length(ratio_music_bigger)+1/length(ratio_music_smaller))
#Creating dataframe for tests
a <- data.frame(values = ratio_music_bigger, groups = rep("Big", length(ratio_music_bigger)))
b <- data.frame(values = ratio_music_smaller,groups = rep("Small", length(ratio_music_smaller)))
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
#QQplot and histogram visual test
ggqqplot(data.for.test2$values)
hist(data.for.test2$values, breaks = 80)
#Shapiro-wilk test
shapiro.test(data.for.test2$values)

### Preforming T test
qt(.95,232)
t.test(ratio_music_bigger, ratio_music_smaller, var.equal = TRUE)

### Calculating Cohen's D
#finding mean values for both groups
mean_bigger <- mean(ratio_music_bigger)
mean_smaller <- mean(ratio_music_smaller)
#calculating d
cohens_d <- (mean_bigger - mean_smaller)/se_est
print(cohens_d)
