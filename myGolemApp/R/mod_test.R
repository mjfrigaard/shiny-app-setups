#' test UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @export mod_test_ui
#'
#' @importFrom shiny NS tagList
#' @importFrom shiny fluidRow column
#' @importFrom shiny verbatimTextOutput
mod_test_ui <- function(id){
  ns <- shiny::NS(id)
  shiny::tagList(
   shiny::fluidRow(
     shiny::column(
       shiny::verbatimTextOutput(ns("vals"))
     )
   )
  )
}

#' test Server Functions
#'
#' @noRd
#' @export mod_test_server
#'
#' @importFrom shiny moduleServer
#' @importFrom shiny renderPrint
#' @importFrom shiny reactiveValuesToList
mod_test_server <- function(id){
  shiny::moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$vals <- shiny::renderPrint({
      shiny::reactiveValuesToList(x = input, all.names = TRUE)
    })
  })
}

## To be copied in the UI
# mod_test_ui("test_1")

## To be copied in the server
# mod_test_server("test_1")
