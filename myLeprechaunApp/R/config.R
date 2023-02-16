CONFIG_FILE <- "config.yml"

#' Read Config
#'
#' @importFrom yaml read_yaml
#'
#' @keywords internal
#'
#' @export config_read
config_read <- function() {
  path <- system.file(CONFIG_FILE, package = "myLeprechaunApp")
  read_yaml(path)
}

#' Get Value from Configuration
#'
#' Retrieve a value from the configuration file.
#'
#' @param value The value to retrieve.
#' @param config The configuration (from [config_read()]),
#' if missing the configuration file is red.
#'
#' @keywords internal
#' @export config_get
config_get <- function(value, config = NULL) {
  if (missing(value)) {
    stop("Missing `value`", call. = FALSE)
  }

  if (is.null(config)) {
    config <- config_read()
  }

  config[[value]]
}
