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
    shiny::selectInput(
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
    shiny::selectInput(
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
    shiny::selectInput(
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
    shiny::sliderInput(
      inputId = ns("alpha"),
      label = "Alpha:",
      min = 0, max = 1, step = 0.1,
      value = 0.5
    ),
    shiny::sliderInput(
      inputId = ns("size"),
      label = "Size:",
      min = 0, max = 5,
      value = 2
    ),
    shiny::textInput(
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
        "x" = shiny::reactive({
          input$x
        }),
        "y" = shiny::reactive({
          input$y
        }),
        "z" = shiny::reactive({
          input$z
        }),
        "alpha" = shiny::reactive({
          input$alpha
        }),
        "size" = shiny::reactive({
          input$size
        }),
        "plot_title" = shiny::reactive({
          input$plot_title
        })
      )
    )
  })
}

# mod_plot_ui ---------------------------------------------------

mod_plot_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::tags$br(),
    shiny::tags$p(
      "These data were obtained from",
      shiny::tags$a("IMBD",
        href = "http://www.imbd.com/"
      ), "and",
      shiny::tags$a("Rotten Tomatoes",
        href = "https://www.rottentomatoes.com/"
      ), "."
    ),
    shiny::tags$p(
      "The data represent",
      nrow(movies),
      "randomly sampled movies released between 1972 to 2014 in the United States."
    ),
    shiny::plotOutput(outputId = ns("scatterplot"))
    # , verbatimTextOutput(outputId = ns("values"))
  )
}

# mod_plot_server ---------------------------------------------------
mod_plot_server <- function(id, var_inputs) {
  shiny::moduleServer(id, function(input, output, session) {
    load("movies.RData")

    inputs <- shiny::reactive({
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
    output$scatterplot <- shiny::renderPlot({
      plot <- point_plot(
        df = movies,
        x_var = inputs()$x,
        y_var = inputs()$y,
        col_var = inputs()$z,
        alpha_var = inputs()$alpha,
        size_var = inputs()$size
      )
      plot +
        ggplot2::labs(
          title = inputs()$plot_title,
          x = stringr::str_replace_all(tools::toTitleCase(inputs()$x), "_", " "),
          y = stringr::str_replace_all(tools::toTitleCase(inputs()$y), "_", " ")
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")
    })
    # output$values <- renderPrint({
    #   inputs()
    # })
  })
}

# moviesApp --------------------------------------------------------
moviesApp <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          mod_var_input_ui("vars")
        ),
        shiny::mainPanel(
          mod_plot_ui("plot")
        )
      )
    ),
    server = function(input, output, session) {
      selected_vars <- mod_var_input_server("vars")
      mod_plot_server("plot", var_inputs = selected_vars)
    }
  )
}

moviesApp()
