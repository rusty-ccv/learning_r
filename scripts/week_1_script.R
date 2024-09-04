# R TUTORIAL WEEK 1 - Getting started with R 
# The R environment, arithmetic, functions, data and packages.
# Simple statistics (if time) 

# Please work through the activities in the Unit Overview prior to 
# this tutorial.  Install R, R Studio and setup your working directory.

# by Simon Hartley (STAT2003)

contributors()
citation()  # How to reference R in a report.

rm(list=ls())  # Remove any variables from memory.

# Check or set your working directory if required
getwd()
setwd("~/STAT2003_tutorials")  # Path may not work on your computers.

# Review the files we will be using
list.files(recursive = TRUE, include.dirs = TRUE)


################################################################################
# Package dependencies.  
# Need to install and load: "DescTools", "ggplot2" and "psych"
# Needed base R packaged (pre-loaded): "utils" and "stats"
################################################################################
# Tip: Check in the "Packages" window to see if installed and loaded?
# Tip: You only need to install ONCE!
# install.packages("PACKAGE_NAME")
# Multiple packages at once e.g. install.packages(c("DescTools","psych","ggplot2"))
install.packages("DescTools", dependencies = TRUE)
install.packages("psych", dependencies = TRUE)  
install.packages("ggplot2", dependencies = TRUE) 

# Load packages needed for this session
# Tip: need to do this before you can use the package.
# library(PACKAGE_NAME) OR use require(PACKAGE_NAME) OR activate in the multi-use window.
library(DescTools) # Loads the package ready for use.
library(psych) 
library(ggplot2)
# library(utils) # Should already be loaded
# library(stats)


# Usually safe to ignore messages when loading packages, but sometimes 
# it's important if functions are masked by later packages.

detach(package:ggplot2) # To detach a package previously loaded

library(help="psych")# Explore package functions

find("Mean") # There is a base R function mean() but with lower case m.
find("SD")

DescTools::SD() # Use this to call a function in a specific package
# if there are conflicts.  

# DescTools::  List/select what functions are available in a package
library(help="DescTools") # Also lists all functions from a package

# Installing the following package could help you to find a package with
# a particular function you need
# install.packages("sos", dependencies = TRUE) 
# library(sos)

citation("DescTools") # How to cite a package used.

# Homework: How do you decide what packages you'll need before installing them?


################################################################################
# Basic arithmetic operations and functions
################################################################################
# We will manually type a number of simple calculations and functions 
# (e.g. 5+5 and sqrt()) at the start of the tutorial.


################################################################################
# Manually entering a data set into R (learning about objects)
################################################################################

# Vectors.
mydata <- c(25,34,23,35,22)
mydata
str(mydata)  # Shows you what type of data you’ve got. Important!  
# Make sure you have the right type of data for packages and functions.
# Can also use glimpse() from the pillar package.
median(mydata)
mydata[2]
mydata[2] <- 12  # Alter a value in your vector. 
median(mydata)

# Dataframes.  Different ways of creating these but here is a simple method.  
df_fruit <- c("Kiwi","Banana","Apple","Honey Melon","Tangelo")
df_weight <- c(30,80,75,450,90)
df_price <- c(0.7, 1.0,1.2,3.5,1.5)
my_dataframe1 <- data.frame(Fruit = df_fruit, Weight = df_weight, Price = df_price)

View(my_dataframe1)  # Get into the habit of checking your date carefully after creating or importing (using View(), head(), str(), to help avoid any problems later.
head(my_dataframe1)
str(my_dataframe1) # e.g. as.numeric(my_dataframe1$Weight) if need to change weight to a numeric variable.
# as.factor() May be necessary in your project if using a factorial design.  

my_dataframe1[,"Weight"] # Could also use my_dataframe1$Weight to show just the values for this field.


################################################################################
# Importing data into R
################################################################################
# It's more common that you would import a data set into R, from a 
# file but there are some included data frames.

data()  ## () is a wild card.  Shows all the existing data frames that have been provided in R.
data(trees) # Loads this included data framelib

View(trees) # Can also click on in Global environment.
head(trees)
str(trees) # dim(trees) if you want to see the dimensions (number of rows and columns) of matrix.

nrow(trees) # number of replicates!
mean(trees$Girth)  # This is how you specify a variable to examine.
attach(trees)  # saves a bit of code.
mean(Girth)
sd(Girth)
psych::SD(Girth)
DescTools::SD(Girth) # I'm just curious what the difference is?
fivenum(Girth)  
detach(trees)  

summary(trees)
# Packages expand the vocabulary and capabilities of R.
?psych   ## Shows all the functions available in the package.  
describe(trees)    ## Provides more detailed summary statistics than  the base R function

# Homework: Explore some of the other descriptive statistics in R


################################################################################
# simple hypothesis testing - t-test (see Module 1 videos on basic statistics)
################################################################################

# One-sample t-test
# Load data into a data frame from a file
peach <- read.csv("data/peach_stat1002.csv")

# Explore the data
str(peach) # Diameter is an integer, can convert with as.numeric() if required
View(peach)
head(peach)
describe(peach)  # Does the skew and kurtosis look good?

# Test assumptions
shapiro.test(peach$Diameter)

hist(peach$Diameter)

# perform the test
t.test(peach$Diameter, mu=90, alternative="greater")


# Paired t-test
# Load data
exam_scores <- read.csv("data/exams_stat1002.csv")

# Explore the data
str(exam_scores) # Look at the table to understand what this is telling you
View(exam_scores)
describe(exam_scores)

# Challenge: Test assumptions?

t.test(exam_scores$Exam.1,exam_scores$Exam.2, paired = "TRUE")


# Two-sample t-test
# Load data
diversity <- read.csv("data/diversity_stat1002.csv", stringsAsFactors = TRUE)

str(diversity) 
View(diversity)
describe(diversity) # Provides more detailed summary statistics than base R

boxplot(diversity$Diversity ~ diversity$Location, col = c("red","blue"),
        ylab = "Gleeson's Diversity",
        xlab = "Location")

# test for normality (groups separately)
?by()
by(diversity$Diversity, diversity$Location, shapiro.test)
# test for equivalence of variance
by(diversity$Diversity, diversity$Location, sd)
library(help="DescTools") # Contains Levene test
LeveneTest(diversity$Diversity ~ diversity$Location) 
# try center = mean above? 

# Let's look at arguments and how they affect our result?
# NOTE: Only one line below is required to perform the test.
?t.test()
# Welsh Two-sample t-test, assuming unequal variance 
t.test(Diversity ~ Location, data=diversity)
# Long-hand.  Note: Some arguments are set by default
t.test(Diversity ~ Location, alternative="two.sided",paired="false", data = diversity)

# QCIF workshop script for a student t-test assuming equal variance
t.test(diversity$Diversity ~ diversity$Location, var.equal = TRUE)
# NOT THE SAME RESULT AS MODEL ANSWERS in STAT1002

# Alternate method for t test from Ennos and Johnson
Lismore_diversity <- subset(diversity , Location == 'Lismore', select = c('Diversity'))
Davidsons_diversity <- subset(diversity , Location == 'Davidsons', select = c('Diversity'))
t.test(Lismore_diversity$Diversity,Davidsons_diversity$Diversity,paired = "FALSE", var.equal = TRUE)

# LM approach for t test assuming equal variance
Diversity_LM <- lm(Diversity ~ Location, data=diversity)
summary(Diversity_LM)


################################################################################
# Mann-Whitney U test  (see Module 1 videos on basic statistics)
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

################################################################################
# simple hypothesis testing - Chi squared (see Module 1 videos on basic statistics)
################################################################################

# Create a data frame for the Chi test of difference
day_week <- c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
observed <- c(33,41,63,63,47,56,47)
US_births <- data.frame(Day = day_week, Observed = observed)

View(US_births)  # Get into the habit of checking your date carefully after creating or importing (using View(), head(), str(), to help avoid any problems later.
head(US_births)
str(US_births)

chisq.test(US_births$Observed)

# Challenge: How would you change the expected ratio from 1:1:1:1:1:1:1?

# Chi test of association

# Create a data matrix 
snails <- matrix(c(11,31,14,17,18,13,21,35,27), nrow = 3)
colnames(snails) <- c("Nerita", "Austrocochlea","Bembicium")
rownames(snails) <- c("Zone_1", "Zone_2", "Zone_3")
View(snails)

chisq.test(snails)


################################################################################
# Correlation (see Module 1 videos on basic statistics)
################################################################################

HR_BP <- read.csv("data/HR_BP_stat1002.csv")

str(HR_BP) 
View(HR_BP)
# Woops!  I stuffed up!  Good thing you checked!  

# Challenge: Save the correct data into a file and run correlation.

cor(HR_BP$Heart_rate,HR_BP$Blood_p) # Correlation coefficient
cor(HR_BP) # Correlation matrix, Hint:Maybe useful for multiple regression.

cor.test(HR_BP$Heart_rate,HR_BP$Blood_p) # Provides P and t-calculated

# That's enough for now!