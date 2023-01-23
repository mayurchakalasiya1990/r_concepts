install.packages("ggplot2")

#Load ggplot2 dataset
library(ggplot2)

#Load Diamond dataset
? diamonds

#=================================================================================================
#aes() : function to construct the aesthetic mapping
#geom_point() : create the geometry layer with geom_point(), which creates a scatter plot

ggplot(diamonds) + aes(carat, price) + geom_point(alpha = 0.5)

#print nos of row in diamond dataset
nrow(diamonds)

#=================================================================================================
#sample(): to produces 500 random indices between 0 and 53940
#set.seed(): to makes the code reproducible, by making sure you always pick always the same sample

set.seed(2)
sampleDiamonds <- diamonds[sample(nrow(diamonds), 500), ]

ggplot(sampleDiamonds) + aes(carat, price) + geom_point(alpha = 0.5)

#The following lines all produce the same chart as above. The difference in these examples is merely theoretical.
ggplot(sampleDiamonds) + geom_point(aes(carat, price), alpha = 0.5)

ggplot(sampleDiamonds) + geom_point(aes(carat, price), alpha = 0.5)

#add another aesthetic mapping
ggplot(sampleDiamonds) + aes(carat, price, colour = cut) + geom_point(alpha = 0.5)

#the respective geom_* function will also show what aesthetic mappings are available
? geom_point

#=================================================================================================
#Derived dimensions
#prices are rising exponentially, indicating that a log-log plot might be useful.
#A log-log plot uses a logarithmic scale for both the x and y-axis

ggplot(sampleDiamonds) + aes(log(carat), log(price), colour = cut) + geom_point(alpha = 0.5)

#=================================================================================================
#line plot with geom_line
#store the coordinate system and aesthetic mappings in the variable diamondPlot
diamondPlot <- ggplot(sampleDiamonds) + aes(carat, price, color = cut)
diamondPlot + geom_line()

#Trend lines Plotting smoothed averaged values using geom_smooth().
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

diamondPlot + geom_smooth()

#Rug plot (obscure)

diamondPlot + geom_rug()

#=================================================================================================
#Adding multiple geometries

ggplot(sampleDiamonds) + aes(carat, price, colour = cut) +  geom_point() + geom_smooth()

#fit one average line, we need to pass different aesthetic mappings to each geometry

ggplot(sampleDiamonds) +  geom_point(aes(carat, price, colour = cut)) + geom_smooth(aes(carat, price))

#even add the rug geometry
#one default aesthetic mapping for geom_point() and geom_rug(), and one specific mapping for geom_smooth()

ggplot(sampleDiamonds) + aes(carat, price, colour = cut) +  geom_point() + geom_rug() + geom_smooth(aes(carat, price, colour = NULL))

# even combine geometries that may not make much sense (scatter plot and a histogram)
ggplot(sampleDiamonds) + geom_point(aes(carat, price, colour = cut)) +  geom_histogram(aes(carat), data = diamonds)


#=================================================================================================
#bar chart showing the number of diamonds per cut grade

ggplot(diamonds) + aes(cut) + geom_bar()

#Stacked bar chart

ggplot(diamonds) + aes(cut, fill = color) + geom_bar()

#Pie chart
#no native support for pie charts in ggplot2
#To create a bar chart with one column, we map the x aesthetic to an empty element, 
#and use the fill aesthetic to colour in the segments. geom_bar draws
#the bar chart and coord_polar("y") wraps the y axis.

ggplot(diamonds) + aes(x = "", fill = cut) + geom_bar() + coord_polar("y")



