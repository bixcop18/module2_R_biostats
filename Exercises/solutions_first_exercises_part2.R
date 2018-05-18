library(readxl)
library(tidyr)
library(dplyr)

setwd("/home/jbde/Trainings/Biostats_and_R_bixcop_github/module2_R_biostats/")

read_xlsx("Datasets/ssr_data.xlsx") -> ssr_dat
str(ssr_dat)
ssr_dat %>% select(-starts_with("X__")) -> tempdat

# Q5

markers = c(1:6,8:13,15:16)
colnames(tempdat) <- c("ID", paste0("P", rep(markers, each=4), "_Allele", 1:4))


# let's try and use gather()
tempdat %>% gather(key="Allele", value="Allele_length", 2:(4*length(markers)+1)) -> tempdat_tidy
# gather() uses the column names of columns 2 to 57 to populate the new column whose name is given to the argument "key". The argument "value" gives the name of the column that will receive all the values.
# gather() GATHERS the content of several columns into a single new one.

# We are going to use tidyr::separate() in order to make two columns out of the "Allele" one.
?separate

tempdat_tidy  %>% separate(col=Allele,into=c("Marker","Allele_num"), sep='_Allele') -> tempdat_tidy 

# various checks
table(tempdat_tidy$Allele_num)
length(unique(tempdat_tidy$ID)) * length(markers) # same value

# transform the column 'Allele_num' and the column 'Length' into integers:
tempdat_tidy$Allele_num = as.integer(tempdat_tidy$Allele_num)
tempdat_tidy$Allele_length = as.integer(tempdat_tidy$Allele_length)
tempdat_tidy
# we also change the column 'Marker' into a factor:
tempdat_tidy$Marker = factor(tempdat_tidy$Marker,levels=paste0('P',markers)) # Uselsess in this case, but if we want we can specify the order of the levels as here. It only affects the translation from tag or label or level into the integer saved in the underlying vector that is at the core of any factor object.
levels(tempdat_tidy$Marker)

# to rename a column:
#colnames(minidat_tidy)[1] = "Sample" # modifies the data frame, OR:
tempdat_tidy %>% rename(Sample=ID) -> tempdat_tidy 
tempdat_tidy

# we can also change 'Sample' into a factor:
tempdat_tidy$Sample = factor(tempdat_tidy$Sample)

# checking the number of rows:
62 * 14 * 4
# I am happy with this result as a solution to question 6
tidydat = tempdat_tidy

# Q7
# for now we do have zeroes, but no NA:
sum(is.na(tidydat$Allele_length=="0")) # I have one NA, unexpectedly.

# let's track where that NA is:
tidydat[is.na(tidydat$Allele_length),]

# we still want to count the number of zeroes
sum(!is.na(tidydat$Allele_length) & tidydat$Allele_length==0)
# OR:
sum(tidydat$Allele_length==0, na.rm = T)

# now the replacement of all 0s with NAs:
tidydat$Allele_length[tidydat$Allele_length==0] <- NA

# now count the total number of NAs:
tidydat$Allele_length %>% is.na() %>% sum()

# Q8
tidydat %>% group_by(Marker)  %>% summarise(Distinct_alleles = n_distinct(Allele_length))
# in the above, maybe the NAs have been seen as one possible value.
# to exclude them:
tidydat %>% filter(!is.na(Allele_length)) %>% group_by(Marker)  %>% summarise(Distinct_alleles = n_distinct(Allele_length))

# we could also use the na.rm option of dplyr::n_distinct():
tidydat %>% group_by(Marker) %>% summarise(Distinct_alleles = n_distinct(Allele_length, na.rm = TRUE))

# Q9
tidydat %>% group_by(Marker,Sample) %>% summarise(Distinct_alleles = n_distinct(Allele_length, na.rm = TRUE)) -> distinct_allele_counts # continue by calculating FOR EACH MARKER the ratio of "Distinct_alleles" strictly greater than 1 over number of observations (i.e. number of samples)

# we have to count within each marker, the number of samples with 2 or more alleles: these are the heterozygous ones samples for that marker. We divide by the total number of observed samples for that marker to get the observed heterozygosity.

# check: do we have zero alleles for some individuals?
unique(distinct_allele_counts$Distinct_alleles)
subset(distinct_allele_counts,Distinct_alleles==0)
# same as above, but the dplyr way:
distinct_allele_counts %>% filter(Distinct_alleles==0)

distinct_allele_counts
# the data at this stage is grouped by marker. The number of observations (rows) in each group is the number of samples for which we have a non-NA, non-0 value for the number of distinct alleles. 
# How do we get the counts per group?
distinct_allele_counts %>% summarise(n()) # all our groups have same size: 62

# we want to count the number of observations >= 2, for each group
heterozygous = function(inputvec) { sum(inputvec >= 2) }

# the function below accommodates also input vectors containing NAs
# calculated ratio is: number of observations larger than two dividided by total number of (non-NA) observations
heterozygous_ratio = function(inputvec) { sum(inputvec >= 2, na.rm=T) / sum(!is.na(inputvec)) }

# at this stage distinct_allele_counts already contained the grouping per marker.
distinct_allele_counts %>% summarise(observed_het_ratio = heterozygous_ratio(Distinct_alleles)) 
# and we have the observed heterozygosity values _per marker_

distinct_allele_counts %>% group_by(Sample) %>% summarise(counts=n()) %>% `[[`("counts") %>% unique()
# here we used the functional version of the operator "[[...]]" that extracts an element from a list (and remember: a data frame is a list of column vectors)

distinct_allele_counts %>% group_by(Sample) %>% summarise(observed_het_ratio = heterozygous_ratio(Distinct_alleles))
# this is the table of per-sample heterozygosity values

# Q10: a new measure of heterozygosity per sample and per marker:
# 1 allele seen => het = 0/3
# 2 distinct alleles seen => het = 1/3
# 3 distinct alleles seen => het = 2/3
# 4 distinct alleles seen => het = 3/3

num_alleles_to_het = function (n) { ifelse(n==1,0,ifelse(n==2,1/3,ifelse(n==3,2/3,1))) } # works but UGLY
num_alleles_to_het = function (n) { (n-1)/3 }
# or even:
num_alleles_to_het = function (n) { c(0,1/3,2/3,1)[n] }
# you can also write such a conversion function using the function match()

num_alleles_to_het(c(1,1,2,2,3,1,4,4,1,2)) # testing that the function works ok

c=10:13
c[c(1,3,2,3,3,2,1,1,19)]

distinct_allele_counts %>% transmute(Sample=Sample, fancy_het_measure = num_alleles_to_het(Distinct_alleles)) %>% group_by(Marker) %>% summarise(fancy_het_measure=mean(fancy_het_measure)) # table per markers

distinct_allele_counts %>% mutate(fancy_het_measure = num_alleles_to_het(Distinct_alleles)) %>% group_by(Sample) %>% summarise(fancy_het_measure=mean(fancy_het_measure)) # table per samples


# Q11

# we will calculate allele frequencies out of observed counts of the alleles across the 62 samples.
# (1) when a single allele was seen in a given sample, it gives a count of 4 observations of that allele
# (2) when two different alleles are seen in a given sample, it gives a count of 2 for each of these two alleles
# (3) when three different alleles are seen in a given sample, it gives a count of 4/3 for each of these allelles
# (4) when four different alleles are seen in a given sample, we have a count of 1 for each of these alleles

# then for each marker you calculate the frequencies of each allele using the counts above.