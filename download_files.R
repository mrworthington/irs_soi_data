library(tidyverse)
library(janitor)
library(arrow)

years <- c("2122","2021", "1920", "1819", "1718", "1617", "1516", "1415", "1314", "1213", "1112")

state_outflows_df <-
  map(years,
      ~read_csv(paste0("https://www.irs.gov/pub/irs-soi/stateoutflow",.x,".csv")) |>
        mutate(year = .x) |>
        select(year, everything())) |>
  list_rbind() |>
  clean_names()
