context("Test that conversion table is properly constructed")

test_that("All records have a 'c'value",  {
  table <- get_conversion_table()

expect_true(  all(table$c != 0))

})
