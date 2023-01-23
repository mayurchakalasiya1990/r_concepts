#load ggplot2 library
library(ggplot2)

#mpg data set
?mpg
?diamonds

# Display few record from mpg data set
head(mpg)

#===================================================================================================
#fit a trend line using linear regressions(method= "lm") with geom_smooth()
ggplot(mpg) + aes(cty, hwy) + geom_point() +  geom_smooth(method = "lm")

#The jitter geom is a shortcut for geom_point(position = "jitter") 
#and adds a small amount of random variation to the location of each point to avoid overplotting 
#(i.e. multiple points on the exact same location).
ggplot(mpg) + aes(cty, hwy) + geom_jitter() +  geom_smooth(method = "lm")

#===================================================================================================
#colouring the dots a bit bigger and pink, and making the smoothed line a dashed black line
ggplot(mpg) + aes(cty, hwy) +
  geom_jitter(colour = "darkviolet", size = 3) +
  geom_smooth(method = "lm", colour = "black", linetype = "dashed")

#To specify labels, use the labs() function.
#Any parameters of the label() function are optional

ggplot(mpg) + aes(cty, hwy) +
  geom_jitter(colour = "darkslateblue", size = 2) +
  geom_smooth(method = "lm", colour = "black", linetype = "dashed") +
  labs(x = "City mileage", y = "Highway MPG",
       title = "Highway by city MPG",
       subtitle = "Are highway and city consumption correlated?",
       caption = "I \U2665 ggplot2")

#===================================================================================================
#Legends

#city mileage is a continuous scale, ggplot creates a colour bar legend. 
#Fuel type is discrete, therefore ggplot2 creates a standard legend
#encode four variables: 
#1) engine displacement 
#2) highway mileage in the position (x- and y-axes)
#3)city mileage as colour 
#4) fuel type as shape

ggplot(mpg) + aes(displ, hwy, colour = cty, shape = fl) + geom_jitter()


#function theme() is used to control the appearance of any element of the graphic.
ggplot(mpg) + aes(displ, hwy, colour = cty, shape = fl) +
  geom_jitter(size = 3, alpha = 0.5) +
  labs(x = "Engine displacement", y = "Highway MPG",
       colour = "City MPG", shape = "Fuel type") +
  theme(legend.position = c(0.9, 0.5),
        legend.background = element_rect(fill="lightgrey",
                                         size=0.5),
        legend.title = element_text(colour="grey10", size=10,
                                    face="bold"))


#scale_shape_manual() function to specify specific shapes (shapes in R are numbered, we use shapes 15 to 19) and the labels for each category

ggplot(mpg) + aes(displ, hwy, colour = cty, shape = fl) +
  geom_jitter(size = 3, alpha = 0.5) +
  labs(x = "Engine displacement", y = "Highway MPG",
       colour = "City MPG", shape = "Fuel type") +
  scale_shape_manual(values = 15:19,
                     labels = c("CNG", "Diesel", "E85", "Premium", "Regular"))

# specify a custom scale for the colour aesthetic. 
# This time, we use a gradient scale, where we specify the “low” and “high” colour.
ggplot(mpg) + aes(displ, hwy, colour = cty, shape = fl) +
  geom_jitter(size = 3, alpha = 0.5) +
  labs(x = "Engine displacement", y = "Highway MPG",
       colour = "City MPG", shape = "Fuel type") +
  scale_shape_manual(values = 15:19,
                     labels = c("CNG", "Diesel", "E85", "Premium", "Regular")) +
  scale_colour_gradient(low = "palegreen", high = "darkred")


#===================================================================================================
#Logarithmic scales

ggplot(mpg) + aes(displ, hwy) + geom_point() +
  scale_x_log10() + scale_y_log10()

#If we want to use a different logarithm, e. g. base2, we need to use scale_*_continuous and specify the transformation:
ggplot(mpg) + aes(displ, hwy) + geom_point() +
  scale_x_continuous(trans = "reverse") +
  scale_y_continuous(trans = "log2")

ggplot(diamonds[sample(nrow(diamonds), 250),]) + aes(carat, price) + geom_point() +
  scale_x_log10() + scale_y_log10()


#Sometimes we need to add a label to a chart to explain something. ggplot provides the annotate() function to add an annotation layer

ggplot(mpg) + aes(displ, hwy, colour = class) +
  geom_jitter() +
  geom_smooth(method = "lm", formula = y ~ x, colour = "darkgrey",
              size = 0.5, fill = "lightgrey") +
  annotate(geom = "text", x= 6.5, y = 29,
           label = "2 seaters are\nless economical",
           colour = "grey30", size = 4)

#===================================================================================================
# Facets

#to produce several graphics  
#ggplot2 makes it easy to create a series of charts with faceting. 
# add one of the facet functions (facet_wrap() or facet_grid()) and pass the respective variable wrapped in a vars() call
ggplot(mpg) + aes(displ, hwy, colour = cty) + geom_jitter() +  facet_wrap(vars(fl))

#To define custom labels, we first need to define a vector with the labels
fl.labels <- c("CNG", "Diesel", "E85", "Premium", "Regular", "x")

names(fl.labels) <- c("c", "d", "e", "p", "r", "x")

#set the name of each element to the value in the data
ggplot(mpg) + aes(displ, hwy, colour = cty) + geom_jitter() +
  scale_colour_gradient(low = "palegreen", high = "darkred") +
  facet_wrap(vars(fl), labeller = labeller(fl = fl.labels ))

#two variables in a facet grid (flue and class)
fl.labels <- c("CNG", "Diesel", "E85", "Premium", "Regular")
names(fl.labels) <- c("c", "d", "e", "p", "r")
ggplot(mpg) + aes(displ, hwy, colour = cty) + geom_jitter() +
  scale_colour_gradient(low = "palegreen", high = "darkred") +
  facet_grid(fl ~ class, labeller = labeller(fl = fl.labels ))

#===================================================================================================
#Themes : Themes are a way to change the look of a graphics completely.
ggplot(mpg) + aes(displ, hwy, colour = class) + geom_jitter() +
  theme_minimal()

#ggplot2 comes with a some predefined themes. More themes are defined in the package ggthemes
install.packages("ggthemes")
library(ggthemes)

#ggthemes provides over 100 themes, palettes and scales
ls("package:ggthemes")

#Economist
base.plot <- ggplot(mpg) + aes(displ, hwy, colour = class) + geom_jitter()
base.plot +
  theme_economist() + scale_colour_economist() +
  scale_y_continuous(position = "right")

#Solarized light
base.plot + theme_solarized() + scale_colour_solarized("blue")

#Excel 2003
base.plot + theme_excel() + scale_colour_excel()

#Tableau
base.plot + theme_igray() + scale_colour_tableau()

#Colour blind scales
base.plot + scale_colour_colorblind()

#Tufte
base.plot + geom_rangeframe() + theme_tufte(base_family = "sans")


