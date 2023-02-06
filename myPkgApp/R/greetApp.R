#' greeting App
#'
#' @return shiny app
#' @export greetApp
#' @importFrom shiny shinyApp fluidPage
#'
#' @examples
#' # library(myPkgApp)
#' # greetApp()
greetApp <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      greet_ui_module("x")
    ),
    server = function(input, output) {
      greet_server_module("x")
    }
  )
}
