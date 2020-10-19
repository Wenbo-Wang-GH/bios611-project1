library(tidyverse)
library(readr)
#library(caret)
library(e1071)

covid <- readRDS("derived_data/covid.csv");

set.seed(1)
covid_subset <- covid[sample(nrow(covid), 20000),] #reduce computation time with subset of data

trainIndex <- createDataPartition(covid_subset$dependent, p = .6, 
																	list = FALSE, 
																	times = 1)
covid_trn <- covid_subset[trainIndex, ]
covid_tst <- covid_subset[-trainIndex, ]


lm <- glm(dependent ~ age + sex + diabetes + copd + asthma + inmsupr + hypertension + 
						+cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
						icu, data = train, family=binomial) 

covid_tst$pred <- predict(lm, newdata=covid_tst, type="response");

set.seed(1)
train_ctrl <- caret::trainControl(method = "cv", number = 50);
glmFit1 <- caret::train(dependent ~ age + sex + diabetes + copd + asthma + inmsupr + hypertension + 
								 	+cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
								 	icu, data = covid_trn, 
								 method = "glm",
								 family = "binomial",
								 trControl = train_ctrl)
summary(glmFit1);
sink("figures/glmFit1.txt")

covid_tst$pred2 <- caret::predict(glmFit1, newdata = covid_tst)
sum((prob$yes>0.5) == (as.numeric(covid_tst$dependent)>0.5))/nrow(covid_tst)

r <- ggplot() + geom_density(covid_tst, mapping = aes(pred, color = "GLM")) + 
								geom_density(covid_tst, mapping = aes(pred2, color = "Caret_GLM")) + xlim(0, 0.05) +
								theme(legend.justification=c(1,1), legend.position=c(1,1)) +
								scale_fill_manual(values=c("#999999", "#56B4E9"), 
										name="Model")

ggsave("figures/Prediction_caret_glm.png",plot=r)
sink("figures/caret_lm.txt")
summary(glmFit1)
closeAllConnections()



