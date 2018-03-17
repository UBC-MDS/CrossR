context("Cross Validation")
library(dplyr)

#' # helper function
#' #' gen_data(): returns data X, y for testing.
#' #'
#' #' @param N number of obervations
#' #' @param perfect get perfect linear data or not
#' #' @return a list consisting of X and y (X - a dataframe, y - a numeric vector)
#' #' @examples
#' #' data = gen_data(100)
#' #' X <- data[[1]]
#' #' y <- data[[2]]
#' #'
#' gen_data <- function(N, perfect = FALSE){
#'   set.seed(123)
#'   dat <- data.frame(X1 = rnorm(N),
#'                     X2 = rnorm(N),
#'                     X3 = rnorm(N),
#'                     X4 = rnorm(N))
#'   dat <- dat %>%
#'     mutate(y = X1 + X2 + X3 + X4)
#'   if (perfect == FALSE){
#'     X <- dat[,c('X1', 'X2', 'X3')]
#'   } else {
#'     X <- dat[,c('X1', 'X2', 'X3', 'X4')]
#'   }
#'   y <- dat[,'y']
#'   return(list(X, y))
#' }


# Generate test input data
data <- gen_data(100)
X <- data[[1]]
y_vec <- data[[2]]
y <- data.frame(y = y_vec)

# Generate perfect linear data to test the output
perfect_data <- gen_data(100, perfect = TRUE)
X_p <- perfect_data[[1]]
y_p_vec <- perfect_data[[2]]
y_p <- data.frame(y_p = y_p_vec)

perfect_output_mod_0 <- c(1, 1, 1, 1, 1)
perfect_output_mod_not_0 <- c(1, 1, 1)


# Exceptional Cases

test_that("Datatype errors", {
  expect_error(cross_validation(list(c(1,2)), c(1,2)), 'TypeError: X must be a dataframe or an atomic vector')
  expect_error(cross_validation(X, list(y_vec)), 'TypeError: y must be a dataframe or an atomic vector')
  expect_error(cross_validation(X, y, k = '3'), 'TypeError: value of k must be a number')
  expect_error(cross_validation(X, y, random_state = '1'), 'TypeError: random_state must be a number')
  expect_error(cross_validation(X, y, shuffle = '1'), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(cross_validation(X, y, shuffle = 1), 'TypeError: shuffle must be TRUE or FALSE')
  expect_error(cross_validation(X, y, shuffle = 10), 'TypeError: shuffle must be TRUE or FALSE')

})

test_that("Dimensions of dataframes match", {
  y_2 <- data.frame(y1 = y, y2 = y)
  expect_error(cross_validation(X, y_2), "DimensionError: y must not have more than one column")
  X_longer <- rbind(X,X)
  expect_error(cross_validation(X_longer, y), "DimensionError: dimension of X does not equal dimension of y")
  expect_error(cross_validation(X[1:2,], data.frame(y[1:2,])), "DimensionError: Sample size is less than 3, too small for CV")
  })



test_that("Value errors", {
  expect_error(cross_validation(X, y, k = 1), 'ValueError: value of k must be an greater than or equal to 2')
  expect_error(cross_validation(X, y, random_state = -10), 'ValueError: random_state must be a nonnegative number')
  expect_error(cross_validation(X, y, k = 150), 'ValueError: value of k must be less than or equal to sample size')
  })

# Normal Cases

## Output answers to be imported from scikit-learn python implementation

test_that("when # obs in X and y modulo k is 0",{
  expect_equal(cross_validation(X_p, y_p, k = 3), perfect_output_mod_not_0)

})

test_that("when # obs in X and y modulo k is not 0",{
  expect_equal(cross_validation(X_p, y_p, k = 5), perfect_output_mod_0)

})
