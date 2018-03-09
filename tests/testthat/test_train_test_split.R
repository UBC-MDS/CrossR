#source("./R/CrossR.R")


context("Testing train_test_split()")

# read and assign the test input data
data <- read.csv("../test_data/test_data_short.csv")

X <- data[,-1]
y_vec <- data[,dim(data)[2]]
y <- data.frame(y = y_vec)

# Exceptional Cases

test_that("Dimension of Dataframes Match", {

  y_2 = data.frame(y1 = y, y2 =y)
  expect_error(train_test_split(X, y_2), "DimensionError: y is more than one feature")

  X_longer = rbind(X,X)
  expect_error(train_test_split(X_longer, y), "DimensionError: dim of X doesn't equal dim of y")

  expect_error(train_test_split(X[1:2,], data.frame(y[1:2,])), "DimensionError: Sample size is less than 3, too small for splitting")
})



test_that("Datatype errors", {
  expect_error(train_test_split(X, y_vec), 'TypeError: X and y must be dataframe')
  expect_error(train_test_split(X, y, test_size = '0.25'), 'TypeError: test_size must be a number')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = '1'), 'TypeError: random_state must be a number')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = '1'), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = 1), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = 10, shuffle = 1.0), 'TypeError: shuffle must be TRUE or FALSE')
})


test_that("Value Errors", {
  expect_error(train_test_split(X, y, test_size = 0.5, random_state = -10), 'ValueError: random_state must be nonnegative')
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
  expect_is(X_train, 'data.frame')
  expect_is(X_test, 'data.frame')
  expect_is(y_train, 'data.frame')
  expect_is(y_test, 'data.frame')
  # check if the dimension equals
  expect_equal(dim(X)[1], dim(X_train)[1]+dim(X_test)[1])
  expect_equal(dim(y)[1], dim(y_train)[1]+dim(y_test)[1])
})
