#' shinytest2 demo app
#'
#' @description This UI function is for the simple greeting app used in
#'    the shinytest2 demonstration on YouTube:
#'    https://youtu.be/Gucwz865aqQ
#'
#' @return UI for greeting app
#' @export greet_ui_module
#'
#' @importFrom shiny NS tagList fluidRow column
#' @importFrom shiny textInput actionButton textOutput
#'
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
#' shinytest2 demo app
#'
#' @description This server function is for the simple greeting app
#'    used in the shinytest2 demonstration on YouTube:
#'    https://youtu.be/Gucwz865aqQ
#'
#' @param input shiny parameter
#' @param output shiny parameter
#' @param session shiny parameter
#'
#' @return server for greeting app
#' @export greet_server_module
#'
#' @importFrom shiny moduleServer renderText req
#' @importFrom shiny bindEvent reactive req
#' @importFrom stringr str_extract
#'
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
