library(tidyverse)
library(readr)

cov <- read.csv("./source_data/covid.csv");

#remove duplicate id rows
covid <- cov[!duplicated(cov$id),];
covid_dup <- cov[duplicated(cov$id),];

#make variable for dependent variable
covid$dependent <- ifelse(as.numeric(substring(covid$date_died,1,2)) >31, 0, 1);

#Factorize variables
names <- c('patient_type' ,'sex', 'pneumonia', 'intubed','pregnancy','diabetes',
           'copd', 'asthma', 'inmsupr','hypertension','other_disease','cardiovascular',
           'obesity', 'renal_chronic','tobacco', 'contact_other_covid','covid_res', 'icu', 'dependent');
covid[,names] <- lapply(covid[,names] , factor);


covid[,"entry_date"] <- as.Date(covid[,"entry_date"], format = "%d-%m-%Y");
covid[,"date_symptoms"] <- as.Date(covid[,"date_symptoms"], format = "%d-%m-%Y");
covid$waitTime <- as.vector(difftime(covid$entry_date, covid$date_symptoms, units='days'))

write.csv(covid, "derived_data/covid.csv");
write.csv(covid_dup, "derived_data/covid_dup.csv")


