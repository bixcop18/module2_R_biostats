# Description
**Plot**: A manhattan plot is a scatter plot used to display data for a large number of sample where each point represents a sample. It is the standard plot used in many Genome Wide Association Studies (GWAS). In this exercise you are to prepare an atypical manhattan plot to present normalised coverage differences of reads obtained from a wild-type and a mutant wheat line mapped to the reference wheat genome. This will plot will highlight regions in these lines where there are large structural variations including deletions and insertions.

**Crop**: Wheat is an hexaploid with 3 different genomes `A, B and D genomes` each with 7 chromosomes. Due to the large size of each chromosome (> 500 Mb), the assembly for each chromosome is split into two unequal parts (part_1 and part_2). The whole chromosome co-ordinates of the part_2 assembly can be derived by adding the length of the part_1 chromosome to the part_2 co-ordinate.

**Dataset**: You are provided with two text files containing the read count for each 1 Mb bins of each chromosome for the wild-type and mutant. reads mapping to these bins. You are also provided with an excel file containing the length of the part_1 of each chromosome. You can use this to calculate the corresponding whole chromosome position for sites/bins located on the part_2 chromosome. 

## Exercise
You are to make a manhattan plot that present the normalised read coverage difference between wild-type and mutant across the whole genome
1. Read in the bed and index file into R
2. Derive the whole chromosome co-ordinates for each bin from the part chromosome co-ordinates into whole chromosome co-ordinate.
3. Derive the normalised read count for the wild-type and mutant lines. Normalised = read count in each bin /total number of reads in the sample.
4. Derive the normalised read count difference for each bin. i.e Wild-type – Mutant
5. Using ggplot functions, make a scatter plot of the normalised read coverage difference for each chromosome 
6. Make a scatter plot of the normalised read coverage difference for each genome
7. Make scatter plot of the normalised read coverage difference across the whole genome with each genome coloured differently and each chromosome labelled.
