library(tidyverse)

# Reading in data files 
bisley_1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
bisley_2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
bisley_3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
rio_mameyes <- read_csv("data/RioMameyesPuenteRoto.csv")

# Stacking data frames to create one ultimate data frame 
binded_rows <- bind_rows(bisley_1, bisley_2, bisley_3, rio_mameyes)

# Filtering data frames by columns and specific years 
filtered_binded <- binded_rows |> 
  select(
    "Sample_ID", "Sample_Date", "NO3-N", "NH4-N", "K", "Mg", "Ca"
  ) |> 
  filter(
    Sample_Date >= ymd("1988-01-01") & Sample_Date < ymd("1995-01-01")
  )


concentrations <- tibble(
  window_start = seq(
    filtered_binded$Sample_Date[1],
    filtered_binded$Sample_Date[nrow(filtered_binded)],
    by = "9 weeks"

  ),
  "NO3-N" = NA,
  "NH4-N" = NA,
  "K" = NA,
  "Mg" = NA,
  "Ca" = NA
    
)

qs_smoothed <- tibble(
  window_start = seq(
    qs_data$sample_date[1],
    qs_data$sample_date[nrow(qs_data)],
    by = "9 days"
  ),
  k_mgl = NA,
  mg_mgl = NA
)





for (i in 1:length(Sample_ID)) {

}+