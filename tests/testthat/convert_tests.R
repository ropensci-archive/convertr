library(dplyr)
load("data/conversion table.RData")
source("R/convert.R")

df <- data_frame(symbol = character(),
                 test = logical())

for(i in seq_along(conversion_table$catalog_symbol)){

  df[i, "symbol"] <- a <- conversion_table$catalog_symbol[i]
  df[i, "test"]   <- y <- all.equal(c(1, 400, 150000),
                                    convert(c(1, 400, 150000), a, a))
}

test_that("converting a unit to itself has no effect", {
  expect_true(all(y)
  )
})

test_that("conversion is correct", {
  expect_equal(convert(1, "mi", "km"), 1.60934),
  expect_equal(convert(1, "km", "mi"), 0.6213727)
  expect_equal(convert(0, "degC", "K"), 273),
  expect_equal(convert(100, "gn", "m/s2"), 980.665)
})

test_that("Errors generate", {
  expect_error(convert(1, "fu", "m/s"), "fu is not a supported unit"),
  expect_error(convert(1, "m/s", "fu"), "fu is not a supported unit"),
  expect_error(convert(1, "kg", "m/s"), "Incompatible unit types")
})

