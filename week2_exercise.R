#Familiarise yourself with the built-in mpg data set. Note that the data set is only available after you load the ggplot2 library.
#Load Fuel economy dataset
?mpg

#Create a scatter plot of the mpg data set showing displacement by highway miles.
ggplot(mpg) + aes(displ, hwy) + geom_point(alpha = 0.5)

#In the same chart, map the city miles per gallon to the size aesthetic. What does the chart show? 
#Did you expect this result?
ggplot(mpg) + aes(displ, hwy,size=cty) + geom_point(alpha = 0.5)

#Colour the dots with the type of car.
ggplot(mpg) + aes(displ, hwy,size=cty,colour = class) + geom_point(alpha = 0.5)

#Remove the size mapping and overlay a rug chart.
ggplot(mpg) + aes(displ, hwy,colour = class) + geom_rug() + geom_point(alpha = 0.5)

#On the same chart add one smooth line showing displacement by highway miles trend.

ggplot(mpg) + aes(displ, hwy) +  geom_smooth() + geom_point(aes(colour = drv))

ggplot(mpg) + aes(displ, hwy) +
  geom_smooth(aes(linetype = drv)) + geom_point(aes(colour = drv))

#Create a bar chart showing the number of cars by type of car.
ggplot(mpg) + aes(class) + geom_bar()

#Create the same bar chart, showing also the fuel type as stacked bars.
ggplot(mpg) + aes(class, fill = fl) + geom_bar()


#Create a pie chart showing the number of cars by car type.
ggplot(mpg) + aes(x = "", fill = class) + geom_bar() + coord_polar("y")


# Create a histogram showing the distribution of the highway miles per gallon in 20 bins.

ggplot(mpg) +  geom_histogram(aes(hwy), data = mpg)

