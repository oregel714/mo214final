library(tidyverse)
source("R/moving_average.R")
# Reading in data files 
bisley_1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
bisley_2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
bisley_3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
rio_mameyes <- read_csv("data/RioMameyesPuenteRoto.csv")

# Stacking data frames to create one ultimate data frame 
# Filtering data frames by columns and specific years 
filtered_bisley_1 <- bisley_1 |> 
  select(
    "Sample_ID", "Sample_Date", "NO3-N", "NH4-N", "K", "Mg", "Ca"
  ) |> 
  filter(
    Sample_Date >= ymd("1988-01-01") & Sample_Date < ymd("1995-01-01")
  )

q1_filtered <- filtered_bisley_1 |> 
  filter(
    Sample_ID == "Q1"
  )

concentrations <- tibble(
  "Sample_ID" = NA,
  window_start = seq(
    filtered_bisley_1$Sample_Date[1],
    filtered_bisley_1$Sample_Date[nrow(filtered_bisley_1)],
    by = "9 weeks"

  ),
  "NO3-N" = NA,
  "NH4-N" = NA,
  "K" = NA,
  "Mg" = NA,
  "Ca" = NA
    
)

moving_average(q1_filtered) 



