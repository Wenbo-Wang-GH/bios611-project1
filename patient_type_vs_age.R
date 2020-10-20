library(tidyverse)
library(readr)

covid <- readRDS("derived_data/covid.csv");

#plots
p <- ggplot(covid, aes(dependent, age, fill=patient_type)) +
  geom_violin() + scale_fill_discrete(name="Patient Type",labels=c("Out-patient", "In-patient")) +
  xlab("Mortality") + ylab("Age")

ggsave("figures/Patient_Type_Age.png",plot=p)

