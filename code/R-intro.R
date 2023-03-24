# Data manipulation and visualization within R
# Written by Zach Vesoulis for "Big Data and the Smallest People:
# Leveraging Informatics and Machine Learning to Improve Your Clinical and
# Research Practice" Workshop presented at the 2023 PAS Annual Meeting
# Published under GPL-3.0 license

# For this example, we will utilize the ggplot and gridExtra packages to generate data visualization, load those package now
# If they are not installed, you will need to add them from the packages tab in bottom right panel
# or from the Tools -> Install Packages... menu selection

library(ggplot2)
library(gridExtra)

# This script assumes input data from the UVA dataverse library,
# specifically the one available from Niestroy et al. Replication Data for: Discovery of
# signatures of fatal neonatal illness in vital signs using highly comparative 
# time-series analysis available at https://doi.org/10.18130/V3/VJXODP

# We have created a modified version of the NICU_1007_vitals.mat file for use within R.
# Please ensure that you have downloaded and unzipped newTable.zip into the file newTable.rds.
# Open this file using the File -> Open menu, browsing to the location of the file.

# Unlike MATLAB or Octave, R cannot gracefully handle plotting the entire contents of the file.
# We need to create a smaller subset of the data.  Let's create one that is 172801 samples (96 hours).

f=newTable[300000:472800, ]

# Now, lets plot the time series in our new subset of data called f.  For ggplot, you need
# to reference the dataframe or object, define the X and y variables (time and HR here), and
# then specify the plot type.  ggplot is incredibly versatile and will make all kinds of plots.

ggplot(f, aes(x=TIME, y=HR))+geom_line()

# ggplot can also draw a trendline through the data using GAM, essential a piecewise linear regression with splines

ggplot(f, aes(x=TIME, y=HR))+geom_line()+stat_smooth()

# Lets say we are interested in looking at the distribution of SpO2 values at different times during the hospital course.
# The infant in this sample (NICU_1007) was born at 24 weeks.  The recording starts at 78370 seconds since midnight of birth
# so this baby is about 1.8 days old at the beginning of the file. Let's subset the data several times to look at 3 distinct periods
# in this baby's life.  Lets look at a 24 hour period in the first week of life, lets look at a 24 hour period in the mid NICU course
# during some of the worst chronic lung disease, and then at the end, soon before discharge.

# 24 hours at 2.6 days old (24 weeks PMA)
time1=newTable[17000:60200, ]

# 24 hours at 71 days old (34 weeks PMA)
time2=newTable[1490000:1533200, ]

# 24 hours at 285 days old (64 weeks PMA)
time3=newTable[6100000:6143200, ]

# Lets plot 3 basic histograms at each time point.  Note that the bins on the x axis
# vary based on the data distribution.  

hist(time1$SPO2.PCT)
hist(time2$SPO2.PCT)
hist(time3$SPO2.PCT)

# You can see that the distribution of SpO2 is very different at each of the time points, 
# but how can we do this in a way that the three points are compared?  Let's use ggplot
# to store three separate plots of the values in three different variables then display all
# three, stacked on top of each other

p1=ggplot(time1, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)
p2=ggplot(time2, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)
p3=ggplot(time3, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)
grid.arrange(p1, p2, p3, nrow = 3)

# We get a much better sense now that the SpO2 is much better titrated early (when the 
# baby presumably was intubated) compared to much later when extubated and lots of BPD spells.
# However, the X axes are scaled based on the data, so the distributions are still not comparable
# Let's fix that by setting the same x axis limits for all three.

p1=ggplot(time1, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)+xlim(25,100)
p2=ggplot(time2, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)+xlim(25,100)
p3=ggplot(time3, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)+xlim(25,100)
grid.arrange(p1, p2, p3, nrow = 3)

#That is much better.  Let's add a few more elements, just to make the final plot more pretty
p1=ggplot(time1, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="white", binwidth = 1)+xlim(25,100)+ggtitle("2.6 days old (24 weeks PMA)")+xlab(expression(SpO[2]~Percent))
p2=ggplot(time2, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="lightblue", binwidth = 1)+xlim(25,100)+ggtitle("71 days old (34 weeks PMA)")+xlab(expression(SpO[2]~Percent))
p3=ggplot(time3, aes(x=SPO2.PCT))+geom_histogram(color="black", fill="lightgreen", binwidth = 1)+xlim(25,100)+ggtitle("285 days old (64 weeks PMA)")+xlab(expression(SpO[2]~Percent))
grid.arrange(p1, p2, p3, nrow = 3)

# Kernel density plots are another way of looking at the distribution of data and
# are essentially smoothed histograms.  ggplot will overlay the three distributions
# in semi-transparent plots showing you the peak and tail

# Since we are comparing 3 groups, we need to combined the three subset dataframes we made earlier.
# We will be vertically concatenating the data into a shape called "long format" with an extra
# column added corresponding to the time period the data came from.  We are now sorting on this
# repeating variable instead of the time variable before.  We have already done this data manipulation
# and stored the file in data object called df_long.rds which you should load now.

ggplot(df_long, aes(SPO2.PCT, fill=period))+geom_density(adjust=2, alpha=0.4)+xlim(25,100)+ guides(fill=guide_legend(title="PMA"))+ scale_fill_discrete(labels=c('24 weeks','34 weeks','64 weeks'))+xlab(expression(SpO[2]~Percent))
