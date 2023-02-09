# Load packages ----------------------------------------------------------------

library(shiny)
library(ggplot2)
library(dplyr)
library(tools)

# Load data --------------------------------------------------------------------

load("movies.RData")

# utils  --------------------------------------------------------------------
source("utils.R")

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  
  titlePanel(title = "movies data app (demo)"),
  
  shiny::sidebarLayout(
    
    shiny::sidebarPanel(
      
      shiny::selectInput(
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
      
      shiny::selectInput(
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
      
      shiny::selectInput(
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
      
      shiny::sliderInput(
        inputId = "alpha",
        label = "Alpha:",
        min = 0, max = 1,
        value = 0.5
      ),
      
      shiny::sliderInput(
        inputId = "size",
        label = "Size:",
        min = 0, max = 5,
        value = 2
      ),
      
      shiny::textInput(
        inputId = "plot_title",
        label = "Plot title",
        placeholder = "Enter plot title"
      )
    ),
    shiny::mainPanel(
      
      shiny::tags$br(),
      
        shiny::tags$blockquote(
          shiny::tags$em(
            shiny::tags$h6("The code for this application comes from the ",
            shiny::tags$a("Building web applications with Shiny", 
              href = "https://rstudio-education.github.io/shiny-course/"), 
                          "tutorial"))),
      
      shiny::plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server ----------------------------------------------------------------

server <- function(input, output, session) {
  output$scatterplot <- shiny::renderPlot({
    plot <- point_plot(
      df = movies,
      x_var = input$x,
      y_var = input$y,
      col_var = input$z,
      alpha_var = input$alpha,
      size_var = input$size
    )
    plot +
      ggplot2::labs(
        title = input$plot_title,
        x = stringr::str_replace_all(tools::toTitleCase(input$x), "_", " "),
        y = stringr::str_replace_all(tools::toTitleCase(input$y), "_", " ")
      )
  })
}

# Create the Shiny app object --------------------------------------------------

shiny::shinyApp(ui = ui, server = server)
