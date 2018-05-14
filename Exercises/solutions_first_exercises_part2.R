library(readxl)
library(tidyr)

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
tidydat %>% group_by(Marker,Sample) %>% summarise(Distinct_alleles = n_distinct(Allele_length, na.rm = TRUE)) # continue by calculating FOR EACH MARKER the ratio of "Distinct_alleles" strictly greater than 1 over number of observations (i.e. number of samples)

