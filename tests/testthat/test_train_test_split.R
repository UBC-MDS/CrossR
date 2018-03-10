context("Testing train_test_split()")

# helper functions
#' get_nrows(): returns the number of rows of a dataframe or the length of an atomic vector.
#'
#' @param data a dataframe or an atomic vector,
#' @return number of observations
#' @examples
#' nrows = get_nrows(1:10)
#' nrows = get_nrows(mtcars)
#'
get_nrows <- function(data){
  if (is.data.frame(data)){
    return(dim(data)[1])
  }else{
    return(length(data))
  }
}

# helper functions
#' gen_data(N): returns test data X, y.
#'
#' @param N number of obervations
#' @return a list consisting of X and y (X - a dataframe, y - a numeric vector)
#' @examples
#' data = gen_data(100)
#' X <- data[[1]]
#' y <- data[[2]]
#'
gen_data <- function(N){
  X <- data.frame(x0 = 1:N, x1 = rnorm(N))
  y <- 1:N
  return(list(X, y))
}

# Generate test input data
data <- gen_data(100)
X <- data[[1]]
y_vec <- data[[2]]
y <- data.frame(y = y_vec)


# Exceptional Cases

test_that("Datatype errors", {
  expect_error(train_test_split(list(c(1,2)), c(1,2)), 'TypeError: X must be a dataframe or an atomic vector')
  expect_error(train_test_split(X, list(y_vec)), 'TypeError: y must be a dataframe or an atomic vector')
  expect_error(train_test_split(X, y, test_size = '0.25'), 'TypeError: test_size must be a number')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = '1'), 'TypeError: random_state must be a number')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = '1'), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = 1), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = 1.0), 'TypeError: shuffle must be TRUE or FALSE')
})

test_that("Dimension of Dataframes Match", {
  y_2 = data.frame(y1 = y, y2 = y)
  expect_error(train_test_split(X, y_2), "DimensionError: y must not have more than one column")
  X_longer = rbind(X,X)
  expect_error(train_test_split(X_longer, y), "DimensionError: dimension of X does not equal dimension of y")
  expect_error(train_test_split(X[1:2,], data.frame(y[1:2,])), "DimensionError: Sample size is less than 3, too small for splitting")
})

test_that("Value Errors", {
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = -10), 'ValueError: random_state must be a nonnegative number')
  expect_error(train_test_split(X, y, test_size = 10), 'ValueError: test_size must be between 0 and 1')
})

# normal cases

test_that("Output errors", {
  # generate an output
  data_split <- train_test_split(X, y)
  # check the output type
  expect_is(data_split, "list")
  # check the output length
  expect_equal(length(data_split), 4)

  # assign outputs
  X_train <- data_split[[1]]
  X_test <- data_split[[2]]
  y_train <- data_split[[3]]
  y_test <- data_split[[4]]

  # check the output types of elements in the list
  expect_true(is.data.frame(X_train) | is.atomic(X_train))
  expect_true(is.data.frame(X_test) | is.atomic(X_test))
  expect_true(is.data.frame(y_train) | is.atomic(y_train))
  expect_true(is.data.frame(y_test) | is.atomic(y_test))


  # check if the dimension equals between split data and origianl data
  # check X and X_train, X_test
  expect_equal(get_nrows(X), get_nrows(X_train)+get_nrows(X_test))
  # check y and y_train, y_test
  expect_equal(get_nrows(y), get_nrows(y_train)+get_nrows(y_test))

})
