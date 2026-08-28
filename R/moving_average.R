# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(site_data) {
  # Initialize a tibble to contain the results
  result <- tibble(
    site = site_data$Sample_ID[1],
    window_start = seq(
      ymd("1986-05-20"),
      ymd("1995-01-01"),
      by = "9 weeks"
    ),
    no3_ugl = NA,
    nh4_ugl = NA,
    k_mgl = NA,
    mg_mgl = NA,
    ca_mgl = NA
    # Fill in the rest of the ions
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- result$window_start[i] + 63

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- site_data$Sample_Date >= w1 & site_data$Sample_Date < w2

    # Use indexing to pull out the ion concentrations that fall inside the window
    NO3_N_window <- site_data$`NO3-N`[in_window]
    NH4_N_window <- site_data$`NH4-N`[in_window]
    k_window <- site_data$K[in_window]
    Mg_window <- site_data$Mg[in_window]
    Ca_window <- site_data$Ca[in_window]

    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    result$no3_ugl[i] <- mean(NO3_N_window, na.rm = TRUE)
    result$nh4_ugl[i] <- mean(NH4_N_window, na.rm = TRUE)
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(Mg_window, na.rm = TRUE)
    result$ca_mgl[i] <- mean(Ca_window, na.rm = TRUE)
  }

  # Return the result
  return(result)
}
