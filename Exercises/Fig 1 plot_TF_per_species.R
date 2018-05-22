# Aim is to plot graph of wheat (high conf) vs barley vs rice TF families
# Philippa Borrill 03-05-2017

setwd("C:\\Users\\borrillp\\Documents\\Travel_May2018\\ggplot2\\")

data <- read.csv("Fig1 Data_for_figure_wheat_barley_rice_numbers.csv")
head(data)
dim(data)

#plot graph just of wheat
library(ggplot2)
ggplot(data=data, aes(x=Subfamily, y=Wheat)) +
  geom_bar(stat="identity") +
  coord_flip() + # flip the x and y axes
  scale_x_discrete(limits = rev(levels(as.factor(data$Subfamily)))) #reverse the order of the labels for the Subfamily axis

#facet plot wheat, barley, rice
library(tidyr)
library(dplyr)
head(data)

melted_data <- data %>%
  gather(key= species,value= TF, 2:4) 

#OR
melted_data <- data %>%
  gather(key= species,value= TF, Wheat, Barley, Rice) # it is good practise to write the column names and then later when you come back you will know which columns you chose

head(melted_data)
tail(melted_data)

colnames(melted_data) <- c("Subfamily", "Species", "Number")
head(melted_data)

ggplot(data=melted_data, aes(x=Subfamily, y=Number)) + 
  geom_bar(stat="identity") + # plot the actual values (no statistical transformation)
  facet_grid(~ Species) +  # separate panel per species
  coord_flip()  # add flip coordinates to make it vertical

ggplot(data=melted_data, aes(x=Subfamily, y=Number)) + 
  geom_bar(stat="identity") + 
  facet_grid(~ Species) + 
  coord_flip() +
scale_x_discrete(limits = rev(levels(as.factor(data$Subfamily)))) # reorder factors within scale_x_disrete

#edit the theme
ggplot(data=melted_data, aes(x=Subfamily, y=Number)) + 
  geom_bar(stat="identity") + 
  facet_grid(~ Species) + 
  coord_flip() +
  scale_x_discrete(limits = rev(levels(as.factor(data$Subfamily)))) +# reorder factors within scale_x_disrete
  theme_minimal() +  # use minimal theme
  theme(axis.line= element_line(color="black")) # add black axis 


levels(melted_data$Species) # we want to order as wheat, barley then rice and rename as A, B, C
melted_data$Species <- factor(melted_data$Species,
                              levels=c("Wheat","Barley","Rice"),
                              labels=c("A","B","C"))

pdf(file="TF_graph.pdf", width=10, height=12) # set width and height
ggplot(data=melted_data, aes(x=Subfamily, y=Number)) + 
  geom_bar(stat="identity") + 
  facet_grid(~ Species) + 
  coord_flip() +
  scale_x_discrete(name="Family",limits = rev(levels(as.factor(data$Subfamily)))) +# reorder factors within scale_x_disrete
  scale_y_continuous(name="Number of genes")+ # rename axis
  theme_minimal() + 
  theme(axis.line= element_line(color="black")) + # add black axis 
  theme(strip.text = element_text(hjust=0.05))  # move A, B, C labels to left of each panel
dev.off()


# now add in columns of ratios of wheat/rice and wheat/barley

head(data)
data$wheatbarley <- data$Wheat/data$Barley #calculate ratio of wheat to barley
data$wheatrice <- data$Wheat/data$Rice # calculate ratio of wheat to rice
head(data)

data_ratio <- data[,c(1,5,6)] # just select ratio columns
head(data_ratio)


#facet plot wheat, barley, rice
#make data wide to long
melted_data <- data_ratio %>%
  gather( species, TF, 2:3) 
head(melted_data)
tail(melted_data)

colnames(melted_data) <- c("Subfamily", "Species", "Ratio")#rename to match rest of script
head(melted_data)

pdf(file="TF_per_species_ratio.pdf", width=4, height=12) # print to pdf
ggplot(data=melted_data, aes(x=Subfamily, y=Ratio, group=Species, color=Species)) + # need to add group to get the geom_line to plot correctly
  geom_point() +  # addd scatter points
  geom_line() + # add lines between scatter points
  coord_flip()  + # swap x and y axis
scale_y_continuous(limits = c(0, 10), breaks=c(0,2,4,6,8,10))+ #set breaks on ratio axis
scale_x_discrete(name="Family",limits = rev(levels(as.factor(data$Subfamily)))) +#reorder names of subfamily
theme_minimal() +  #set theme
  theme(axis.line= element_line(color="black")) + #add axis line
  geom_abline(intercept = 3, slope = 0) + # add line at ratio=3
  theme(legend.position ="none")# add in a line at x =3
dev.off() # close the pdf file


