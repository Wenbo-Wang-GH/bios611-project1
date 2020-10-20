library(tidyverse)
library(readr)
library(lattice)
library(e1071)
library(caret)


covid <- readRDS("derived_data/covid.csv");

set.seed(1)
covid_pos <- covid[covid$dependent == 1, ]
covid_neg <- covid[covid$dependent == 0, ]
covid_subset <- rbind(covid_pos[sample(nrow(covid_pos), 3000),], 
											covid_neg[sample(nrow(covid_neg), 3000),]) #reduce computation time with subset of data

trainIndex <- createDataPartition(covid_subset$dependent, p = .6, 
																	list = FALSE, 
																	times = 1)
covid_trn <- covid_subset[trainIndex, ]
covid_tst <- covid_subset[-trainIndex, ]


lm <- glm(dependent ~ age + sex + diabetes + copd + asthma + inmsupr + hypertension + 
						+cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
						icu, data = covid_trn, family=binomial) 

covid_tst$pred <- predict(lm, newdata=covid_tst, type="response");

set.seed(1)
train_ctrl <- trainControl(method = "cv", number = 50);
glmFit1 <- train(dependent ~ age + sex + diabetes + copd + asthma + inmsupr + hypertension + 
								 	+cardiovascular + obesity + renal_chronic + tobacco + contact_other_covid +
								 	icu, data = covid_trn, 
								 method = "glm",
								 family = "binomial",
								 trControl = train_ctrl)

sink("figures/glmFit1.txt")
summary(glmFit1);
closeAllConnections()

covid_tst$pred2 <- predict(glmFit1, newdata = covid_tst, type = "prob")
colnames(covid_tst$pred2) <- c("no", "yes")
sum((covid_tst$pred2$yes>0.5) == (as.numeric(covid_tst$dependent)>1.5))/nrow(covid_tst)

r <- ggplot() + geom_density(covid_tst, mapping = aes(pred, color = "GLM")) + 
								geom_density(as.data.frame(covid_tst$pred2), mapping = aes(yes, color = "Caret_GLM")) +
								theme(legend.justification=c(1,1), legend.position=c(1,1)) +
								scale_fill_manual(values=c("#999999", "#56B4E9"), 
										name="Model")

ggsave("figures/Prediction_caret_glm.png",plot=r)




