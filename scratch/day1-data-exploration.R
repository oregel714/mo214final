library(tidyverse)
source("R/moving_average.R")
# Reading in data files 
bisley_1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
bisley_2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
bisley_3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
rio_mameyes <- read_csv("data/RioMameyesPuenteRoto.csv")

# Stacking data frames to create one ultimate data frame 
# Filtering data frames by columns and specific years 
q1_filtered <- bisley_1 |> 
  select(
    "Sample_ID", "Sample_Date", "NO3-N", "NH4-N", "K", "Mg", "Ca"
  ) |> 
  filter(
    Sample_Date >= ymd("1988-01-01") & Sample_Date < ymd("1995-01-01"),
    Sample_ID == "Q1"
  )
q2_filtered <- bisley_2 |> 
  select(
    "Sample_ID", "Sample_Date", "NO3-N", "NH4-N", "K", "Mg", "Ca"
  ) |> 
  filter(
    Sample_Date >= ymd("1988-01-01") & Sample_Date < ymd("1995-01-01"),
    Sample_ID == "Q2"
  )
q3_filtered <- bisley_3 |> 
   select(
    "Sample_ID", "Sample_Date", "NO3-N", "NH4-N", "K", "Mg", "Ca"
  ) |> 
  filter(
    Sample_Date >= ymd("1988-01-01") & Sample_Date < ymd("1995-01-01"),
    Sample_ID == "Q3"
  )
mpr_filtered <- rio_mameyes |> 
   select(
    "Sample_ID", "Sample_Date", "NO3-N", "NH4-N", "K", "Mg", "Ca"
  ) |> 
  filter(
    Sample_Date >= ymd("1988-01-01") & Sample_Date < ymd("1995-01-01"),
    Sample_ID == "MPR"
  )

concentrations <- tibble(
  "Sample_ID" = NA,
  window_start = seq(
    q1_filtered$Sample_Date[1],
    q1_filtered$Sample_Date[nrow(q1_filtered)],
    by = "9 weeks"

  ),
  "NO3-N" = NA,
  "NH4-N" = NA,
  "K" = NA,
  "Mg" = NA,
  "Ca" = NA
    
)
# Applying moving average to each site 
Q1 <- moving_average(q1_filtered)
Q2 <- moving_average(q2_filtered)
Q3 <- moving_average(q3_filtered)
MPR <- moving_average(mpr_filtered)

# Combining all moving average vectors together 
total_sites <- bind_rows(Q1, Q2, Q3, MPR)

# Creating new vector to graph 
longer_sites <- total_sites |> 
pivot_longer(
    cols = no3_ugl:ca_mgl,
    names_to = "Ion",
    values_to = "Concentration"
  ) 

ggplot(
  data = longer_sites,
  mapping = aes(
    x = window_start,
    y = Concentration,
    linetype = site
  )
) + 
  geom_line() + 
  facet_wrap(vars(Ion), scales = 'free', ncol = 1) + 
  labs(
    y = "Years" 
  )


  



