
conflict <- read.csv(here("original", "conflictdata.csv"), header = TRUE)

conflict$year <- conflict$year+1

conflict_new <- conflict %>% 
  group_by(ISO,year) %>%
  summarize(totdeath = sum(best)) %>%
  mutate(armconflict = ifelse(totdeath<25, 0, 1))