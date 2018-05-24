# Plot gene expression comparisons between nullitetra lines and WT

# Philippa Borrill 
# 25.6.15

setwd("C:\\Users\\borrillp\\Documents\\Rgraphics\\dataSets\\")

tpm.data<-read.table("heatmap_data.txt",sep="\t",header=T)  
tpm.data[1:5,1:5]


#install.packages("RColorBrewer")
#install.packages("gplots")
library(RColorBrewer)
library(gplots)

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
# gets rid of ~2,500 genes


################
colnames(tpm.data)
# for proper file with merged reps for WT
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
### NB to swap between 1A, 1B and 1D just replace all 1A with 1B or 1D

# plot gene expression for genes on chromosome 1 in group1 nullitetras + euploid

# select only genes on chrom 1A and in nullichrom1_shoots

chrom1A_genes_in_nulli_shoot_chrom1 <- as.matrix(nulli_tetra_shoots_chrom1[(grep("Traes_1A[L|S]_*",row.names(nulli_tetra_shoots_chrom1), perl = TRUE)),])
head(chrom1A_genes_in_nulli_shoot_chrom1)
tail(chrom1A_genes_in_nulli_shoot_chrom1)

# select only genes on chrom 1B and in nullichrom1_shoots

chrom1B_genes_in_nulli_shoot_chrom1 <- as.matrix(nulli_tetra_shoots_chrom1[(grep("Traes_1B[L|S]_*",row.names(nulli_tetra_shoots_chrom1), perl = TRUE)),])
head(chrom1B_genes_in_nulli_shoot_chrom1)
tail(chrom1B_genes_in_nulli_shoot_chrom1)

# select only genes on chrom 1Dand in nullichrom1_shoots

chrom1D_genes_in_nulli_shoot_chrom1 <- as.matrix(nulli_tetra_shoots_chrom1[(grep("Traes_1D[L|S]_*",row.names(nulli_tetra_shoots_chrom1), perl = TRUE)),])
head(chrom1D_genes_in_nulli_shoot_chrom1)
tail(chrom1D_genes_in_nulli_shoot_chrom1)



# draw boxplot of these allgenes_exprWT_chrom1A_nulli_shoot_chrom1
jpeg("all_genes_exprWT_chrom1A_nulli_shoot_chrom1_boxplot.jpg", height=300, width=300)
par(mar=c(10,6,4,3)+0.1,mgp=c(4,1,0))
boxplot.matrix(chrom1A_genes_in_nulli_shoot_chrom1, las=2, ylim=c(0,10), ylab ="Expression TPM", main ="All expressed chrom1A genes
               in shoots")
dev.off()

# choose only the genes which are the top 100 most expr in WT
top100exprWT_chrom1A_genes_in_nulli_shoot_chrom1 <- head(chrom1A_genes_in_nulli_shoot_chrom1[order(chrom1A_genes_in_nulli_shoot_chrom1[,1],decreasing=TRUE),],100)

head(top100exprWT_chrom1A_genes_in_nulli_shoot_chrom1)
dim(top100exprWT_chrom1A_genes_in_nulli_shoot_chrom1)

# draw heatmap of these allgenes_exprWT_chrom1A_nulli_shoot_chrom1
jpeg(file="100_top_genes_exprWT_chrom1A_nulli_shoot_chrom1_heatmap.jpg", height=1000, width=1000)
par(mar=c(20,11,4,3)+0.1,mgp=c(6,1,0))

heatmap.2(top100exprWT_chrom1A_genes_in_nulli_shoot_chrom1, col=rev(heat.colors(75)), Rowv=FALSE, Colv=FALSE, dendrogram= "none", key=TRUE,
          keysize=0.5,trace="none",  density.info="none", scale="row",margins = c(15,10), main= "Top 100 expressed chrom1A genes in shoots")
dev.off()

