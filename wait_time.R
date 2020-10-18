library(tidyverse)

covid <- read.csv("derived_data/covid.csv");

q <- ggplot(covid, aes(x = waitTime, fill = dependent)) + geom_histogram(aes(y = ..density..),alpha = 0.50, binwidth = 1) +
  scale_fill_discrete(name="Mortality",labels=c("No", "Yes")) +
  xlab("Wait Time (Days)") + ylab("Density of Cases") + xlim(0,20) +geom_vline(xintercept = 3.639876, size = 0.5,alpha = 0.25, colour = "red", linetype = "solid") + 
  geom_vline(xintercept = 4.046071, size = 0.5,alpha = 0.5, colour = "turquoise", linetype = "solid")

ggsave("figures/Wait_Time.png",plot=q)