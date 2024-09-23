
# part a)
matmor <- read.csv(here("original", "maternalmortality.csv"), header = TRUE)
infmor <- read.csv(here("original", "infantmortality.csv"), header = TRUE)
neomor <- read.csv(here("original", "neonatalmortality.csv"), header = TRUE)
under5mor <- read.csv(here("original", "under5mortality.csv"), header = TRUE)

library(dplyr)
library(tidyverse)
create_mortality <- function(df, value_name){
  data <- df
  data |>
    dplyr::select(Country.Name, X2000:X2019) |>
    pivot_longer(cols = starts_with("X"),
                 names_to = "year",
                 names_prefix = "X",
                 values_to = value_name) |>
    mutate(year = as.numeric(year))
}

# part b)
matmor_new <- create_mortality(matmor, "MatMor")
infmor_new <- create_mortality(infmor, "InfMor")
neomor_new <- create_mortality(neomor, "NeoMor")
under5mor_new <- create_mortality(under5mor, "Under5Mor")

# part c)
list_mor <- list(matmor_new, infmor_new, neomor_new, under5mor_new)
allmortality <- list_mor %>% reduce(full_join, by=c("Country.Name", "year"))


# part d)
library(countrycode)
allmortality$ISO <- countrycode(allmortality$Country.Name,
                                origin = "country.name",
                                destination = "iso3c")
allmortality <- allmortality %>% select(-Country.Name)



