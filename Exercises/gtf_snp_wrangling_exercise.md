# Gene Transfer File (GTF) Manipulation.
You can use R for more than statistics. For instance you can perform simple to complex genomics analysis in R. In this exercise, you will further test your data wrangling skills in R using the dplyr (dataframe manipulation) and stringr (for string manipulation) to manipulate a gene transfer files (gtf) and SNPs files to answer some questions about genes on chromosome 1 of chicken.


A. A gtf file describes the gene features of a genome per chromosome. You are provided with a gtf of chicken chr1 `NC_006088.4`. Import the gft file into R using the appropriate read function and assign the file to a new variable. `Gtf files are tab-separated`. Group the gtf file by the gene id (GeneID). `You will have to extract the GeneID using stringr functions`. Use the grouped data to answer the following the questions.
1. How many genes are on this chromosome?
2. How many non-coding RNA (ncRNA) are on this chromosome?
3. How many genes are in the positive orientation?
4. Find the longest genes on the chromosome 1 of chicken.
5. What is the average length of all genes on the chromosome?
6. What is the number of exons per gene?
7. Find the average length of exons per gene.
8. Using the plot function, plot the gene density distribution of genes on chicken chromosome 1.


B. Pertille _et al._, uses a genotyping-by-sequencing approach to identify a set of novel SNPs in 462 chicken breeds. Using this dataset with the gtf file in question A, find 
1. The number of transitions SNP (A-G or C-T) 
2. The number of transversion SNP (A-T or G-C)
3. Ratio of transition to transversion mutation
4. Find the consequence of each snp i.e genic or non-genic.
