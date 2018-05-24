#install.packages(c("polysat","tidyr","dplyr","ape","readxl")) # to be done only once if you don't have the packages installed yet

library(polysat) # for the analysis of microsatellite data of any ploidy level
library(tidyr)   # for more data frame manipulation
library(dplyr)   # these two are very convenient for a number of data transformations
library(ape)     # to build the NJ tree
library(readxl)  # to read from Excel files
library(RColorBrewer) # for nice colours

rawdat = read.csv("../diploid_SSR_shuffled_data.csv", stringsAsFactors = F)
str(rawdat)
rawdat[rawdat==0] <- NA # also works on multidimensional objects

# we immediately change the column names so that allele names are more consistent: e.g. "P11.1" and "P11.2" for the two alleles of locus P11
colnames(rawdat)

colnames(rawdat) <- c('Landraces','pop', paste0("P", rep(c(1:2,4,6:13,15), each=2), '.', rep(1:2, n=12)))

# Problem: "P6.1" and "P6.2" are now the two alleles corresponding to the same locus. We will use tidyr to transform (reshape) our dataset

rawdat %>% gather(key = Locus, value = Length, -c(1,2)) %>% separate(col = Locus, into = c("Marker", "Allele")) %>% spread(key = Allele, value = Length, sep = ".") -> cleandat

# Last thing: we combine "Landraces" and "pop" into a single column:
cleandat %>% unite(Sample.Name, Landraces, pop, sep="_") -> cleandat

# we delete the rows with two NAs as their two alleles:
cleandat %>% filter(!(is.na(Allele.1) & is.na(Allele.2))) -> cleandat

# We put an -9 in Allele 1 where we have no observation at all (no Allele 1, no Allele 2):
cleandat$Allele.1[is.na(cleandat$Allele.1)] = -9

# Now we have finally reached the right input format for polysat. We write that tibble/data frame into a tab-delimited text file
write.table(x = cleandat, file = "false_banana_genemapper.txt", sep = "\t", quote = F, row.names = F)

# and we import the data into R/polysat:
x = read.GeneMapper('false_banana_genemapper.txt')
summary(x)

Description(x) <- "False banana (enset) SSR genotyping dataset (Fetta Negash)"
# now we update the info about the populations and the various Usatnts:
# First we need to give the populations as integers from 1 to 5, in agreement with the different names for the 5 populations (factor-like thing)
Samples(x) -> samples
index_underscore = regexpr('_', samples, fixed=T) # will yield a vector of indices
popnames = factor(substring(samples,index_underscore+1))
PopNames(x) <- levels(popnames)    # 5 names
PopInfo(x) <- as.integer(popnames) # integers from 1 to 5

Samples(x,populations = c("East Gurage",'Yem')) # to check
# adding the info about the nucleotide repeats (di- or tri-):
Loci(x)
#  "P1"  "P11" "P12" "P13" "P15" "P2"  "P4"  "P6"  "P7"  "P8"  "P9"  "P10"
# Usatnts(x) <- c(3,2,2,3,2,2,2,2,3,2,2,2)

#  "P1"  "P10" "P11" "P12" "P13" "P15" "P2"  "P4"  "P6"  "P7"  "P8"  "P9" 
Usatnts(x) <- c(3,2,2,2,3,2,2,2,2,3,2,2)

# to check:
Loci(x,usatnts = 3)

# Ploidy is constant, equal to 2:
Ploidies(x) <- 2


# sanity checking our dataset:
Samples(x)
Samples(x, populations = "East Gurage")
Loci(x,usatnts=3)
Loci(x,usatnts=2)
viewGenotypes(x, loci = "P2", samples = Samples(x, populations = "Yem"))

# Getting rid of the postfix indicating the population group:
Samples(x) <- substring(Samples(x), 1, index_underscore-1)

# GOOD TO GO! :)

alleleDiversity(x,alleles = F) # allele diversity at each loci, for each population
# West Gurage seems the most diverse population, followed by East Gurage

simpleFreq(x) -> allele_freqs # getting allele frequencies for each population and each marker
PIC(allele_freqs, bypop = T, overall = T) -> PIC_statistics

PIC_statistics
write.csv(PIC_statistics,file = "PIC_statistics.csv")
genotypeDiversity(x) -> shannon_genotype_diversity # uses Lynch distance by default, and calculates Shannon indices
write.csv(shannon_genotype_diversity,file = "genotype_diversity_Shannon.csv")

# calculate genetic distances between individuals using Lynch distance
distances = meandistance.matrix(x,distmetric = Lynch.distance)

pca <- cmdscale(distances, k=10, eig=T) # Principal Coordinates Analysis
plot(x=pca$points[,1],y=pca$points[,2],col=PopInfo(x),pch=16)

# build a Neighbour-Joining tree

# now we want to use the matrix to get a tree built with NJ
mytree = nj(distances)
identical(mytree$tip.label,Samples(x)) # ok, same order

mypalette = brewer.pal(n=5, "Set1")

# tweaking the popnames so that we can use shorter names to plot in the tree
levels(popnames)
levels(popnames) <- c("EG","RV", "WG", "WT","YM")
distances_with_shortnames = distances
dimnames(distances_with_shortnames) <- list(as.character(popnames),as.character(popnames))
mytree = nj(distances_with_shortnames)
pdf("complete_NJ_tree_vertical.pdf", width=6,height=10)
plot.phylo(mytree, type="phylogram", cex = 0.8, tip.color = mypalette[PopInfo(x)]) # y.lim = c(2,50) # would trim the tree
axisPhylo()
legend("topright", cex=0.8, legend = PopNames(x), text.col = mypalette[1:length(PopNames(x))], bty="n")
dev.off()

# a horizontal tree now
pdf("complete_NJ_tree_horizontal.pdf", width=10,height=6)
plot.phylo(mytree, type="phylogram", cex = 0.8, tip.color = mypalette[PopInfo(x)],direction='downwards') # y.lim = c(2,50) # would trim the tree
#add.scale.bar()
axisPhylo(side=2)
legend("bottomleft", cex=0.8, legend = PopNames(x), text.col = mypalette[1:length(PopNames(x))], bty="n")
dev.off()




# PCA and phylogenetic tree do not show a clear clustering according that would be in agreement with the different populations
