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

