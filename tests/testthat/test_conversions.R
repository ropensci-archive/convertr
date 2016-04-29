context("Test that conversion can be performed")

test_that("conversion is correct", {
  expect_equal(convert(1, "mi", "km"), 1.60934)
  expect_equal(convert(0, "degC", "K"), 273.15)
  expect_equal(convert(100, "gn", "m/s2"), 980.665)
  expect_equal(convert(1:5, "gn", "m/s2"), c(9.80665, 19.6133, 29.41995, 39.2266, 49.03325))
  expect_equal(convert( -10:10, "degC", "degF"), c(14, 15.8, 17.6, 19.4, 21.2, 23, 24.8, 26.6, 28.4, 30.2, 32,
                                                   33.8, 35.6, 37.4, 39.2, 41, 42.8, 44.6, 46.4, 48.2, 50))
})


test_that("Chained Conversion Returns to Origin", {

  a <- 1:20
  b <- convert(a, "degC", "K")
  c <- convert(b, "K", "degF")
  d <- convert(c, "degF", "degC")
  expect_equal(a, d)
})

test_that("character input produces warning and NA", {
  expect_warning(convert("a", "mi", "km"))
  expect_warning(convert(TRUE, "K", "degF"))
  expect_warning( convert(factor(1:10), "K", "degF"))
  expect_warning( convert(NA, "K", "K"))

  char   <- suppressWarnings( convert("a", "mi", "km"))
  logic  <- suppressWarnings( convert(TRUE, "K", "K"))
  factor <- suppressWarnings( convert(factor(1:10), "K", "K"))

  expect_equal(char, as.numeric(NA))
  expect_equal(logic, 1)
  expect_equal(factor, 1:10)

})


test_that("incompatible units", {
  expect_error(convert(1, "fu", "m/s"), "fu is not a supported unit")
  expect_error(convert(1, "m/s", "fu"), "fu is not a supported unit")
  expect_error(convert(1, "kg", "m/s"), "Incompatible unit types")
})

