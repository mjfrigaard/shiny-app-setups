library(shiny)
library(stringr)

greet_ui_module <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::textInput(inputId = ns("name"), 
                         label = "what is your name"),
        shiny::actionButton(inputId = ns("greet"), 
                            label = "Greet"),
        shiny::textOutput(outputId = ns("greeting")),
        shiny::textOutput(outputId = ns("first_letter"))
      )
    )
  )
}

greet_server_module <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    output$greeting <- shiny::renderText({
      shiny::req(input$name)
      paste0("Hello ", input$name, "!")
    }) |>
      shiny::bindEvent({
        input$greet
      })

    first_letter <- shiny::reactive({
      shiny::req(input$name)
      tolower(stringr::str_extract(input$name, "^."))
    }) |>
      shiny::bindEvent({
        input$greet
      })

    output$first_letter <- shiny::renderText({
      paste0("The first letter in your is ", first_letter(), "!")
    })
  })
}


greetDemo <- function() {
  shiny::shinyApp(
    ui = fluidPage(
      greet_ui_module("x")
    ),
    server = function(input, output) {
      greet_server_module("x")
    }
  )
}

greetDemo()
