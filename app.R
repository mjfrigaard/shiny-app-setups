# Load packages ----------------------------------------------------------------

library(shiny)
library(ggplot2)
library(dplyr)
library(tools)
library(shinythemes)

# Load data --------------------------------------------------------------------

load("movies.RData")

# point_plot --------------------------------------------------------------------

point_plot <- function(df, x_var, y_var, col_var, alpha_var, size_var) {
  
    ggplot(data = df, 
      
      aes(x = .data[[x_var]], 
          y = .data[[y_var]],
          color = .data[[col_var]])) +
    
      geom_point(alpha = alpha_var, size = size_var)
  
}
# Define UI --------------------------------------------------------------------

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "y",
        label = "Y-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating",
          "IMDB number of votes" = "imdb_num_votes",
          "Critics Score" = "critics_score",
          "Audience Score" = "audience_score",
          "Runtime" = "runtime"
        ),
        selected = "audience_score"
      ),

      selectInput(
        inputId = "x",
        label = "X-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating",
          "IMDB number of votes" = "imdb_num_votes",
          "Critics Score" = "critics_score",
          "Audience Score" = "audience_score",
          "Runtime" = "runtime"
        ),
        selected = "critics_score"
      ),

      selectInput(
        inputId = "z",
        label = "Color by:",
        choices = c(
          "Title Type" = "title_type",
          "Genre" = "genre",
          "MPAA Rating" = "mpaa_rating",
          "Critics Rating" = "critics_rating",
          "Audience Rating" = "audience_rating"
        ),
        selected = "mpaa_rating"
      ),

      sliderInput(
        inputId = "alpha",
        label = "Alpha:",
        min = 0, max = 1,
        value = 0.5
      ),

      sliderInput(
        inputId = "size",
        label = "Size:",
        min = 0, max = 5,
        value = 2
      ),
      
      textInput(
        inputId = "plot_title",
        label = "Plot title",
        placeholder = "Enter plot title"
      )
    ),

    mainPanel(
      tags$br(),
      
      tags$p(
        "These data were obtained from",
        tags$a("IMBD", href = "http://www.imbd.com/"), "and",
        tags$a("Rotten Tomatoes", href = "https://www.rottentomatoes.com/"), "."
      ),
      
      tags$p("The data represent", nrow(movies), "randomly sampled movies released between 1972 to 2014 in the United States."),

      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server ----------------------------------------------------------------

server <- function(input, output, session) {

  output$scatterplot <- renderPlot({
   plot <- point_plot(df = movies,
                      x_var = input$x,
                      y_var = input$y,
                      col_var = input$z, 
                      alpha_var = input$alpha, 
                      size_var = input$size)
    plot +
      labs(title = input$plot_title, 
        x = stringr::str_replace_all(tools::toTitleCase(input$x), "_", " "),
        y = stringr::str_replace_all(tools::toTitleCase(input$y), "_", " "))
    
    })
  
}

# Create the Shiny app object --------------------------------------------------

shinyApp(ui = ui, server = server)
