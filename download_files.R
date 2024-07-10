library(readr)
library(dplyr)
library(purrr)
library(stringr)
library(janitor)
library(nanoparquet)

years <- c("2122","2021", "1920", "1819", "1718", "1617", "1516", "1415", "1314", "1213", "1112")

# state_outflows_df <-
  map(years,
      ~read_csv(paste0("https://www.irs.gov/pub/irs-soi/stateoutflow",.x,".csv")) |>
        mutate(year = .x) |>
        select(year, everything())) |>
  list_rbind() |>
  clean_names() |>
  write_parquet("clean_data/state_outflow_data.parquet")

# state_inflows_df <-
  map(years,
      ~read_csv(paste0("https://www.irs.gov/pub/irs-soi/stateinflow",.x,".csv")) |>
        mutate(year = .x) |>
        select(year, everything())) |>
  list_rbind() |>
  clean_names() |>
  write_parquet("clean_data/state_inflow_data.parquet")

# county_outflows_df <-
  map(years,
      ~read_csv(paste0("https://www.irs.gov/pub/irs-soi/countyoutflow",.x,".csv")) |>
        mutate(year = .x,
               across(contains("fips"), ~as.character(.x))) |>
        mutate(y2_countyname = str_replace_all(y2_countyname, "Do??a Ana County", "Doña Ana County")) |>
        select(year, everything())) |>
  list_rbind() |>
  clean_names() |>
  write_parquet("clean_data/county_outflow_data.parquet")

# county_inflows_df <-
  map(years,
      ~read_csv(paste0("https://www.irs.gov/pub/irs-soi/countyinflow",.x,".csv")) |>
        mutate(year = .x,
               across(contains("fips"), ~as.character(.x))) |>
        mutate(y1_countyname = str_replace_all(y1_countyname, "Do??a Ana County", "Doña Ana County")) |>
        select(year, everything())) |>
  list_rbind() |>
  clean_names() |>
  write_parquet("clean_data/county_inflow_data.parquet")
