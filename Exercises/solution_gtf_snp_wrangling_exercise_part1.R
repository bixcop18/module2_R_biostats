#step 1: It is usually best to start by loading all the packages you will like to use downstream
library(tidyverse)

#step 2: Let's read the gtf file datainto a object named gtf with the read.table function with the seperator being a tab "\t" and no header (False) and to skip the first 3 rows (skip = 3) as "\t",
gtf <- read.table("ref_Gallus_gallus-5.0_top_level_chr1.gtf", header = F, skip = 3, stringsAsFactors = F, sep = "\t")

#step 3: we then rename the column of gtf to contain the header of a standard gtf file the 
colnames(gtf) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")


#step 4a:you can extract the gene id using the str_extract or str_replace function
#1. with str_extract, you specify the string and the pattern: e.g str_extract(string, pattern) 
gtf$geneid <- str_extract(gtf$attribute, "GeneID:[:digit:]+")
#This however still retains the "GeneID" label
#also, the pattern will not work for the first row feature (region) with doesnot have the "GeneID:[:digit:]+" pattern 

#step 4b: To correct this we can use str_replace as followss:str_replace(string, pattern, replacement)
#with string replace you can group patterns with (pattern1)(pattern2)(pattern..) and backreference this pattern with //1, //2, //x etc.
gtf$geneid <- str_replace(gtf$attribute, ".*GeneID:([:digit:]+).*", "\\1")

#Step 4c: Now, we can combine this with a conditional function that will process the region (whole chromosome) differently from the other rows. 
gtf$geneid <- ifelse(gtf$feature == "region", "chromosome1", str_replace(gtf$attribute, ".*GeneID:([:digit:]+).*", "\\1"))


##We can even do it all in one line 
#Step 5: We can now group the gtf data by the geneid column
gtf <- group_by(gtf, geneid)

#Note: We can even combine step 3 and step 4 in one line using piping, mutate and group_by operator/functions of dplyr functions
gtf %>% mutate(geneid = ifelse(feature == "region", "chromosome1", str_replace(attribute, ".*GeneID:([:digit:]+).*", "\\1"))) %>% group_by(geneid) -> gtf

#Now let's find the number of genes in the file
#step 6: We can simply perform logical statement to check if elements of the feature column match the string "gene"
#This will return a logical vector of the same lenght as the gtf$feature and this vector can be summed because True and False equates to 1 and 0 respectively
sum(gtf$feature == "gene")

#Step 7: To find the number fo genes on the positive strand, we simply include an addition logical test to the test in step 5
sum(gtf$strand == "+" & gtf$feature == "gene")
nrow(filter(gtf, feature == "gene" & strand == "+"))

