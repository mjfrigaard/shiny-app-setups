load("movies.RData")
# glimpse(movies)
# point_plot --------------------------------------------------------------------
point_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
  
    ggplot(data = df, 
      
      aes(x = .data[[x_var]], 
          y = .data[[y_var]],
          color = .data[[col_var]])) +
    
      geom_point(alpha = alpha_var, size = size_var)
  
}

# point_plot(df = movies,
#   x_var = "critics_score",
#   y_var = "imdb_rating", 
#   col_var = "critics_rating", 
#   alpha_var = 1/3, 
#   size_var = 2)