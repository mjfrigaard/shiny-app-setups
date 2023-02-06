
# Load packages ----------------------------------------------------------------

library(shiny)
library(ggplot2)
library(dplyr)
library(tools)
library(shinythemes)

source("point_plot.R")

# Load data --------------------------------------------------------------------

load("movies.RData")

# mod_var_input_ui ---------------------------------------------------
mod_var_input_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    selectInput(
        inputId = ns("y"),
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
        inputId = ns("x"),
        label = "X-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating",
          "IMDB number of votes" = "imdb_num_votes",
          "Critics Score" = "critics_score",
          "Audience Score" = "audience_score",
          "Runtime" = "runtime"
        ),
        selected = "imdb_rating"
      ),
      selectInput(
        inputId = ns("z"),
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
        inputId = ns("alpha"),
        label = "Alpha:",
        min = 0, max = 1, step = 0.1,
        value = 0.5
      ),
      sliderInput(
        inputId = ns("size"),
        label = "Size:",
        min = 0, max = 5,
        value = 2
      ),
      textInput(
        inputId = ns("plot_title"),
        label = "Plot title",
        placeholder = "Enter plot title"
      )
    )
}

# mod_var_input_server ---------------------------------------------------
mod_var_input_server <- function(id) {
  
  shiny::moduleServer(id, function(input, output, session) {
    
    return(
      list(
        'x' = reactive({input$x}),
        'y' = reactive({input$y}),
        'z' = reactive({input$z}),
        'alpha' = reactive({input$alpha}),
        'size' = reactive({input$size}),
        'plot_title' = reactive({input$plot_title})
      )
    )
  })
  
}

# mod_plot_ui ---------------------------------------------------

mod_plot_ui <- function(id) {
    ns <- shiny::NS(id)
    shiny::tagList(
      tags$br(),
      tags$p(
        "These data were obtained from",
        tags$a("IMBD", href = "http://www.imbd.com/"), "and",
        tags$a("Rotten Tomatoes", href = "https://www.rottentomatoes.com/"), "."
      ),
      tags$p("The data represent", nrow(movies), "randomly sampled movies released between 1972 to 2014 in the United States."),
      plotOutput(outputId = ns("scatterplot"))
      
      # , verbatimTextOutput(outputId = ns("values"))
  )
}

# mod_plot_server ---------------------------------------------------
mod_plot_server <- function(id, var_inputs) {
  
  shiny::moduleServer(id, function(input, output, session) {
    
    load("movies.RData")
    
    inputs <- reactive({
      plot_title <- tools::toTitleCase(var_inputs$plot_title())
      list(
        x = var_inputs$x(),
        y = var_inputs$y(),
        z = var_inputs$z(),
        alpha = var_inputs$alpha(),
        size = var_inputs$size(),
        plot_title = plot_title
      )
    })
    output$scatterplot <- renderPlot({
    plot <- point_plot(df = movies,
                       x_var = inputs()$x,
                       y_var = inputs()$y,
                       col_var = inputs()$z,
                       alpha_var = inputs()$alpha,
                       size_var = inputs()$size)
    plot +
      labs(title = inputs()$plot_title,
        x = stringr::str_replace_all(tools::toTitleCase(inputs()$x), "_", " "),
        y = stringr::str_replace_all(tools::toTitleCase(inputs()$y), "_", " ")) + 
      theme_minimal() + 
      theme(legend.position = "bottom") 
    })
    # output$values <- renderPrint({
    #   inputs()
    # })
  })
}

# moviesApp --------------------------------------------------------
moviesApp <- function() {
  shinyApp(
    ui = fluidPage(sidebarLayout(
      sidebarPanel(mod_var_input_ui("vars")),
      mainPanel(mod_plot_ui("plot"))
    )),
    server = function(input, output, session) {
      selected_vars <- mod_var_input_server("vars")
      mod_plot_server("plot", var_inputs = selected_vars)
    }
  )
}

moviesApp()
