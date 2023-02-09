#=====================================================================#
# File name: utils.R
# This is code to create: plotting function for IMDB movies shiny app
# Authored by and feedback to: mjfrigaard
# Last updated: 2023-02-07
# MIT License
# Version: 1.0
#=====================================================================#

# pkgs -----------------------------------------------------------------
library(ggplot2)

# point_plot -----------------------------------------------------------------
point_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
  ggplot2::ggplot(
    data = df,
    ggplot2::aes(
      x = .data[[x_var]],
      y = .data[[y_var]],
      color = .data[[col_var]]
    )
  ) +
    ggplot2::geom_point(alpha = alpha_var, size = size_var)
}