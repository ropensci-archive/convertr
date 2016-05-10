#' convertr
#'
#' @name convertr
#' @docType package
#' @description convertr allows you to convert numeric vectors between various
#' unit types.
#'
NULL

#' @title Conversion factors for various units
#'
#' @description This table provides the conversion factors for \code{convert}.
#' The conversion factor is broken into four componts: A, B, C, and D. Units are
#' converted from the origin unit (X) to the respective SI base unit (BU)
#' using the following formula:
#' \deqn{BU = (A + B*X) / (C + D*X)}
#'
#' The data orginates from the \href{http://w3.energistics.org/uom/poscUnits22.xml}{POSC Units of Measure Dictionary v2.2}
#' and \href{https://en.wikipedia.org/wiki/Conversion_of_units}{Wikipedia}
#'
#' @format A data frame with 1511 rows and 11 variables:
#' \itemize{
#'   \item name: Name of the origin unit
#'   \item quantity_type: Description of what the unit is used to measure
#'   \item catalog_name: Origin of unit specification
#'   \item catelog_symbol: Symbol for the unit
#'   \item rp66_symbol: Recomended Practice 66 unit
#'   \item base_unit: Equivalent System Internationale (SI) base unit
#'   \item a: Conversion factor
#'   \item b: Conversion factor
#'   \item c: Conversion factor
#'   \item d: Conversion factor
#'   \item multi_unit: Can the unit be converted to other units?
#'
#' }
  "conversion_table"
