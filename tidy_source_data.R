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


covid[,"entry_date"] <- as.Date(covid[,"entry_date"], format = "%d-%m-%Y");
covid[,"date_symptoms"] <- as.Date(covid[,"date_symptoms"], format = "%d-%m-%Y");
covid$waitTime <- as.vector(difftime(covid$entry_date, covid$date_symptoms, units='days'))

#plots
p <- ggplot(covid, aes(dependent, age, fill=patient_type)) +
      geom_violin() + scale_fill_discrete(name="Patient Type",labels=c("Outpatient", "Inpatient")) +
      xlab("Mortality") + ylab("Age")
ggsave("figures/Patient_Type_Age.png",plot=p);

#attempt at a separate chart
q <- ggplot(covid, aes(x = waitTime, color = dependent)) + geom_histogram(alpha = 0.25, binwidth = 15) +
    scale_fill_discrete(name="Mortality",labels=c("No", "Yes")) +
    xlab("Age") + xlim(0,20)
#ggsave("figures/Patient_Type_Age.png",plot=p);

write.csv(covid, "derived_data/covid.csv");
write.csv(covid, "derived_data/covid_dup.csv")