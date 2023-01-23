#load ggplot2 library
library(ggplot2)

## CO2 data set
?CO2

head(CO2)


#===================================================================================================
#Create a scatter plot showing the CO2 uptake by ambient CO2 concentrations. Should you use jitter or not?
ggplot(CO2) + aes(conc, uptake) + geom_point()

ggplot(CO2) + aes(conc, uptake) + geom_jitter()


#Add a dotted trend line using linear regression(“lm”) in your favourite colour. 
#Change the dots to sky blue large triangles.

ggplot(CO2) + aes(conc, uptake) + geom_jitter(shape = 17,color='#87ceeb') + geom_smooth(method = "lm", colour = "red")


#Encode the origin of the plant in the colour of the triangles. 
#Make sure you still have only one trend line.

ggplot(CO2) + aes(conc, uptake) + geom_jitter(aes(color = Type), shape = 17,size=3) + geom_smooth(method = "lm", colour = "deeppink1")

#Label the chart, axes and legend meaningfully
ggplot(CO2) + 
  aes(conc, uptake) + 
  geom_jitter(aes(color = Type), shape = 17,size=3) + 
  geom_smooth(method = "lm", colour = "deeppink1") +
  labs(x = "CO2 concentrations", y = "CO2 uptake",
     colour = "City MPG", shape = "Fuel type") 

#Use two trend lines (one for each origin). Colour plants from Quebec blue and plants from Mississippi red.
#Note : move ase(color = Type) from  geom_jitter(aes(color = Type), shape = 17,size=3) to  aes(conc, uptake,color = Type). 
#After that it will apply to both graphs.

ggplot(CO2) + 
  aes(conc, uptake,color = Type) + 
  geom_jitter(shape = 17,size=3) + 
  geom_smooth(method = "lm") +
  scale_colour_manual(values = c("steelblue3", "firebrick2")) +
  labs(title = "CO2 uptake",
       colour = "Origin",
       x = "ambient CO2 concentrations (mL/L)",
       y = "CO2 uptake rates (umol/m^2 sec)")


#Create the chart above for each Plant using facet_wrap().

ggplot(CO2) + 
  aes(conc, uptake,color = Type) + 
  geom_jitter(shape = 17,size=3) + 
  geom_smooth(method = "lm")  +  
  facet_wrap(vars(Plant))


ggplot(CO2) + aes(conc, uptake, colour = Type) +
  geom_jitter() +
  geom_smooth(method = "loess", formula = y ~ x) +
  scale_colour_manual(values = c("steelblue3", "firebrick2")) +
  labs(title = "CO2 uptake",
       colour = "Origin",
       x = "ambient CO2 concentrations (mL/L)",
       y = "CO2 uptake rates (umol/m^2 sec)") +
  facet_grid(Type ~ Treatment) +
  theme(legend.position = "none")



vore.labels <- c("Carnivore", "Herbivore", "Insectivore", "Omnivore")
names(vore.labels) <- c("carni", "herbi", "insecti", "omni")
msleep.noNA <- msleep[!is.na(msleep$vore),]
ggplot(msleep.noNA) + aes(sleep_total, bodywt) +
  geom_point(aes(colour = genus)) +
  geom_smooth(formula = y~x,
              method = "lm") +
  scale_y_log10() +
  labs(x = "Sleep total", y = "Body weight",
       title = "Sleep and body weight by food source") +
  facet_wrap(vars(vore), labeller = labeller(vore = vore.labels)) +
  theme(legend.position = "none")
