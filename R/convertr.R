#' convertr
#'
#' @name convertr
#' @docType package
#'
NULL

#' Conversion rates for various units, mostly derived from the POSC Units
#' of Measure Dictionary v2.2
#'
#' The conversion factor is broken into four componts: A, B, C, and D. Units are
#' converted from the origin unit (X) to the respective SI base unit (BU)
#' using the following formula:
#' \deqn{BU = (A + B*X) / (C + D * X)}
#'
#' @format A data frame with 1511 rows and 11 variables:
#' \itemize{
#'   \item name: name of the origin unit
#'   \item quantity_type: descriptiong of what the unit is used to measure
#'   \item catalog_name: origin of unit specification
#'   \item catelog_symbol: symbol for the unit
#'   \item rp66_symbol: Reomended PRactice 66 unit
#'   \item base_unit: equivalent System Internationale (SI) base unit
#'   \item a: conversion factor
#'   \item b: conversion factor
#'   \item c: conversion factor
#'   \item d: conversion factor
#'   \item multi_unit: Can the unit be converted to other units?
#'
#' }
"conversion_table"
