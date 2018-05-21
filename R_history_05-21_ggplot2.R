## ggplot2 examples

#using data from 
#https://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html#exercise_i

setwd("C:\\Users\\borrillp\\Documents\\Rgraphics\\")

##   Let's look at housing prices.
housing <- read.csv("dataSets/landdata-states.csv")
head(housing[1:5])

hist(housing$Home.Value) # base R plot a histogram

##   `ggplot2' histogram example:

library(ggplot2)
ggplot(data=housing, aes(x = Home.Value)) + # set the data to use, x and y values in aes
  geom_histogram(col="green", fill="blue") # set fixed parameters in geom_histogram

head(housing)

## now want to plot a subset of the data as scatter plot
# we can use the subset function directly within the ggplot call:
ggplot(subset(housing, State %in% c("MA", "TX")),  # select two states MA and TX
       aes(x=Date,
           y=Home.Value,
           color=State))+ # colour the graph by the State
  geom_point()  # add the points to the graph

# now we want to specify the colours for the states
ggplot(subset(housing, State %in% c("MA", "TX")),  # select two states MA and TX
       aes(x=Date,
           y=Home.Value,
           color=State))+ # colour the graph by the State
  geom_point() + # add the points to the graph
  scale_colour_manual(values=c("green","black")) # by default the first state alphabetically will be green

# we now to want to plot TX as green and MA as black:
ggplot(subset(housing, State %in% c("MA", "TX")),  # select two states MA and TX
       aes(x=Date,
           y=Home.Value,
           color=State))+ # colour the graph by the State
  geom_point() + # add the points to the graph
  scale_colour_manual(values=c(TX ="green",MA="black")) # this changes the colours
# NB you can put the names of the states in directly without quotes in ggplot calls

# using log scales

hp2001Q1 <- subset(housing, Date == 2001.25)  # select a subset of data
head(hp2001Q1)
ggplot(hp2001Q1, # data to use
       aes(y = Structure.Cost, x = Land.Value)) +  # set the x and y axis
  geom_point() # plot the scatterplot

# now plot with log scale on x axis
ggplot(hp2001Q1,
       aes(y = Structure.Cost, x = log(Land.Value))) +  # simply log the x data directly
  geom_point()

# plotting with log scale on x axis using a new layer scale_x_log10()
ggplot(hp2001Q1,
       aes(y = Structure.Cost, x = Land.Value)) +
  geom_point() +
  scale_x_log10()

## exercise 1
# read in the data
# this show information about the human development index and corruption perception index from around the world
dat <- read.csv("dataSets/EconomistData.csv")
head(dat)

#Create a scatter plot with CPI on the x axis and HDI on the y axis.
ggplot(dat, aes(x = CPI, y = HDI)) + geom_point()

#Color the points blue.
ggplot(dat, aes(x = CPI, y = HDI)) + geom_point(col="blue")

#Map the color of the the points to Region.
ggplot(dat, aes(x = CPI, y = HDI, col=Region)) + geom_point() # nb Region goes inside the aes() because we are mapping the Region to the colour of the points

#Make the points bigger by setting size to 2
ggplot(dat, aes(x = CPI, y = HDI, col=Region)) + geom_point(size=2)

#Map the size of the points to HDI.Rank
ggplot(dat, aes(x = CPI, y = HDI, size = HDI.Rank, col=Region)) + geom_point()


#exercise 2
#Re-create a scatter plot with CPI on the x axis and HDI on the y axis (as you did in the previous exercise).

ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point()

#Overlay a smoothing line on top of the scatter plot using geom_smooth.
ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point() +
  geom_smooth()

#Overlay a smoothing line on top of the scatter plot using geom_smooth, but use a linear model for the predictions. Hint: see ?stat_smooth.
ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point() +
  geom_smooth(method = "lm")

#Overlay a smoothing line on top of the scatter plot using geom_line. Hint: change the statistical transformation.
ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point() +
  geom_line(stat="identity") # if we use the default stat ="identity" the geom_line connects directly between the points which isn't what we want

# we want to make a fitted line, rather than actually following the data points so we need to use stat="smooth" 
ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point() +
  geom_line(stat = "smooth", method = "loess")

#BONUS: Overlay a smoothing line on top of the scatter plot using the default loess method, but make it less smooth. Hint: see ?loess.
ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point() +
  geom_smooth() # this is how it looks by default

ggplot(dat, aes(x = CPI, y = HDI)) +
  geom_point() +
  geom_smooth(span = .4) # we can alter the span parameter to make the curve less smooth


## scales and themes
# now let's try changing the theme
# we have a basic graph of the home price index vs state
ggplot(housing,
       aes(x = State,
           y = Home.Price.Index)) +
  geom_point(aes(color = Date)) # we colour the points by the date the house was sold
# the problem is that lots of the points on the scatter plot are directly on top of each other so we can't see them well

# let's make the points transparent
ggplot(housing,
       aes(x = State,
           y = Home.Price.Index)) +
  geom_point(aes(color = Date),
             alpha = 0.5, # sets transparency
             size = 1.5) # change size of points

# the transparency helps a bit but ggplot also has a nice "jitter" function which moves the points a bit apart from each other
ggplot(housing,
       aes(x = State,
           y = Home.Price.Index)) +
  geom_point(aes(color = Date),
             alpha = 0.5, # still using transparency
             size = 1.5,
             position = position_jitter(width = 0.25, height = 0)) # add a "jitter" so points overlap less

# now we want to move the legend to the top and change the x axis text size
# we do this through the theme
# theme affects parts of the graph that aren't the data themselves but are the surroundings/background
ggplot(housing,
       aes(x = State,
           y = Home.Price.Index)) +
  geom_point(aes(color = Date),
             alpha = 0.5, # still using transparency
             size = 1.5,
    position = position_jitter(width = 0.25, height = 0)) +  
  theme(legend.position="top", # move the legend
        axis.text=element_text(size = 6)) # set the text size

# we can also edit the scale used for the colour of the dots
# we want to set the breaks to specific years, and change how the year numbers are displayed
ggplot(housing,
       aes(x = State,
           y = Home.Price.Index)) +
  geom_point(aes(color = Date),
             alpha = 0.5, # still using transparency
             size = 1.5,
             position = position_jitter(width = 0.25, height = 0)) +  
  theme(legend.position="top", # move the legend
        axis.text=element_text(size = 6)) + # set the text size 
  scale_color_continuous(name="", # scale_color_continuous is used because we have a coloured scale, and it is continuous (rather than categorical) data
                         breaks = c(1976, 1994, 2013), # these are the breaks we want
                         labels = c("'76", "'94", "'13")) + # labels for the new breaks
  scale_x_discrete(name="State Abbreviation")  # we can also add a new x axis label


## exercise 3

# plot CPI against HDI, coloured by region as a scatterplot
ggplot(dat, aes(x = CPI, y = HDI, col=Region)) +
  geom_point()

# modify axis titles
ggplot(dat, aes(x = CPI, y = HDI, col=Region)) +
  geom_point() + 
  scale_x_continuous(name="Corruption perception index") # the xaxis is continuous so we need to use scale_x_continuous


ggplot(dat, aes(x = CPI, y = HDI, col=Region)) +
  geom_point() + 
  scale_x_continuous(name="Corruption perception index") +
  scale_y_continuous(name="Human development index") # similarly the y axis is continuous so we need to use scale_y_continuous


ggplot(dat, aes(x = CPI, y = HDI, col=Region)) +
  geom_point() + 
  scale_x_continuous(name="Corruption perception index") +
  scale_y_continuous(name="Human development index") +
  scale_color_discrete(name="Region of the world")  # we can also re-title the legend, but this time we have discrete colour scale, so we use scale_color_discrete       

# now change colours for regions
ggplot(dat, aes(x = CPI, y = HDI, color = Region)) +
  geom_point() +
  scale_x_continuous(name = "Corruption Perception Index") +
  scale_y_continuous(name = "Human Development Index") +
  scale_color_manual(name = "Region of the world", # we have to use scale_color_manual because we want to manually change the color scale
                     values = c("red",
                                "pink",
                                "blue",
                                "green",
                                "orange",
                                "black"))

# we can change the colours also to html codes. The website http://colorbrewer2.org/ is very nice to find colour schemes
# it also allows you to find colour blind friendly colours which is important for publications
ggplot(dat, aes(x = CPI, y = HDI, color = Region)) +
  geom_point() +
  scale_x_continuous(name = "Corruption Perception Index") +
  scale_y_continuous(name = "Human Development Index") +
  scale_color_manual(name = "Region of the world", # we have to use scale_color_manual because we want to manually change the color scale
                     values = c("#7fc97f",
                                "#beaed4",
                                "#fdc086",
                                "#ffff99",
                                "#386cb0",
                                "#f0027f"))

# now we want to specific which region has which colour
ggplot(dat, aes(x = CPI, y = HDI, color = Region)) +
  geom_point() +
  scale_x_continuous(name = "Corruption Perception Index") +
  scale_y_continuous(name = "Human Development Index") +
  scale_color_manual(name = "Region of the world",
                     values = c(MENA="red", # we assign each region a colour
                                SSA="pink",
                                "East EU Cemt Asia"="blue",
                                'Asia Pacific'="green",
                                Americas="orange",
                                'EU W. Europe'="black"))

# if you're worried you might misspell the regions we can print them out as characters, and then copy and paste them into our previous command:
as.character(unique(dat$Region))


# we can use facet wrap to plot our graph separately for the six regions
ggplot(dat, aes(x = CPI, y = HDI, color = Region)) +
  geom_point() +
  scale_x_continuous(name = "Corruption Perception Index") +
  scale_y_continuous(name = "Human Development Index") +
  scale_color_manual(name = "Region of the world",
                     values = c(MENA="red",
                                SSA="pink",
                                "East EU Cemt Asia"="blue",
                                'Asia Pacific'="green",
                                Americas="orange",
                                'EU W. Europe'="black")) +
  facet_wrap(~Region) 

## now we want to plot the average Home.Value and Land.Value per date
head(housing)

# we need to calculate the mean value per year. 

# we can use aggregate from base R:
housing.byyear.aggregate <- aggregate(cbind(Home.Value, Land.Value) ~ Date, data = housing, mean)
head(housing.byyear.aggregate)

# or use dplyr
library(tidyr)
library(dplyr)
housing.byyear <- housing %>%
  group_by(Date) %>% # group_by date
  summarise(Home.Value = mean(Home.Value), # calculate mean of Home.Value
            Land.Value = mean(Land.Value)) # calculate mean of Land.Value
 
head(housing.byyear) 
  

# we  need to convert this wide format table to a long format table 
# ggplot needs long format tables, because we need to have a column telling it whether the value is for Land.Value or Home.value


# we can use gather in tidyr
home.land.byyear <- gather(housing.byyear,
                           value = "value",
                           key = "type",
                           Home.Value, Land.Value)
head(home.land.byyear)
tail(home.land.byyear)

dim(housing.byyear) # dim of wide format
dim(home.land.byyear) # dim of long format

# now we can make our graph
ggplot(home.land.byyear,
       aes(x=Date,
           y=value,
           color=type)) +
  geom_line()

# we can see here that each Date has a row for Land.value and a row for Home.value (i.e. it is long format)
head(home.land.byyear[order(home.land.byyear$Date),])


## now we're doing the challening figure from the economist
# make economist figure
dat <- read.csv("dataSets/EconomistData.csv")

# start with a plot of HDI against CPI, coloured by region (same as before):
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region))

# now add in geom_smooth for a linear model, with the formula y~x + log(x)
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region)) +
  geom_smooth(mapping = aes(linetype = "r2"), # add the line as a new part of the legend
              method = "lm", # the fitting model should be a linear model
              formula = y ~x + log(x), # this is the formula for the linear model
              se=FALSE, # turn off the confidence interval
              color="red") # colour the line red

#change the point shape to open circle
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4,stroke=1.25) + # here we edit the shape to 1 (open circle), make the points bigger with size, and make the stroke thickness bigger for the open circles
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red")


# change the order and labels of Region to:
#(OECD, Americas, Asia & Oceania, Central & Eastern Europe,
#Middle East & north Africa, Sub-Saharan Africa)

# for this we need to change the levels of the original dataset:
levels(dat$Region) # these are the current levels, these are in alphabetical order by default

# we can change the order of the levels by using factor
dat$Region <- factor(dat$Region, # re-factor the levels
                     levels = c("EU W. Europe", # this list is the order we want
                                "Americas",
                                "Asia Pacific",
                                "East EU Cemt Asia",
                                "MENA",
                                "SSA"))
levels(dat$Region) # the order has been updated

# plot the graph using the exact same code as before
# but since we changed the levels of Region the order of the legend will also change
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4,stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red")

# we actually want to also edit the names of each region
# we can do this through factor again, but using the labels parameter also
dat$Region <- factor(dat$Region,
                     levels = c("EU W. Europe",
                                "Americas",
                                "Asia Pacific",
                                "East EU Cemt Asia",
                                "MENA",
                                "SSA"),
                     labels = c("OECD", # these are the new labels, they must be in the same order as the levels listed above, otherwise the names will get mixed up!
                                "Americas",
                                "Asia &\nOceania", # the \n indicates a new line should be put in
                                "Central &\nEastern Europe",
                                "Middle East &\nnorth Africa",
                                "Sub-Saharan\nAfrica"))

head(dat$Region) # we can see the names of Region have changed

# again plot the graph with the exact same code as above but we can see we have the new region names because we edited the dataframe
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4, stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red") +theme(legend.position="top")

#label select points

# if we label all points we get a mess:
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4, stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red") +theme(legend.position="top") +
  geom_text(aes(label = Country), # add labels to each point according to the Country column
            color = "gray20") # colour the points grey

# make a list of the selected countries to plot (we can't show them all)
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4, stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red") +theme(legend.position="top") +
  geom_text(aes(label = Country),
            color = "gray20",
            data = subset(dat, Country %in% pointsToLabel)) # subset which countries to show as labels using the list we made

# the text labels are still overlapping a bit, we can use a package ggrepel to fix this
install.packages("ggrepel")
library(ggrepel)
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4, stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red") +theme(legend.position="top") +
geom_text_repel(aes(label = Country), # we change geom_text to geom_text_repel because this can space the labels apart
                color = "gray20",
                data = subset(dat, Country %in% pointsToLabel),
                force = 10) # the force determines how far apart the labels should be


## let's use facet wrap to split the graph into the 6 regions:
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4, stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red")  +
  geom_text_repel(aes(label = Country),
                  color = "gray20",
                  data = subset(dat, Country %in% pointsToLabel),
                  force = 10) +
                  facet_wrap(~Region) # we split the graph into facets according to region

# now we want to change the theme (the overall appearance)
ggplot(dat, aes(x = CPI, y = HDI)) + 
  geom_point(aes(color = Region), shape=1, size=4, stroke=1.25) +
  geom_smooth(mapping = aes(linetype = "r2"),
              method = "lm",
              formula = y ~x + log(x),
              se=FALSE,
              color="red")  +
  geom_text_repel(aes(label = Country),
                  color = "gray20",
                  data = subset(dat, Country %in% pointsToLabel),
                  force = 10) +
  facet_wrap(~Region) +
  theme_minimal() + # add an overall minimal theme
  theme(legend.position="top")+ # we need the legend position to move after the theme_minimal, otherwise it gets over-ridden by the theme_minimal (which by default puts the legend at the right)
  theme(strip.background = element_rect(fill="blue"), # we can edit individual theme elements, like the strip background, it is a rectangle so we need to call it an element_rectangle before specifying the colour etc.
        strip.text = element_text(color = "white", size=10, face = "bold"), # similarly text is an element_text
        plot.background = element_blank())  # we can also set element_blank which makes that part of the plot blank
  
