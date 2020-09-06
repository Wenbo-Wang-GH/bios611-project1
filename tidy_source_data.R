library(tidyverse)

covid <- read_csv("./source_data/covid.csv");

## Clean, etc. data

write.csv(covid, "derived_data/covid.csv");