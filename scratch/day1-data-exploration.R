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

q1_filtered <- filtered_binded |> 
  filter(
    Sample_ID == "Q1"
  )

concentrations <- tibble(
  "Sample_ID" = NA,
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

for (i in 1:nrow(concentrations)){
  w1 <- concentrations$window_start[i]
  w2 <- concentrations$window_start[i] + 63
  NO3_N_value <- q1_filtered$'NO3-N'[
    q1_filtered$Sample_Date >= w1 & q1_filtered$Sample_Date < w2
  ]
  NH4_N_value <- q1_filtered$'NH4-N'[
    q1_filtered$Sample_Date >= w1 & q1_filtered$Sample_Date < w2
  ]
  K_value <- q1_filtered$K[
    q1_filtered$Sample_Date >= w1 & q1_filtered$Sample_Date < w2
  ]
  Mg_value <- q1_filtered$Mg[
    q1_filtered$Sample_Date >= w1 & q1_filtered$Sample_Date < w2
  ]
  Ca_value <- q1_filtered$Ca[
    q1_filtered$Sample_Date >= w1 & q1_filtered$Sample_Date < w2
  ]

  q1_filtered$'NO3-N'[i] <- mean(NO3_N_value, na.rm = TRUE)
  q1_filtered$'NH4-N'[i] <- mean(NH4_N_value, na.rm = TRUE)
  q1_filtered$K[i] <- mean(K_value, na.rm = TRUE)
  q1_filtered$Mg[i] <- mean(Mg_value, na.rm = TRUE)
  q1_filtered$Ca[i] <- mean(Ca_value, na.rm = TRUE)
}



for (i in 1:nrow(qs_smoothed)) {
  # i is our iterator
  # 1:nrow(qs_smoothed) is our sequence
  # i will take on those values, one at a time

  # What's the start of the window? Call it w1
  w1 <- qs_smoothed$window_start[i]
  # What's the end of the window? Call it w2
  w2 <- qs_smoothed$window_start[i] + 9
  # What potassium values are in that window?
  k_mgl_value <- qs_data$k_mgl[
    qs_data$sample_date >= w1 & qs_data$sample_date < w2
  ]
  mg_mgl_value <- qs_data$mg_mgl[
    qs_data$sample_date >= w1 & qs_data$sample_date < w2
  ]
  # What's the mean
  qs_smoothed$k_mgl[i] <- mean(k_mgl_value, na.rm = TRUE)
  qs_smoothed$mg_mgl[i] <- mean(mg_mgl_value, na.rm = TRUE)
  # How do you put it in the result?
}

qs_smoothed_longer <- qs_smoothed |> 
  pivot_longer(
    cols = c(k_mgl, mg_mgl),
    names_to = "Nutrients",
    values_to = "Concentration"
  )



