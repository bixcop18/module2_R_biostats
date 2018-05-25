#1) plot a heatmap for the bottom 100 expressed genes in euploid shoots on chr1A
# is the pattern similar to for the top 100 expressed genes?

setwd("C:\\Users\\borrillp\\Documents\\Rgraphics\\dataSets\\")

tpm.data<-read.table("heatmap_data.txt",sep="\t",header=T)  #read table 
tpm.data[1:5,1:5] # check data looksok


#install.packages("RColorBrewer")
#install.packages("gplots")
library(RColorBrewer)
library(gplots) 

# NB can also use gplots for venn diagrams
# make venn diagram: https://cran.r-project.org/web/packages/gplots/vignettes/venn.pdf

# get subsets of relevant data i.e. separate out the group 1 and group 5 nullitetras

head(tpm.data)
colnames(tpm.data)

# rename rownames as genes
rownames(tpm.data) <- tpm.data[,1]
tpm.data <- tpm.data[,-1]
head(rownames(tpm.data))
dim(tpm.data)

# get rid of any rows which have no gene expression
tpm.data <- tpm.data[rowSums(tpm.data) != 0,]
dim(tpm.data)
# gets rid of ~300 genes


################
colnames(tpm.data) # find the columns we want to select for each dataset (e.g chr1 shoots)

# select only nulli_tetra_shoots_5
nulli_tetra_shoots_chrom5 <- tpm.data[,c(1,9:14)]
head(nulli_tetra_shoots_chrom5)

# select only nulli_tetra_roots_5
nulli_tetra_roots_chrom5 <- tpm.data[,c(2,15:20)]
head(nulli_tetra_roots_chrom5)

# select only nulli_tetra_shoots_1
nulli_tetra_shoots_chrom1 <- tpm.data[,c(1,3:8)]
head(nulli_tetra_shoots_chrom1)

# select only nulli_tetra_roots_1
nulli_tetra_roots_chrom1 <- tpm.data[,c(2,21:26)]
head(nulli_tetra_roots_chrom1)
#########################

# plot gene expression for genes on chromosome 1 in group1 nullitetras + euploid

# select only genes on chrom 1A and in nullichrom1_shoots

# we use grep to select only rows with the name Traes_1A L or S, we also convert to a matrix (heatmap requires matrix not dataframe)
chrom1A_genes_in_nulli_shoot_chrom1 <- as.matrix(nulli_tetra_shoots_chrom1[(grep("Traes_1A[L|S]_*",row.names(nulli_tetra_shoots_chrom1))),])
head(chrom1A_genes_in_nulli_shoot_chrom1)
tail(chrom1A_genes_in_nulli_shoot_chrom1)


# choose only the genes which are the bottom 100 most expr in WT
# order the dataframe descending, choose the bottom 100 using tail
bottom100exprWT_chrom1A_genes_in_nulli_shoot_chrom1 <- tail(chrom1A_genes_in_nulli_shoot_chrom1[order(chrom1A_genes_in_nulli_shoot_chrom1[,1],decreasing=TRUE),],100)

head(bottom100exprWT_chrom1A_genes_in_nulli_shoot_chrom1)
dim(bottom100exprWT_chrom1A_genes_in_nulli_shoot_chrom1)

jpeg(file="100_bottom_genes_exprWT_chrom1A_nulli_shoot_chrom1_heatmap.jpg", height=1000, width=1000)
par(mar=c(20,11,4,3)+0.1,mgp=c(6,1,0))

heatmap.2(bottom100exprWT_chrom1A_genes_in_nulli_shoot_chrom1, 
          col=rev(heat.colors(75)), # reverse the order of the colours so they go from yellow (low) to red (high)
          Rowv=FALSE, # turn off clustering rows
          Colv=FALSE, # turn off clustering columns
          dendrogram= "none", # turn off dendrogram
          key=TRUE, # add key
          keysize=0.5, # make key smaller
          trace="none",  # turn off blue line showing expression level
          scale="row", # scales data for each row to be equal to the same sum
          margins = c(15,10), #set margin
          main= "Bottom 100 expressed chrom1A genes in shoots", # add title
          density.info="none") # get rid of blue line on legend
dev.off()

#2) plot a heatmap for both roots and shoots for chr1A, 
# use the top 100 expressed genes in euploid shoots
# add a dendrogram for the columns. You will need to make the columns re-order using colv
# which samples are more related?

# select nulli-tetra chrom 1
colnames(tpm.data) # check which columns to select
nulli_tetra_chrom1 <- tpm.data[,c(1,2,3:8,21:26)]
head(nulli_tetra_chrom1)


# plot gene expression for genes on chromosome 1 in group1 nullitetras + euploid

# select only genes on chrom 1A and in nullichrom1_shoots

#as before use grep to select Traes_1A genes, and convert data to matrix
chrom1A_genes_in_nulli_tetra_chrom1 <- as.matrix(nulli_tetra_chrom1[(grep("Traes_1A[L|S]_*",row.names(nulli_tetra_chrom1))),])
head(chrom1A_genes_in_nulli_tetra_chrom1)
tail(chrom1A_genes_in_nulli_tetra_chrom1)

# choose only the genes which are the top 100 most expr in WT
top100exprWT_chrom1A_genes <- head(chrom1A_genes_in_nulli_tetra_chrom1[order(chrom1A_genes_in_nulli_tetra_chrom1[,1],decreasing=TRUE),],100)

head(top100exprWT_chrom1A_genes)
dim(top100exprWT_chrom1A_genes)

jpeg(file="100_top_genes_exprWT_chrom1A_nulli_chrom1_heatmap.jpg", height=1000, width=1000)
par(mar=c(20,11,4,3)+0.1,mgp=c(6,1,0))

heatmap.2(top100exprWT_chrom1A_genes, 
          col=rev(heat.colors(75)), 
          Rowv=FALSE, # turn off clustering rows
          Colv=TRUE, # turn on clustering columns
          dendrogram= "none", # turn off dendrogram
          key=TRUE, # add key
          keysize=0.5, # make key smaller
          trace="none",  # turn off blue line showing expression level
          scale="row", # scales data for each row to be equal to the same sum
          margins = c(15,10), #set margin
          main= "Top 100 expressed chrom1A genes in shoots", # add title
          density.info="none") # get rid of blue line on legend
dev.off()


#3) CHALLENGE plot the heatmap from #2) using the "aheatmap" function in NMF
# can you add on an annotation column showing which samples are roots, and which are shoots?
# HINT: you will need to make an annotation dataframe and pass it to annCol
# http://nmf.r-forge.r-project.org/vignettes/heatmaps.pdf part 1.4 shows an example

library("NMF")
library("RColorBrewer") # load RColorBrewer which has nice colour palettes

# we use the same data as before in question #2)
head(top100exprWT_chrom1A_genes)


# make annotation dataframe
colnames(top100exprWT_chrom1A_genes) # check the column names to find out which column is which tissue
annotations <- data.frame(tissue=c("shoots","roots",rep("shoots",6),rep("roots",6))) # make a dataframe with a column saying which tissue for each sample
head(annotations)

aheatmap(top100exprWT_chrom1A_genes) # plot default heatmap

aheatmap(top100exprWT_chrom1A_genes, scale="row") # plot scaled by row (Z score scaling)
aheatmap(top100exprWT_chrom1A_genes, scale="r1") # plot scaled by row but normalised so sum of each row equals 1


aheatmap(top100exprWT_chrom1A_genes, scale="r1",
         annCol = annotations) # add annotations

head(annotations)
nrow(annotations)
annotations$random <- c(1:14) # add another column of annotations to our annotations dataframe
head(annotations)

aheatmap(top100exprWT_chrom1A_genes, scale="r1",
         annCol = annotations) # add annotations (which now has 2 columns)
aheatmap(top100exprWT_chrom1A_genes, scale="r1",
         annCol = annotations$tissue) # select only tissue annotation (i.e. one of the 2 columns)

# add row annotation
row_annot <- data.frame(random =c(1:100))
head(row_annot)
aheatmap(top100exprWT_chrom1A_genes, scale="r1",
         annCol = annotations$tissue,# select only tissue annotation for columns
         annRow = row_annot,# add annotation for rows
         Rowv = NA ) # turn off row dendrogram

# now want to specify colours for annotations for column
# Specify colors
tissue_colours = c("navy", "darkgreen") # specify the colours for tissue as a list
names(tissue_colours) = c("roots", "shoots") # name the colours in the list so R knows which colour belongs to which tissue
random_colours = c("yellow", "red") # set the colour scale for random from yellow to red
ann_colors = list(tissue = tissue_colours, random = random_colours) # make a list of of lists: the lists to combine are a named list in the case of tissue_colours, and a list for the numerical column "random") 


aheatmap(top100exprWT_chrom1A_genes, scale="r1",
         annCol = annotations,
         annColors = ann_colors)  # add in colour list to determine which colour the annotations should be

aheatmap(top100exprWT_chrom1A_genes, 
         scale="r1",annCol = annotations, 
         annColors = ann_colors,  # add in colour list to determine which colour the annotations should be
         color="YlGnBu") # use a colour palette from RColorBrewer to set the colour scale for the heatmap
