library(tidyverse)

covid <- read.csv("derived_data/covid.csv");

#create a logistic model predicting for whether a patient died
lm <- glm(dependent ~ age + sex + diabetes + pregnancy + copd + asthma + inmsupr + hypertension + 
            +cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
            icu, data = covid, family=binomial)
sink("derived_data/lm.txt")
#print(summary(lm))
#sink() 