library(here)
covariate <- read.csv(here("original", "covariates.csv"), header = TRUE)

source(here("R", "create_mortality.R"))
source(here("R", "create_disaster.R"))
source(here("R", "create_conflict.R"))

list_alldata <- list(allmortality, disaster_sum, conflict_new)
finaldata1 <- list_alldata %>% 
  reduce(full_join, by=c("ISO", "year"))
finaldata2 <- covariate |> 
  left_join(finaldata1, by = c("ISO", "year"))

finaldata <- finaldata2 |>
  mutate(drought = replace_na(drought, 0),
         earthquake = replace_na(earthquake, 0),
         armconflict = replace_na(armconflict, 0),
         totdeath = replace_na(totdeath, 0))

write.csv(finaldata, file = here("data", "finaldata.csv"), row.names = FALSE)