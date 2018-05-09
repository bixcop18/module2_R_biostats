It is important that you practice your data manipulation skills with R. Please solve the exercises below without skipping any. You can use "standard R" as well as all the packages from the *tidyverse* galaxy.

--------

1. Using the "FEV dataset" freshly imported from the file `Datasets/fev_dataset.txt`, calculate the statistical summary of all the heigths. What is the 10% quantile of that distribution? How would you explain what that value is, using your own words? What is the value of the 90% quantile of all heigths? 

2. Using the same dataset, draw boxplots representing the distribution of heights for all the ages between 6 and 10 inclusive (one boxplot per age, all on the same plot).

3. On the same dataset, **add a column**  called `Gender2` being the translation the column `Gender` into character values "Boy" (when `Gender` contains 1) and "Girl" (when `Gender` contains 0).

### Trickier: a new dataset with SSR data 

The file `Datasets/ssr_data.xlsx` contains SSR (Simple Sequence Repeat) data pertaining to a tetraploid species (each nucleus has 4 copies of each chromosome, with variations in the genomic content, of course). There are 14 markers or loci named P1 to P16, and 62 samples named Y01 to Y62. The following questions all pertain to that same dataset.

4. After having a look at it using your favourite spreadsheet editor (e.g. LibreOffice or MS Excel), import the dataset with the appropriate command from Hadley Wickham's `readxl` package. Make sure you get rid of the empty row and empty columns that are present in the original file.

5. You can see that in the original .xlsx file, several columns bear the same name (e.g. "P1"). They pertain to the 4 alleles of the same marker. Using the appropriate string manipulation functions, rename these columns "automatically" so that e.g. the four columns corresponding to the marker P1 are named "P1_Allele1", "P1_Allele2", "P1_Allele3" and "P1_Allele4". And likewise for the other markers.

6. Using functions from the package `dplyr`, transform your dataset so that we get one allele observation per row. The final columns in your dataset must be: "Sample", "Marker", "Allele_number" and "Allele_length".  
