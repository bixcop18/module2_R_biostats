It is important that you practice your data manipulation skills with R. Please solve the exercises below without skipping any. You can use "standard R" as well as all the packages from the *tidyverse* galaxy.

--------

1. Using the "FEV dataset" freshly imported from the file `Datasets/fev_dataset.txt`, calculate the statistical summary of all the heigths. What is the 10% quantile of that distribution? How would you explain what that value is, using your own words? What is the value of the 90% quantile of all heigths? 

2. Using the same dataset, draw boxplots representing the distribution of heights for all the ages between 6 and 10 inclusive (one boxplot per age, all on the same plot).

3. On the same dataset, **add a column**  called `Gender2` being the translation the column `Gender` into character values "Boy" (when `Gender` contains 1) and "Girl" (when `Gender` contains 0).

### Trickier: a new dataset with SSR data 

The file `Datasets/ssr_data.xlsx` contains SSR (Simple Sequence Repeat) data pertaining to a tetraploid species (each nucleus has 4 copies of each chromosome, with variations in the genomic content, of course). There are 14 markers or loci named P1 to P16, and 62 samples named Y01 to Y62. The following questions all pertain to that same dataset.

4. After having a look at it using your favourite spreadsheet editor (e.g. LibreOffice or MS Excel), import the dataset with the appropriate command from Hadley Wickham's `readxl` package. Make sure you get rid of the empty rows and empty columns that are present in the original file.

5. You can see that in the original .xlsx file, several columns bear the same name (e.g. "P1"). They pertain to the 4 alleles of the same marker. Using the appropriate string manipulation functions, rename these columns "automatically" so that e.g. the four columns corresponding to the marker P1 are named "P1_Allele1", "P1_Allele2", "P1_Allele3" and "P1_Allele4". And likewise for the other markers.

6. Using functions from the `tidyr` and `dplyr` packages (both members of the `tidyverse` collection), transform your dataset so that we get one allele observation per row. After the transformation, the resulting columns in your dataset must be: "Sample", "Marker", "Allele_number" and "Allele_length". If you're stuck for too long, skip this question and you will come back to it later on.

#### Measures of genetic diversity

7. There are zeroes in the dataset where less than 4 different alleles were seen for a given locus (a.k.a. marker) in a given sample. Replace all these `0` value with the pseudo-datum `NA` indicating missing values.

8. The most basic measure of genetic diversity for a marker is simply the number of distinct alleles observed for that marker. Calculate a table of genetic diversity per marker.

9. We will say that a sample is heterozygous for a given marker when at least two different alleles are seen in a marker. Calculate two sets of observed heterozygosity values (simple ratios of heterozygous alleles over all observed alleles):
 + per marker;
 + per sample.

10. I am not too happy with these binary measures of heterozygosity per sample and per marker: what if I want to consider that a marker with 4 different alleles seen is "more heterozygous" than a marker with only 2 different alleles? Re-run the question above with a new, linear measure of heterozygosity ranging from 0 (for a unique allele seen) to 1 (when 4 different alleles are seen).

11. The "polymorphism information content" (PIC) is a commonly used measure of the usefulness of a molecular marker. It is simply defined as a function of the observed frequencies of the various alleles corresponding to a marker. Read the following carefully: *for a given marker $P$ with $n$ alleles having observed frequencies $f_1$ to $f_n$ (the frequencies are all in $[0,1]$ and sum to $1$), the PIC value is defined as: $1 - \sum_{i=1}^n f_i^2$. Calculate the PIC value for all the 14 markers.
