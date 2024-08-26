# Practice scripts using some STAT1002 data sets, graphing and tests.
# by Simon Hartley

# Clear variables/objects, use ls() to list objects first if you want to?
rm(list = ls())

# Set up the working directory(not really required if using a Project)
getwd()
setwd("~/STAT2003_tutorials")

# Install (if required) and load required packages
# install.packages(PACKAGE_NAME)
# Multiple packages at once e.g. install.packages(c("dplyr","car","DescTools"))
install.packages("dplyr", dependencies = TRUE) # Only need to do this once
install.packages("car", dependencies = TRUE)
install.packages("DescTools", dependencies = TRUE)

# library(PACKAGE_NAME)
library(dplyr) # Explore package functions (e.g. library(help="dplyr"))
library(car)
library(DescTools)

# Usually safe to ignore messages when loading packages, but sometimes 
# it's important if commands are masked by later packages loaded
find("Mean") # Uses function from the first package R finds
DescTools::Mean() # Use this to call a command in a specific package
# if there are conflicts.  Note that there is a base R command mean() but with lower case m.


################################################################################
# Create a frequency histogram using base R
################################################################################

# Load data
heigh_gender <- read.csv("data/heights_stat1002.csv", stringsAsFactors = TRUE)

# Separate males and females into different objects
?subset()
height_male <- subset(heigh_gender , Gender == 'M', select = c('Group','Gender', 'Replicate', 'Height'))

height_female <- subset(heigh_gender , Gender == 'F', select = c('Group','Gender', 'Replicate', 'Height'))

# Plot the two histograms
hist(height_male$Height) # Basic function
hist(height_female$Height)
# Tip: You could do all of the above in one function using by()

# Give the axes labels and column colour
?hist()
hist(height_male$Height, main=NULL, xlab="Student heights (cm)",
     col = "green")

hist(height_female$Height, main=NULL, xlab="Student heights (cm)",
     col = "green")

# Challenge: Repeat this with GGPLOT and improve upon formatting


# Challenge: Try to make histogram with both males and females on one axis


################################################################################
# Create a scatter plot using base R
################################################################################

# Load data
girth_biomass <- read.csv("data/girth_biomass_stat1002.csv", stringsAsFactors = TRUE)

plot(girth_biomass$Girth,girth_biomass$Biomass)

# Give the axes labels and points colour
?plot()
plot(girth_biomass$Girth,girth_biomass$Biomass, xlab="Girth at breast height (cm)",
     ylab="Above ground biomass (kg)", col = "brown")

# Challenge: Experiment with some of the settings

 
# Challenge: Make a more appealing graph with GGPLOT


################################################################################
# Create a box and whisker plot using the Base R or car
################################################################################

# Load data
gambusia <- read.csv("data/gambusia_stat1002.csv", stringsAsFactors = TRUE)

# Use the base R plot function
plot(gambusia$ratio, gambusia$attacks,type = "n")
# Give the graph labels and colour
plot(gambusia$ratio, gambusia$attacks,type = "n", xlab="Stocking ratio",
     ylab="Aggression (Number of attacks)", col = "orange")

# Use Boxplot from the car package
?Boxplot()
Boxplot(gambusia$attacks,gambusia$ratio)
Boxplot(gambusia$attacks,gambusia$ratio, xlab="Stocking ratio",
        ylab="Aggression (Number of attacks)", col = "orange")

# Challenge: Experiment with some of the settings


# Challenge: Make a more appealing graph with GGPLOT


################################################################################
# simple hypothesis testing - t-test
################################################################################

# Two-sample t-test
# Load data
diversity <- read.csv("data/diversity_stat1002.csv", stringsAsFactors = TRUE)

library(help="stats") # Shows functions from this base R package

# test for normality
by(diversity$Diversity, diversity$Location, shapiro.test)
# test for equivalence of variance
by(diversity$Diversity, diversity$Location, sd)
library(help="DescTools") # Shows functions from this base R package
LeveneTest(diversity$Diversity ~ diversity$Location) 

?t.test()
# Welsh Two-sample t-test, assuming unequal variance 
t.test(Diversity ~ Location, data=diversity)
# Long-hand
t.test(Diversity ~ Location, alternative="two.sided",paired="false", data = diversity)
# Alternate method for Welsh test from Ennos and Johnson
Lismore_diversity <- subset(diversity , Location == 'Lismore', select = c('Diversity'))
Davidsons_diversity <- subset(diversity , Location == 'Davidsons', select = c('Diversity'))
t.test(Lismore_diversity$Diversity,Davidsons_diversity$Diversity,paired = "FALSE")
# LM approach for t test assuming equal variance
Diversity_LM <- lm(Diversity ~ Location, data=diversity)
summary(Diversity_LM)
# QCIF workshop script for a student t-test, assuming equal variance
t.test(diversity$Diversity ~ diversity$Location, var.equal = TRUE)
# CHECK THIS, NOT THE SAME RESULT AS MODEL ANSWERS in STAT1002


# One-sample t-test
# Load data
peach <- read.csv("data/peach_stat1002.csv")
# Challenge: Test assumptions
t.test(peach$Diameter, mu=90, alternative="greater")


# Paired t-test (checked)
# Load data
exam_scores <- read.csv("data/exams_stat1002.csv")
# Challenge: Test assumptions
t.test(exam_scores$Exam.1,exam_scores$Exam.2,paired = "TRUE")


################################################################################
# Mann-Whitney U test
################################################################################

viral_load <- read.csv("data/Mann-Whitney.csv", stringsAsFactors = TRUE)

# Visualise data box plot
boxplot(viral_load$viral.load ~ viral_load$Treatment, col = c("red","blue"),
        ylab = "Viral load (Virus cells/cm)",
        xlab = "Treatment")
# Visualise data histograms
par(mfrow=c(1,2))
by(viral_load$viral.load, viral_load$Treatment, hist)
par(mfrow=c(1,1))
# Alternative method for side by side histogram
par(mfrow=c(1,2))
hist(viral_load$viral.load[which(viral_load$Treatment == 'Placebo')], main = "Placebo", xlab = "")
hist(viral_load$viral.load[which(viral_load$Treatment == 'Treated')], main = "Treated", xlab = "")
par(mfrow=c(1,1))

# Test for normality
by(viral_load$viral.load, viral_load$Treatment, shapiro.test)

# test for equivalence of variance
?wilcox.test()
wilcox.test(viral_load$viral.load ~ viral_load$Treatment, paired=FALSE)
# OR from Ennos and Johnson
wilcox.test(viral_load$viral.load ~ viral_load$Treatment, exact=FALSE)

