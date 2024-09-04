# Title: R TUTORIAL WEEK 2 - Graphing with R 

# Purpose: This script will help you start to explore base R 
# graphing functions which you will use for exploring data and
# testing assumptions in subsequent tutorials and Assessment 2.

# We will also introduce ggplot2 and the grammar of graphics, for
# producing high quality graphics for your report. 

# Please work through chapters 1-3 and 6 of the online textbook
# and complete the first weeks tutorial prior to this class.
# The class is loosely based on Chapter 4 and 5 of the textbook.
# Use these chapters to help you develop your graphs.

# Data files used: "data/girth_biomass_stat1002.csv", "data/Data_MLR.txt"
# "data/gambusia_stat1002.csv", "data/peach_stat1002.csv",
# "data/Data_Anova_2way_fixed.txt" & "data/heights_stat1002.csv" 

# Author: Simon Hartley (STAT2003)

# Date script created: Thu Aug 31 06:59:33 2023
# Date script last modified: Thu Aug  29 08:59:15 2024
# TIP: use date() to get the current date.

# Package dependencies:
# install.packages("PACKAGE_NAME", dependencies = TRUE)
# Multiple packages at once e.g. install.packages(c("car","ggplot2","psych","DescTools"))
install.packages("car") 
# Always check is a package is installed first, can check using the following
if (!require(car)) install.packages("car")

# Load packages
library(car)
library(ggplot2) 
library(psych) 

# Add the R and package versions and other relevant information using
# the following function.  Can also just use sessionInfo()
xfun::session_info()

# Use CTRL + SHIFT + C to convert blocks of text to comments after pasting
# into a script, as below.

# R version 4.3.1 (2023-06-16 ucrt)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19045), RStudio 2023.6.0.421
# 

# 
# Locale:
#   LC_COLLATE=English_Australia.utf8 
# LC_CTYPE=English_Australia.utf8   
# LC_MONETARY=English_Australia.utf8
# LC_NUMERIC=C                      
# LC_TIME=English_Australia.utf8    
# 
# time zone: Australia/Sydney
# tzcode source: internal
# 
# Package version:
#   askpass_1.1        base_4.3.1         BH_1.81.0.1       
# boot_1.3-28.1      cellranger_1.1.0   class_7.3-22      
# cli_3.6.1          colorspace_2.1-0   compiler_4.3.1    
# cpp11_0.4.3        crayon_1.5.2       curl_5.0.1        
# data.table_1.14.8  DescTools_0.99.49  dplyr_1.1.2       
# e1071_1.7-13       Exact_3.2          expm_0.999-7      
# fansi_1.0.4        farver_2.1.1       generics_0.1.3    
# ggplot2_3.4.2      gld_2.6.6          glue_1.6.2        
# graphics_4.3.1     grDevices_4.3.1    grid_4.3.1        
# gtable_0.3.3       here_1.0.1         hms_1.1.3         
# httr_1.4.6         isoband_0.2.7      jsonlite_1.8.5    
# labeling_0.4.2     lattice_0.21-8     lifecycle_1.0.3   
# lmom_2.9           magrittr_2.0.3     MASS_7.3-60       
# Matrix_1.5-4.1     methods_4.3.1      mgcv_1.8.42       
# mime_0.12          mnormt_2.1.1       munsell_0.5.0     
# mvtnorm_1.2-2      nlme_3.1-162       openssl_2.0.6     
# parallel_4.3.1     pillar_1.9.0       pkgconfig_2.0.3   
# prettyunits_1.1.1  progress_1.2.2     proxy_0.4-27      
# psych_2.3.6        R6_2.5.1           RColorBrewer_1.1.3
# Rcpp_1.0.10        readxl_1.4.2       rematch_1.0.1     
# rlang_1.1.1        rootSolve_1.8.2.3  rprojroot_2.0.3   
# rstudioapi_0.14    scales_1.2.1       splines_4.3.1     
# stats_4.3.1        sys_3.4.2          tibble_3.2.1      
# tidyselect_1.2.0   tools_4.3.1        utf8_1.2.3        
# utils_4.3.1        vctrs_0.6.3        viridisLite_0.4.2 
# withr_2.5.0        xfun_0.39

# Remember you can use citation() to see how to reference R/packages in a report.


rm(list=ls()) # You should know what this does by now :-)

# It's good practice to always know where their working directory is set.
getwd()
setwd("~/STAT2003_tutorials")  # Only if required!

# Check files are in the current directory and confirm paths
list.files(recursive = TRUE, include.dirs = TRUE)


################################################################################
################################################################################
# Exploring data with base R graphing functions
################################################################################
# Let's look at a few common functions we might use to explore our
# data or validate model selection (e.g. test for normality, etc).
# plot() Powerful base R graphing function for a range of applications.
# boxplot() As the name suggests, create box plots for grouped data.
# hist() Create a frequency histogram  

################################################################################
# Exploring the plot() function  
################################################################################
?plot()

# Scatter plots
girth_biomass <- read.csv("data/girth_biomass_stat1002.csv")

str(girth_biomass)
View(girth_biomass)

plot(girth_biomass)
plot(x = girth_biomass$Girth, y = girth_biomass$Biomass) 

# Get rid of extra columns
girth_bio <- subset(girth_biomass , select = c('Girth','Biomass'))
View(girth_bio)

plot(girth_bio)
plot(x = girth_bio$Girth, y = girth_bio$Biomass) 
plot(girth_bio$Girth,girth_bio$Biomass)
plot(girth_bio$Biomass ~ girth_bio$Girth) 
plot(Biomass ~ Girth, data = girth_bio) # Different arguments but same result!
# Formula approach is more readable and intuitive.

# Can we improve on this?  See section 4.3.1 of the online textbook.
plot(Biomass ~ Girth, data = girth_bio, xlab = "Girth at breast height (cm)"
     , ylab = "Above ground biomass (kg)", pch = 16, col = "brown", cex = 0.5
     , xlim = c(0,60), bty = "l", las = 1, cex.axis = 0.8, tcl = -0.2)

# Challenge: Experiment with some of the settings.
plot(Biomass ~ Girth, data = girth_bio, xlab = "Girth at breast height (cm)"
     , ylab = "Above ground biomass (kg)", pch = 16, col = "green", cex = 0.5
     , xlim = c(0,60), bty = "l", las = 1, cex.axis = 0.8, tcl = -0.2)

# Challenge: Make a more appealing graph with ggplot2 - Chapter 5.


# Testing assumptions:  Checking for multiple-collinearity (pairwise plots)
marketting_data <- read.table("data/Data_MLR.txt", header = TRUE)

str(marketting_data)
View(marketting_data)

plot(marketting_data) # Pair wise plots
cor(marketting_data)  # Correlation matrix
# Also note possible lack of normality and equivalence of variance in some pairs

# The following does the same thing, but provides a little more control and trend lines.
cor_matrix <- cor(marketting_data[, c("youtube", "facebook", "newspaper", "sales")])
print(cor_matrix) # Correlation matrix.
pairs(marketting_data[, c("youtube","facebook","newspaper","sales")], 
      panel = panel.smooth) # Pairwise plots

# Challenge: Make a more appealing graph with pairs or ggplot2?

# Another useful graphing function is dotchart() for 
# identifying outliers in the data.


# plot() is clever!  Box plot for grouped data.  
gambusia <- read.csv("data/gambusia_stat1002.csv", stringsAsFactors = TRUE)
str(gambusia)
View(gambusia)
plot(gambusia)
# You can add the raw data as points with the following.
# This is a low level function.
points(x = gambusia$ratio, y = gambusia$attacks) 


################################################################################
# Create a frequency histogram using base R
################################################################################
?hist()
# Simple histogram
peach <- read.csv("data/peach_stat1002.csv")

str(peach) 
View(peach)

hist(peach$Diameter) # Bin width based on Sturges formula (assumes normality and not so good if n<30)
brk <- seq(from = 87, to = 96, by = 2) # Used to set bin width
hist(peach$Diameter, xlab = "Diameter (mm)", ylab = "Frequency", breaks = brk)

# Histograms for multiple groups
heigh_gender <- read.csv("data/heights_stat1002.csv", stringsAsFactors = TRUE)

str(heigh_gender)
View(heigh_gender)

par(mfrow=c(1,2)) # Splits the plot area into 1 row by 2 columns.
by(heigh_gender$Height, heigh_gender$Gender, hist)
par(mfrow=c(1,1)) # Remember to reset once you've finished!

# Alternate method separating males and females into different objects
?subset()
height_male <- subset(heigh_gender , Gender == 'M', select = c('Group','Gender', 'Replicate', 'Height'))

height_female <- subset(heigh_gender , Gender == 'F', select = c('Group','Gender', 'Replicate', 'Height'))

hist(height_male$Height, main=NULL, xlab="Student heights (cm)",
     col = "green") # Basic function
hist(height_female$Height, main=NULL, xlab="Student heights (cm)",
     col = "green")

# Challenge: Try to make a histogram with both males and females on one chart
# using the histogram() function in the lattice package?


################################################################################
# Create a box and whisker plot using the Base R or car
################################################################################

# Load data
gambusia <- read.csv("data/gambusia_stat1002.csv", stringsAsFactors = TRUE)

str(gambusia)
View(gambusia)

# Use the plot() function
plot(gambusia$ratio, gambusia$attacks, type = "n")
# Give the graph labels and colour
plot(gambusia$ratio, gambusia$attacks, type = "n", xlab="Stocking ratio",
     ylab="Aggression (Number of attacks)", col = "orange")
points(x = gambusia$ratio, y = gambusia$attacks)

# You can subset the data for display as follows (and apply different dot colours or styles)
plot(gambusia$ratio, gambusia$attacks, type = "n", xlab="Stocking ratio",
     ylab="Aggression (Number of attacks)", col = "orange")
points(x = gambusia$ratio[gambusia$ratio == "C"], y = gambusia$attacks[gambusia$ratio == "C"],
       pch = 16, col = "blue")

# Use Boxplot from the car package
?Boxplot()

# For one group of data
Boxplot(peach)

# For multiple groups
Boxplot(gambusia$attacks, gambusia$ratio)
Boxplot(gambusia$attacks ~ gambusia$ratio, xlab="Stocking ratio",
        ylab="Aggression (Number of attacks)", col = "orange")

# Changing the order of groups?
gambusia$ratio <- factor(gambusia$ratio, levels = c("E","D","C","B","A"))
Boxplot(gambusia$attacks ~ gambusia$ratio, xlab="Stocking ratio",
        ylab="Aggression (Number of attacks)", col = "orange")

# Challenge: Experiment with some of the settings

# Multiple factors in the plot (e.g. for a two-factor ANOVA)
# If necessary you can specify if the file is space or comma delimited 
# as follows sep = " ", sep=",".
cheese_data <- read.table("data/Data_anova_2way_fixed.txt", header = TRUE, stringsAsFactors = TRUE)
str(cheese_data)
View(cheese_data)
Boxplot(cheese_data$Acids ~ cheese_data$R50*cheese_data$R21, xlab="Bacteria (R50.R21)",
        ylab="Acidity", col = "yellow")

# Challenge: Make a more appealing graph with ggplot2?


################################################################################
# Exporting your graphs using pdf(), png(), jpeg(), tiff() or bmp()
################################################################################
jpeg('my_plot.jpg')
Boxplot(cheese_data$Acids ~ cheese_data$R50*cheese_data$R21, xlab="Bacteria (R50.R21)",
        ylab="Acidity", col = "yellow")
dev.off()



################################################################################
################################################################################
# Producing high quality graphs with ggplot2
################################################################################
# For reports and publication, we will likely want more control, consistency and
# capability in our graphing than the base R functions offer.

library(help="ggplot2") # Explore package functions


################################################################################
# Graphing for regression (and multiple regression)
################################################################################

# Load and prepare data for graphing.
Marketing.data <-read.table("data/Data_MLR.txt", header = TRUE)

str(Marketing.data)
View(Marketing.data)

# The three most important aspects of creating a graph initially are...
# 1. Defining the data set.
# 2. Mapping of variables in the chart (aesthetics).
# 3. Defining the geometry (bar chart, scatter plot, etc)
# We'll set these basic parameters and then work on the formatting. 
# Note, adding a + lets us continue on the next line. 

ggplot()

# Define the data and aesthetic
ggplot(data=Marketing.data, aes(x = facebook, y=sales))

# Add points.  Note: + used to add layers.
ggplot(data=Marketing.data,aes(x = facebook, y=sales))+
  geom_point()

# Where you add data and other arguments affects whether they apply 
# to ALL layers (ggplot()) or just one (e.g. geom_point()).
ggplot()+
  geom_point(data=Marketing.data,aes(x = facebook, y=sales))

# Add a trendline
ggplot(data=Marketing.data,aes(x = facebook, y=sales))+
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)

# Change the theme (you can use an exiting theme or create your own
# to set the fonts, lines and borders, etc)
ggplot(data=Marketing.data,aes(x = facebook, y=sales))+
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)+
  theme_classic() 

# Add a second variable for multiple regressions (next week)
# Note: I've removed the line of best fit. 
ggplot(data=Marketing.data,aes(x = facebook, y=sales, colour = youtube))+
  geom_point()+
  theme_classic() 

# Why might this be preferred to a 3D graph?

# Let's use a simple theme/layout and add a colour gradient.
ggplot(data=Marketing.data,aes(x = facebook, y=sales,color=youtube))+
  geom_point()+
  theme_classic() +
  scale_colour_gradient(low = "green", high = "red")  

?scale_colour_gradient

# Label the axes and and change the scale.
ggplot(data=Marketing.data,aes(x = facebook, y=sales,color=youtube))+
  geom_point()+
  theme_classic() +
  scale_colour_gradient(low = "green", high = "red") +
  labs(y="Mean sales",x="Mean number of Facebook adds") +
  scale_x_continuous(limits=c(0,65), expand=expansion(mult=c(0,0)), breaks=seq(0,65,10)) +
  scale_y_continuous(limits=c(0,35), expand = expansion(mult=c(0,0)), breaks=seq(0,35,5))

# Finally, we'll add a custom theme to tidy up text and lines.  
# Create the theme first as an object
# Section 5.2.5 shows how to create and modify a theme,  including
# font sizes, background, borders, etc.
scat_plot_theme <- theme(panel.background=element_rect(fill="transparent"))+
  theme(axis.line=element_line(colour="black", size =0.5, linetype="solid"))+
  theme(axis.ticks=element_line(colour="black", size=0.5, linetype = "solid"))+
  theme(axis.text.x = element_text(size = 11, colour = "black"))+  # Axis text.
  theme(axis.text.y = element_text(size = 11, colour = "black"))+  
  theme(text=element_text(size=13, colour = "black"))  # Axis titles.

# Now add this custom theme as a layer.  
#Note: delete classic theme.
ggplot(data=Marketing.data,aes(x = facebook, y=sales,color=youtube))+
  geom_point()+
  scale_colour_gradient(low = "green", high = "red") +
  labs(y="Mean sales",x="Mean number of Facebook adds", color="YouTube adds") +
  scale_x_continuous(limits=c(0,65), expand=expansion(mult=c(0,0)), breaks=seq(0,65,10)) +
  scale_y_continuous(limits=c(0,35), expand = expansion(mult=c(0,0)), breaks=seq(0,35,5)) +
  scat_plot_theme

# Some things you might want to experiment with on your own...
# Changing colour pallets.
# Black outline on points.
# Changing fonts.
# Adding special symbols.
# Editing the legend.
# Plotting multiple graphs together (using plotgrid or cowplot)
# Note: par(mfrow=c(1,2)) Doesn't work with gglot2 (need to install gridarrange 
# see 5.2.3 in the textbook). If you want to arrange multiple plots in a grid.


################################################################################
# Export your graph using ggsave() OR use the Export drop menu in the
# Plots tab of the multi-use panel.
#################################################################################
# Note: Different to exporting a base R graph.

# Put your graph into an object
mlr_plot <- ggplot(data=Marketing.data,aes(x = facebook, y=sales,color=youtube))+
  geom_point()+
  scale_colour_gradient(low = "green", high = "red") +
  labs(y="Mean sales",x="Mean number of Facebook adds", color="YouTube adds") +
  scale_x_continuous(limits=c(0,65), expand=expansion(mult=c(0,0)), breaks=seq(0,65,10)) +
  scale_y_continuous(limits=c(0,35), expand = expansion(mult=c(0,0)), breaks=seq(0,35,5)) +
  scat_plot_theme

mlr_plot

?ggsave # learn about the syntax of  ggsave().

# Save the object to a file
ggsave(
  filename = "output/regression_plot.jpeg",
  plot = mlr_plot, # Or just last_plot() if you don't want to create an object.
  device = "jpeg",
  path = NULL,
  scale = 1,
  width = 22,
  height = 16,
  units = c("cm"),
  dpi = 300,
  limitsize = TRUE,
  bg = NULL)

# If this just get's too hard then use the Export function in the multi-use panel,
# see the tutorial week 2 recording.


################################################################################
# Graphing for a factorial designs - Column chart with error bars.
################################################################################

# Load and prepare data for graphing.  
# The following is rather a long winded approach, but it introduces 
# the useful skill of sub-setting a data set using boulean logic.  

Cheese.data <- read.table("data/Data_Anova_2way_fixed.txt",header=TRUE,stringsAsFactors=TRUE)

str(Cheese.data)
View(Cheese.data)

# Create a data frame which contains our means and SEs.
# e.g. start with replicates where there was no R50 and no R21.
s1 <- subset(Cheese.data, R50=='no' & R21=='no') 
s2 <- subset(Cheese.data, R50=='no' & R21=='yes')
s3 <- subset(Cheese.data, R50=='yes' & R21=='no')
s4 <- subset(Cheese.data, R50=='yes' & R21=='yes')
# Calculate means for these groups.
m1<-mean(s1$Acids)
m2<-mean(s2$Acids)
m3<-mean(s3$Acids)
m4<-mean(s4$Acids)
# Calculate standard errors (standard deviation divided by square root of n).
se1<-sd(s1$Acids)/sqrt(length(s1$Acids))
se2<-sd(s2$Acids)/sqrt(length(s2$Acids))
se3<-sd(s3$Acids)/sqrt(length(s3$Acids))
se4<-sd(s4$Acids)/sqrt(length(s4$Acids))
# Put all means and SEs needed for plotting into a new dataframe (make sure to assign
# the right means and SEs to the right treatment combinations).
data.frame_plot <- data.frame(Acids_mean=c(m1,m2,m3,m4),R50=c("no","no","yes","yes"),R21=c("no","yes","no","yes"),Acids_se=c(se1,se2,se3,se4))
View(data.frame_plot)

# If the above is too confusing and long-winded, then the following will achieve 
# the same thing.  Thanks Mona Andskog for providing this script.
# install.packages("tidyverse")
# library(tidyverse)
# data.frame_plot <- data.frame(Cheese.data %>% 
#                              group_by(R50, R21) %>% 
#                              summarise(Acids_mean = mean(Acids, na.rm = T),
#                                         Acids_se = sd(Acids, na.rm = T)/sqrt(length(Acids))))
# View(data.frame_plot)

# Plot the means and SEs.  I've gone through this before so this   
# is abbreviated

# Start with the basics.
# Define data set and variables, geometry and add error bars.
ggplot(data.frame_plot, aes(fill=R21, y=Acids_mean, x=R50)) +  
  geom_bar(position="dodge", stat="identity") +  # Define geometry.
  geom_errorbar(aes(ymin=Acids_mean-Acids_se, ymax=Acids_mean+Acids_se),
                width=.2,position=position_dodge(0.9))
# stat="identity" tells ggplot to plot the actual y value and not the frequency or aggregate all values
# position="dodge" tells ggplot to have pairs side-by-side


# Let's apply a theme and put black borders on the bars.
ggplot(data.frame_plot, aes(fill=R21, y=Acids_mean, x=R50)) +
  geom_bar(position="dodge", stat="identity", color="black") + # Black borders.
  geom_errorbar(aes(ymin=Acids_mean-Acids_se, ymax=Acids_mean+Acids_se),
                width=.2,position=position_dodge(0.9))+
  theme_classic() # Gets rid of shading, frame and gridlines.

# Now let's label the axes.
ggplot(data.frame_plot, aes(fill=R21, y=Acids_mean, x=R50)) +
  geom_bar(position="dodge", stat="identity", color="black") + 
  geom_errorbar(aes(ymin=Acids_mean-Acids_se, ymax=Acids_mean+Acids_se),
                width=.2,position=position_dodge(0.9))+
  theme_classic() +
  labs(y="Mean acid level (+/-SE)",x="R50 treatment")
# You might want to label your factors and levels in a meaningful way in your data frame.
# Adding superscript, etc requires a special function, e.g.  labs(y=expression(Acid~level~m^2~m^-2), x="R50 treatment")
# Another example, expression(g~C~m^-2~day^-1)
# =NULL, removes labels from axes entirely.

# Finally, let's change the scale on the y axis.
ggplot(data.frame_plot, aes(fill=R21, y=Acids_mean, x=R50)) +
  geom_bar(position="dodge", stat="identity", color="black") + 
  geom_errorbar(aes(ymin=Acids_mean-Acids_se, ymax=Acids_mean+Acids_se),
                width=.2,position=position_dodge(0.9))+
  theme_classic() +
  labs(y="Mean acid level (+/-SE)",x="R50 treatment") +
  scale_y_continuous(limits=c(0,3), expand = expansion(mult=c(0,0)), breaks=seq(0,3,0.5))
# You can adjust the scale on the x axis too if you needed to, scale_x_continuous() 
# and scale_x_discrete().

# Looking good.  There are ways to simplify this scripting and other enhancements
# you can make.  For example, you could make your own themes to apply to multiple charts.

# Creating a plot theme as an object, to set font and line size and colour.
bar_chart_theme <- theme(panel.background=element_rect(fill="transparent"))+
  theme(axis.line=element_line(colour="black", size =0.5, linetype="solid"))+
  theme(axis.ticks=element_line(colour="black", size=0.5, linetype = "solid"))+
  theme(axis.text.x = element_text(size = 11, colour = "black"))+  # Axis text.
  theme(axis.text.y = element_text(size = 11, colour = "black"))+  
  theme(text=element_text(size=13, colour = "black"))  # Axis titles.

ggplot(data.frame_plot, aes(fill=R21, y=Acids_mean, x=R50)) +
  geom_bar(position="dodge", stat="identity", color="black") + 
  geom_errorbar(aes(ymin=Acids_mean-Acids_se, ymax=Acids_mean+Acids_se),
                width=.2,position=position_dodge(0.9))+
  labs(y="Mean acid level (+/-SE)",x="R50 treatment") +
  scale_y_continuous(limits=c(0,3), expand = expansion(mult=c(0,0)), breaks=seq(0,3,0.5)) +
  bar_chart_theme 

# Some things you might want to experiment with on your own...
# Adding letters or bars to illustrate HSD results.
# Changing colour pallets and opacity.
# Changing fonts.
# Adding special symbols.
# Editing the legend.
# Applying ALL the attributes of a good quality graph introduced in STAT1002.


################################################################################
# Export your graph using ggsave() OR use the Export drop menu in the
# Plots tab of the multi-use panel.
################################################################################

# Start by putting your graph into a new object.
mybar_plot <- ggplot(data.frame_plot, aes(fill=R21, y=Acids_mean, x=R50)) +
  geom_bar(position="dodge", stat="identity", color="black") + 
  geom_errorbar(aes(ymin=Acids_mean-Acids_se, ymax=Acids_mean+Acids_se),
                width=.2,position=position_dodge(0.9))+
  labs(y="Mean acid level (+/-SE)",x="R50 treatment") +
  scale_y_continuous(limits=c(0,3), expand = expansion(mult=c(0,0)), breaks=seq(0,3,0.5)) +
  bar_chart_theme

# Then save the graph into a file.
ggsave(
  filename = "output/factorial_chart.jpeg",
  plot = mybar_plot, # Or just last_plot() if you don't want to create an object.
  device = "jpeg",
  path = NULL,
  scale = 1,
  width = 22,
  height = 16,
  units = c("cm"),
  dpi = 300,
  limitsize = TRUE,
  bg = NULL)

# If this just get's too hard then use the Export function in the multi-use panel,
# see the tutorial week 4 recording.  

# WE WILL REVISIT GRAPHING FOR FACTORIAL DESIGNS IN WEEK 4
