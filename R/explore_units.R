#' @title Display the list of supported units
#'
#' @description \code{convert} accepts a vector of numeric values and
#' converts them from one unit to another. Approximately 1,300 units
#' are available.
#'
#' @examples
#' explore_units()
#'
#' @export

explore_units <- function(){

      appDir <- system.file("shiny_examples", "app", package = "convertr")

    if (appDir == "") {
      stop("Could not find example directory. Try re-installing `convertr`.", call. = FALSE)
    }
    shiny::runApp(appDir, display.mode = "normal")
}
