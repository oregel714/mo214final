# Reading in necessary packages and source scripts for functions
library(tidyverse)
source("R/moving_average.R")

# Reading individual data files
bisley_1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
bisley_2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
bisley_3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
rio_mameyes <- read_csv("data/RioMameyesPuenteRoto.csv")

# Creating empty tibble to populate with new data
concentrations <- tibble(
  "Sample_ID" = NA,
  window_start = seq(
    ymd("1988-01-01"),
    ymd("1995-12-12"),
    by = "9 weeks"
  ),
  "NO3-N" = NA,
  "NH4-N" = NA,
  "K" = NA,
  "Mg" = NA,
  "Ca" = NA
)
# Applying moving average to each site
Q1 <- moving_average(bisley_1)
Q2 <- moving_average(bisley_2)
Q3 <- moving_average(bisley_3)
MPR <- moving_average(rio_mameyes)

# Combining all moving average vectors together
total_sites <- bind_rows(Q1, Q2, Q3, MPR)

write_csv(total_sites, "output/clean_data.csv")
