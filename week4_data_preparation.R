install.packages("tidyverse")


library(tidyverse)

#===================================================================================================
#Loading data from CSV files
chickens <- read_csv("./R_workspace/chickens.csv")

head(chickens)


chickens

#spec() to show the (guessed) column specification
spec(chickens)

#to create a more explicit readr call that expresses the desired column types
chickens <- read_csv(
  readr_example("chickens.csv"),
  col_types = cols(
    chicken = col_character(),
    sex = col_factor(levels = c("rooster", "hen")),
    eggs_laid = col_integer(),
    motto = col_character()
  )
)
chickens

#===================================================================================================
#Loading data from Excel files
library(readxl)

people <- read_excel("./R_workspace/people.xlsx")
people

#Excel files often have multiple sheets, and data doesn’t always start in the first row. 
#We can use the sheet and range parameters of read_excel() to specify exactly what we want to import
people <- read_excel("./R_workspace/people.xlsx", sheet= 2, range = "A5:F15")
people

#Import the data in the file incidents.xlsx
incidents <- read_excel("./R_workspace/incidents.xlsx", sheet= 2, range = "B4:N30")
incidents

#===================================================================================================

table1

table2

table3

#There are three interrelated rules which make a dataset tidy:
#1. Each variable must have its own column. 
#2. Each observation must have its own row. 
#3. Each value must have its own cell.

#===================================================================================================
#Pivoting

#problem : A common problem of datasets is that either variables are spread across multiple columns, or an observation
# is spread across multiple rows.
  
#Solution:  To fix these problems, you’ll need the two most important functions in tidyr: 
#1. pivot_longer() 
#2. pivot_wider(): it is use when an observation is scattered across multiple rows.

table4a

table4a %>%  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

table2 %>% head()

table2 %>%  pivot_wider(names_from = type, values_from = count)

#===================================================================================================
#Data transformation

#dplyr provides five key functions to manipulate data:
#1) filter(): Pick observations by their values. 
#2) arrange(): Reorder the rows . 
#3) select(): Pick variables by their names . 
#4) mutate(): Create new variables with functions of existing variables. 
#5) summarise(): Collapse many values down to a single summary.

#These can all be used in conjunction with group_by() which changes the scope of each function from operating on the entire dataset to operating on it group-by-group.


install.packages("nycflights13")
library(nycflights13)


flights

#To use filtering effectively
#R provides the standard suite: >, >=, <, <=, != (not equal), and == (equal)
filter(flights, month == 1, day == 1)

#Boolean operators: & is “and”, | is “or”, and ! is “not”.
filter(flights, month == 11 | month == 12)

#%in% operator
filter(flights, month %in% c(11, 12))

#arrange() changes the order of rows, by sorting it:
arrange(flights, year, month, day)

#Use desc() to re-order by a column in descending order:
arrange(flights, desc(dep_delay))

#Select columns : allows you to rapidly zoom in on a useful subset using operations based on the names of the variables
select(flights, year, month, day)

#number of helper functions you can use within select
# • starts_with("abc"): matches names that begin with “abc”.
# • ends_with("xyz"): matches names that end with “xyz”.
# • contains("ijk"): matches names that contain “ijk”.
# • matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables
#   that contain repeated characters. You’ll learn more about regular expressions in strings.
# • num_range("x", 1:3): matches x1, x2 and x3.

rename(flights, tail_num = tailnum)

#Add new variables with mutate()

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

#If you only want to keep the new variables, use transmute():
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

#Grouped summaries with summarise()
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

## `summarise()` has grouped output by 'year', 'month'. You can override using the
## `.groups` argument.
flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))


delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")
ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

