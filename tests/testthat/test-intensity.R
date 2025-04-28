test_that("intensity function works correctly", {
  # Test with typical selection proportion
  result <- intensity(0.1)
  expect_type(result, "list")
  expect_equal(length(result), 3)
  expect_named(result, c("i", "var_reduc", "var_sel"))
  
  # Expected values for 10% selection (approximately)
  expect_equal(result$i, 1.755, tolerance = 0.001)
  
  # Test with finite population
  result_finite <- intensity(0.1, pop_size = 100)
  expect_type(result_finite, "list")
  expect_equal(length(result_finite), 3)
  
  # Test error conditions
  expect_error(intensity(-0.1), "ERROR: p not between 0 and 1")
  expect_error(intensity(1.1), "ERROR: p not between 0 and 1")
  expect_error(intensity(0.1, pop_size = 1), "ERROR: pop_size is less than 2")
})