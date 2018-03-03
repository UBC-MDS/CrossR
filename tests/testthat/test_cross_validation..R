context("Cross Validation")

# read and assign the test input data
data <- read.csv("../test_data/test_data_short.csv")

X <- data[,-1]
y_vec <- data[,dim(data)[2]]
y <- data.frame(y = y_vec)

# Output from scikit_learn's `cross_val_score` to cross-reference -- for now empty
output_answers <- rep(0,10)

# Function for Reference (to delete later)
#cross_validation <- function(model, X, y, k = 3, shuffle = TRUE, random_state = 0)

# Exceptional Cases
test_that("Dataframes Match", {
  y_2 = data.frame(y1 = y, y2 =y)
  expect_error(cross_validation("lm", X, y_2), "DimensionError: y is more than one feature")

  X_longer = rbind(X,X)
  expect_error(cross_validation("lm", X_longer, y), "DimensionError: dim of X doesn't equal dim of y")

  expect_error(cross_validation("lm", X[1:2,], y[1:2,]), "DimensionError: Sample size is less than 3, too small for CV")
  })

test_that("Datatype errors", {
  X_matrix = as.matrix(X)
  expect_error(cross_validation(X_matrix, y), 'TypeError: X and y must be dataframe')
  expect_error(cross_validation("lm", X, y, k = '3'), 'TypeError: k must be an integer 2 or greater')
  expect_error(cross_validation("lm", X, y, random_state = '1'), 'TypeError: random_state must be a nonnegative number')
  expect_error(cross_validation("lm", X, y, random_state = -10), 'TypeError: random_state must be a nonnegative number')
  expect_error(cross_validation("lm", X, y, shuffle = '1'), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(cross_validation("lm", X, y, shuffle = 1), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(cross_validation("lm", X, y, shuffle = 10), 'TypeError: shuffle must be TRUE or FALSE')

})

test_that("Value Errors", {
  expect_error(cross_validation("lm", X, y, k = 1), 'ValueError: k must be an integer 2 or greater')
  expect_error(cross_validation("lm", X, y, k = 40), 'ValueError: k must be greater than # obs in X and y')
  })

# Normal Cases

## Output answers to be imported from scikit-learn python implementation

test_that("when # obs in X and y modulo k is 0",{
  expect_equal(cross_validation("lm", X, y, k = 3), output_answers[3])

})

test_that("when # obs in X and y modulo k is not 0",{
  expect_equal(cross_validation("lm", X, y, k = 3), output_answers[4])

})






## White Box Testing - notes for future
# Make sure that when constructing model within the function, that this inner model is the
# same as when constructed on a named dataframe (that hasn't been split) outside
