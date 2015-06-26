context("Test that conversion can be performed")

test_that("conversion is correct", {
  expect_equal(convert(1, "mi", "km"), 1.60934)
  expect_equal(convert(0, "degC", "K"), 273)
  expect_equal(convert(100, "gn", "m/s2"), 980.665)
})

test_that("Errors generate", {
  expect_error(convert(1, "fu", "m/s"), "fu is not a supported unit")
  expect_error(convert(1, "m/s", "fu"), "fu is not a supported unit")
  expect_error(convert(1, "kg", "m/s"), "Incompatible unit types")
})

