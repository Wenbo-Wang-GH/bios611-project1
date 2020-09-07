library(tidyverse)
library(ggplot2)

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

#plots
p <- ggplot(covid, aes(dependent, age, fill=patient_type)) +
      geom_violin() + scale_fill_discrete(name="Patient Type",labels=c("Outpatient", "Inpatient")) +
      xlab("Mortality") + ylab("Age")
ggsave("figures/Patient_Type_Age.png",plot=p);

write.csv(covid, "derived_data/covid.csv");