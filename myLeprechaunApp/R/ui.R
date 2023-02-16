#' Shiny UI
#'
#' Core UI of package.
#'
#' @param req The request object.
#'
#' @import shiny
#' @importFrom bslib bs_theme
#'
#' @keywords internal
ui <- function(req) {
  shiny::fluidPage(
    theme = bs_theme(version = 5),
    assets(),
    shiny::tags$h1("myLeprechaunApp"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        var_inputUI("vars")
      ),
      shiny::mainPanel(
        # shiny::tags$img(src = "img/leprechaun.jpg"),
        tag("simple-greeting", list(name = "Martin")),
        plotUI("plot")
      )
    )
  )
}

#' Assets
#'
#' Includes all assets.
#' This is a convenience function that wraps
#' [serveAssets] and allows easily adding additional
#' remote dependencies (e.g.: CDN) should there be any.
#'
#' @importFrom shiny tags
#'
#' @keywords internal
assets <- function() {
  list(
    serveAssets(), # base assets (assets.R)
    tags$head(
      # Place any additional dependencies here
      # e.g.: CDN
    )
  )
}
