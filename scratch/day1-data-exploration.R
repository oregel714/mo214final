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

# Creating new vector to graph
clean_data <- total_sites |>
  pivot_longer(
    cols = no3_ugl:ca_mgl,
    names_to = "Ion",
    values_to = "Concentration"
  ) |>
  mutate(
    Ion = factor(
      Ion,
      levels = c("k_mgl", "no3_ugl", "mg_mgl", "ca_mgl", "nh4_ugl"),
    )
  ) |>
  mutate(
    site = factor(
      site,
      levels = c("MPR", "Q1", "Q2", "Q3"),
      labels = c("PRM", "BQ1", "BQ2", "BQ3")
    )
  )

# Creating hurricane inidicator as an x-intercept line
hurricane_date <- as.Date("1989-09-18")

# Creating ggplot with longer_sites data
ggplot(
  data = clean_data,
  mapping = aes(
    x = window_start,
    y = Concentration,
    linetype = site
  )
) +
  # Adding geom_line for line plot
  geom_line() +
  # Implementing dashed line to indidicate hurrican occurance
  geom_vline(
    xintercept = hurricane_date,
    linetype = "dashed",
    linewidth = 0.4
  ) +
  # Adding black and white theme
  theme_bw() +
  # facet_wrap allowing for seperation of ions into seperate graph
  facet_wrap(vars(Ion), scales = 'free', ncol = 1, strip.position = "left") +
  # Changing x-axis label and removing y-axis label
  labs(
    x = "Years",
    y = NULL,
    linetype = NULL
  ) +
  # Deleting lines in the background of the graphs
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.position = "outside"
  )
