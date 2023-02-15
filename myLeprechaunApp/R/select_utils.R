#' Make title vector of data column names
#'
#' @param df dataset
#' @param type one of factor, double, integer, and character
#'
#' @return cols named vector with column names and title names
#' @export make_title_col_where
#'
#' @importFrom dplyr select
#' @importFrom tidyselect where
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_to_title
#' @importFrom purrr set_names
#'
#' @examples
#' make_title_col_where(mpg)
make_title_col_where <- function(df, type) {

  df <- switch(EXPR = type,
    factor = dplyr::select(df, where(is.factor)),
    double = dplyr::select(df, where(is.double)),
    integer = dplyr::select(df, where(is.integer)),
    character = dplyr::select(df, where(is.character)))

  data_col <- names(df)
  title_col <- stringr::str_replace_all(data_col, "rel", "release") |>
  stringr::str_replace_all("thtr", "theatre") |>
  stringr::str_replace_all("_", " ") |>
  stringr::str_to_title()
  cols <- purrr::set_names(x = title_col, nm = data_col)
  return(cols)

}
