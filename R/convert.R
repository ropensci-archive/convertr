#' @title Convert from one unit type to another
#'
#' @description \code{convert} accepts a vector of numeric values and
#' converts them from one unit to another. Approximately 1,300 units
#' are available.
#'
#' @param vector A numeric vector to be converted
#' @param origin The catalog symbol of the current unit.
#' @param target The catalog symbol of unit you want to convert to.
#'
#' @examples
#' convert(1:20, "kg", "g")
#' convert(1:20, "galUK/min.ft2", "kft/s")
#'
#' /don't run
#' convert(1:20, "kg", "km2)
#'
#' @export
#'
convert <- function(vector, origin, target) {
  if(!is.numeric(vector)){
    warning("Non-numeric input coerced to numeric.")
    vector <- as.numeric(vector)
  }

  if(!is_supported_unit(origin)){
    stop(paste(origin, "is not a supported unit."))
  }

  if (!is_supported_unit(target)) {
    stop(paste(target, "is not a supported unit."))
  }

  record_1 <- conversion_table[conversion_table$catalog_symbol == origin,]
  record_2 <- conversion_table[conversion_table$catalog_symbol == target,]

  if (record_1$base_unit != record_2$base_unit) {
    stop("Incompatible unit types")
  }

  base_units <- (record_1$a + record_1$b * vector) /
    (record_1$c + record_1$d * vector)
  out <- (base_units * record_2$c - record_2$a) / (record_2$b - record_2$d)

  return(out)
}

#' Check whether a unit can be converted.
#'
#' @noRd
#' @param unit
#' Name of Unit to be converted
is_supported_unit <- function(unit) {
  return(unit %in% conversion_table$catalog_symbol)
}
