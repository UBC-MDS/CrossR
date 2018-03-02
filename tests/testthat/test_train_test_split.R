context("Testing train_test_split()")

# test the datatype errors
test_that("Explanation of datatype errors", {
  X = rnorm(10)
  y = 2*X + 0.1*rnorm(10)
  expect_error(train_test_split(X, y), 'TypeError: X and y must be dataframe')
  X = data.frame(X = X)
  y = data.frame(y = y)
  expect_error(train_test_split(X, y, test_size = '0.25'), 'TypeError: test_size must be a number between 0 and 1')
  expect_error(train_test_split(X, y, test_size = 10), 'TypeError: test_size must be a number between 0 and 1')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = '1'), 'TypeError: random_state must be a nonnegative number')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = -10), 'TypeError: random_state must be a nonnegative number')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = '1'), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = 1), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = 1.0), 'TypeError: shuffle must be TRUE or FALSE')
})

# test the dimension errors
test_that("Explanation of dimension mismatch errors", {
  X = rnorm(10)
  y = 2*X + 0.1*rnorm(10)
  X = data.frame(X = X)
  y = data.frame(y = y)
  y[11,1] = 10
  expect_error(train_test_split(X, y), "DimensionError: dimension of X does not *match* dimension of y")
})
