# Gene Transfer File (GTF) Manipulation.
You can use R for more than statistics. For instance you can perform simple to complex genomics analysis in R. In this exercise, you will further test your data wrangling skills in R using the dplyr (dataframe manipulation) and stringr (for string manipulation) to manipulate a gene transfer file (gtf) and a SNP file to answer some questions about genes on chromosome 1 of chicken.


A. A gtf file describes the gene features of a genome per chromosome. You are provided with a gtf of chicken chr1 `NC_006088.4`. Import the gft file into R using the appropriate read function and assign the file to a new variable. `Gtf files are tab-separated`. 
1. Rename the columns of your gtf to contain the header of a standard gtf file: `seqname`, `source`, `feature`, `start`, `end`, `score`, `strand`, `frame`, `atrribute`, respectively.
2. Group the gtf file by the gene id (GeneID). `You will have to extract the GeneID from atribute column using stringr functions`.
3. How many genes are on this chromosome?
4. How many non-coding RNA (ncRNA) are on this chromosome?
5. How many genes are in the positive orientation?
6. Find the longest genes on chromosome 1 of chicken.
7. What is the average length of all genes on this chromosome?
8. What is the number of exons per gene?
9. Find the average length of exons per gene.
10. Using the plot function in R, plot the gene density distribution of genes on chicken chromosome 1.


B. Pertille _et al._, used a genotyping-by-sequencing approach to identify a set of novel SNPs (~18000) in 462 chicken breeds. Using this dataset with the gtf file in question A, find 
1. The number of transitions SNP (A-G or C-T).
2. The number of transversion SNP (A-T or G-C).
3. The ratio of transition to transversion mutations.
4. The consequence of each snp i.e genic (within genes) or non-genic (outside gene).
