install.packages("ggplot2")

library(ggplot2)

? diamonds

ggplot(diamonds) + aes(carat, price) + geom_point(alpha = 0.5)

