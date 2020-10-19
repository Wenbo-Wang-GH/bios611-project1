library(tidyverse)
library(readr)

#load data
covid <- readRDS("derived_data/covid.csv");
set.seed(1)
covid_subset <- covid[sample(nrow(covid), 20000),]

#randomly sample for train/validate/test datasets
set.seed(1)
spec = c(train = .6, test = .2, validate = .2)

g = sample(cut(
	seq(nrow(covid_subset)), 
	nrow(covid_subset)*cumsum(c(0,spec)),
	labels = names(spec)
))

res = split(covid_subset, g)

train <- res$train
validate <- res$validate
test <- res$test

#create a logistic model predicting for whether a patient died
#lm <- glm(dependent ~ age + sex + diabetes + pregnancy + copd + asthma + inmsupr + hypertension + 
#						+cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
#						icu, data = train, family=binomial) 

#high collinearity between variables
#alias(lm)

#try again, removing collinear variable, non-significant variables

lm <- glm(dependent ~ age + sex + diabetes + copd + asthma + inmsupr + hypertension + 
						+cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
						icu, data = train, family=binomial) 
sink("figures/lm.txt")
summary(lm)
closeAllConnections()

