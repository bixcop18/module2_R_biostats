# Analysing senescence data

# We have an experiment with 4 blocks- each block is a cross in a gene of interest
# We hypothesize these genes affect wheat leaf and peduncle senescence
# For each block we have 4 genotypes- our biological question is for each block do the different genotypes senesce at different rates? i.e. do these genes affect senescence?

# 1) calculate the number of days from Heading.date to Flag.leaf.senescence.date for all plants # HINT: convert these columns into dates recognised by R

# 2) use ggplot2 to plot boxplots of the number of days from heading to flag leaf senescence (the values you calculated in #1). 
# Each boxplot should show one genotype, and different blocks should be split into different panels of the graph.
# You may need to convert the newly created days from heading to flag leaf senescence into a numerical column
# The genotypes should be in the order left to right: "Kronos WT", "WT WT", "hom WT", "WT hom", "hom hom"
# Colour the boxes for "Kronos WT" in white, and all other boxes in green
# Rotate the x-axis labels so they are at 45 degrees

# 3) use ggplot2 to plot violin plots for block "NAM2 block 4", split the different sublocks into separate panels, and make a separate violin plot for each genotype
# add lines showing the quantiles (25 %, 50% and 75 %) to the violin plots

# 4) calculate whether the genotypes "hom hom", "hom WT", "WT hom" and "WT WT" are statistically significantly 
# different from each other for days from heading to flag leaf senescence for each block separately.
# which blocks show a statistically significant difference?
# use a post-hoc test to show which genotypes are different from each other for the most significant block
# which genotypes are different from each other in this block according to the post-hoc test?
# does this make sense compared to the boxplot you plotted earlier?

# 5) BONUS: Is the number of days from heading to flag leaf senescence related to the number of days from heading to peduncle senescence? 
# extract the R-squared and p-value and add them as text to the graph
# Is this relationship different between different blocks? - print each graph to a separate pdf


# 1) calculate the number of days from Heading.date to Flag.leaf.senescence.date for all plants # HINT: convert these columns into dates recognised by R

setwd("C:\\Users\\borrillp\\Documents\\Rgraphics\\dataSets\\")
sen_data <- read.csv(file="senescence_data.csv")
head(sen_data)

# convert dates into date format recognised by R
sen_data$Heading <- as.Date(sen_data$Heading.date, "%d/%m/%Y")
sen_data$Flag.leaf.senescence <- as.Date(sen_data$Flag.leaf.senescence.date, "%d/%m/%Y")

head(sen_data)
sen_data$days.to.flag <- sen_data$Flag.leaf.senescence - sen_data$Heading
head(sen_data$days.to.flag)

# 2) use ggplot2 to plot boxplots of the number of days from heading to flag leaf senescence (the values you calculated in #1). 
# Each boxplot should show one genotype, and different blocks should be split into different panels of the graph.
# You may need to convert the newly created days from heading to flag leaf senescence into a numerical column
# The genotypes should be in the order left to right: "Kronos WT", "WT WT", "hom WT", "WT hom", "hom hom"
# Colour the boxes for "Kronos WT" in white, and all other boxes in green
# Rotate the x-axis labels so they are at 45 degrees

sen_data$days.to.flag <- as.numeric(sen_data$days.to.flag) # convert to numeric

library("ggplot2")
# change order of levels
levels(sen_data$Genotype)
sen_data$Genotype <- factor(sen_data$Genotype,
                            levels=c("Kronos WT", "hom hom", "hom WT","WT hom", "WT WT"))
levels(sen_data$Genotype) # check levels now correct

ggplot(sen_data, aes(x=Genotype, y=days.to.flag)) +
  geom_boxplot(aes(fill=Genotype)) +
  scale_fill_manual(values= # scale_fill_manual adjusts colours of boxplots
                      c("Kronos WT"="white",
                        "hom hom"="green",
                        "hom WT" = "green",
                        "WT hom" = "green",
                        "WT WT" = "green"))+
  facet_wrap(~block)+
  theme(axis.text.x=element_text(angle=45, vjust=0.4)) # change angle of x axis text and move it down a bit
 # you could set hjust =1

# 3) use ggplot2 to plot violin plots for block "NAM2 block 4", split the different sublocks into separate panels, and make a separate violin plot for each genotype
# add lines showing the quantiles (25 %, 50% and 75 %) to the violin plots

ggplot(subset(sen_data,block=="NAM2 block 4"), aes(x=Genotype, y=days.to.flag)) +
  geom_violin(aes(fill=Genotype), draw_quantiles = c(0.25, 0.5, 0.75)) + # use geom_violinplot and add quantiles using draw_quantiles
  scale_fill_manual(values= # scale_fill_manual adjusts colours of boxplots
                      c("Kronos WT"="white",
                        "hom hom"="green",
                        "hom WT" = "green",
                        "WT hom" = "green",
                        "WT WT" = "green"))+
  facet_wrap(~subblock)+
  theme(axis.text.x=element_text(angle=45,hjust=1)) # change angle of x axis text and move it down a bit


# 4) calculate whether the genotypes "hom hom", "hom WT", "WT hom" and "WT WT" are statistically significantly 
# different from each other for days from heading to flag leaf senescence for each block separately.
# which blocks show a statistically significant difference?
# use a post-hoc test to show which genotypes are different from each other for the most significant block
# which genotypes are different from each other in this block according to the post-hoc test?
# does this make sense compared to the boxplot you plotted earlier?


# first remove KronosWT
sen_data_no_Kronos <- sen_data[sen_data$Genotype!="Kronos WT",]
head(sen_data_no_Kronos)

install.packages("broom")
library("broom")
library("tidyr")
library("dplyr")
Genotype <- "NAC1" # set genotype as an example
aov(lm(days.to.flag ~ Genotype, data = sen_data_no_Kronos)) # anova on its own
tidy(aov(lm(days.to.flag ~ Genotype, data = sen_data_no_Kronos)))

stat_result <- sen_data_no_Kronos %>%
  group_by(block) %>% 
  do(tidy(aov(lm(days.to.flag ~ Genotype, data = .)))) %>%
  filter(term=="Genotype")

as.data.frame(stat_result)
(stat_result$p.value)

# illegal for loop method:
for (block in unique(sen_data$block)) {

  sel_data <- sen_data[sen_data$block ==block,]
linear.model <- lm(days.to.flag ~ Genotype, data=sel_data[sel_data$Genotype == "WT WT" |
                                                          sel_data$Genotype == "WT hom" | 
                                                          sel_data$Genotype == "hom WT" | 
                                                          sel_data$Genotype == "hom hom",])
print(block)
 print(summary(aov(linear.model)))
}


#now tukey HSD post hoc test for NAM2 block 5
block <- "NAM2 block 5"
sel_data <- sen_data[sen_data$block ==block,] # select block 5 data
linear.model <- lm(days.to.flag ~ Genotype, data=sel_data[sel_data$Genotype == "WT WT" |
                                                            sel_data$Genotype == "WT hom" | 
                                                            sel_data$Genotype == "hom WT" | 
                                                            sel_data$Genotype == "hom hom",])
print(block)
print(summary(aov(linear.model)))
TukeyHSD(aov(linear.model)) # run a tukey HSD test on the anova result

# p<0.05 for hom WT vs hom hom, WT hom vs hom WT, WT WT vs hom WT
# non significant for WT hom vs hom hom, WT WT vs hom hom and WT WT vs WT hom


# 5) BONUS: Is the number of days from heading to flag leaf senescence related to the number of days from heading to peduncle senescence? 
# extract the R-squared and p-value and add them as text to the graph
# Is this relationship different between different blocks? - print each graph to a separate pdf
sen_data$Peduncle.senescence <- as.Date(sen_data$Peduncle.senescence.date, "%d/%m/%Y")
sen_data$days.to.peduncle <- as.numeric(sen_data$Peduncle.senescence - sen_data$Heading) # calculate the number of days from heading to peduncle senescence and save as numerical variable

head(sen_data)
# make a linear model relating days to flag with days to peduncle senescence
sen_model <- lm(days.to.peduncle ~ days.to.flag, data=sen_data)
summary(sen_model) # look at the summary

tidy(anova(sen_model)) # could use broom package to get tidy output from anova
anova(sen_model)$'Pr(>F)'[1]

summary(sen_model)$r.squared
rsq <- summary(sen_model)$r.squared # save the rsquared as an object
pval <- anova(sen_model)$'Pr(>F)'[1] # save the pvalue as an object
rsq
pval

ggplot(sen_data, aes(x=days.to.flag, y=days.to.peduncle)) +
  geom_point() +
  geom_smooth(method="lm",se=F) + # fit line and remove standard error
  annotate("text",x=30, y=70, # add text at position x=30, y=70
           label=paste0("rsquared=",round(rsq,2), " p-value=",round(pval,2))) # paste together the text rsquared with the value for rsq, text for p-value and the value for pval


# now do it for each block separately, I will use a for loop
# make a linear model relating days to flag with days to peduncle senescence

for (block in unique(sen_data$block)) {
  sel_data <- sen_data[sen_data$block == block,] # select the  block
sen_model <- lm(days.to.peduncle ~ days.to.flag, data=sel_data)
summary(sen_model) # look at the summary

rsq <- summary(sen_model)$r.squared # save the rsquared as an object
pval <- anova(sen_model)$'Pr(>F)'[1] # save the pvalue as an object
rsq
pval

pdf(file=paste0(block,"linearmodel.pdf")) # write to pdf
myplot <- ggplot(sel_data, aes(x=days.to.flag, y=days.to.peduncle)) +
  geom_point() +
  geom_smooth(method="lm",se=F) +
  annotate("text",x=0.5*max(sel_data$days.to.flag), y=0.99*max(sel_data$days.to.peduncle), # add text at position x and y (they are a proportion of the maximum for that axis)
           label=paste0("rsquared=",round(rsq,2), " p-value=",round(pval,2))) # paste together the text rsquared with the value for rsq, text for p-value and the value for pval
print(myplot) # print the plot into the pdf (otherwise it won't print in a loop)
dev.off()
}

# NAC1 has a weaker relationship (r2 = 0.2) compared to the other blocks but it is still highly significant