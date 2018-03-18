#' cross_validation: Implement k-fold cross validation, with specified k, returning the scores
#' for each fold.
#' @import stats
#'
#' @param X: features data frame
#' @param y: target data frame
#' @param k: number of splits
#' @param shuffle: boolean
#' @param random_state: integer
#'
#' @return vector of k scores
#'
#' @export
#'
#' @examples
#' data <- gen_data(100)
#' X <- data.frame(data[[1]])
#' y_vec <- data[[2]]
#' y <- data.frame(y = y_vec)
#' cross_validation(X = X, y = y, k = 5)

cross_validation <- function(X, y, k = 3, shuffle = TRUE, random_state = 0) {
  # assure input types:
  if (!(is.data.frame(X) | is.atomic(X))) stop('TypeError: X must be a dataframe or an atomic vector')
  if (!(is.data.frame(y) | is.atomic(y))) stop('TypeError: y must be a dataframe or an atomic vector')
  if (!is.numeric(k)) stop('TypeError: value of k must be a number')
  #if (round(k) != k) stop('TypeError: value of k must be an integer')
  if (!is.numeric(random_state)) stop('TypeError: random_state must be a number')
  if (!is.logical(shuffle)) stop("TypeError: shuffle must be TRUE or FALSE")

  # assure input dimensions:
  if (get_ncols(y) > 1) stop('DimensionError: y must not have more than one column')
  if (get_nrows(X) != get_nrows(y)) stop('DimensionError: dimension of X does not equal dimension of y')
  if (get_nrows(X) < 3) stop('DimensionError: Sample size is less than 3, too small for CV')

  # assure input values in range
  if (k > get_nrows(X)) stop('ValueError: value of k must be less than or equal to sample size')
  if (k < 2) stop('ValueError: value of k must be an greater than or equal to 2')
  if (random_state < 0) stop('ValueError: random_state must be a nonnegative number')

  # get k-fold indices with fold-i as i, for example: 1,1,1,2,2,2,3,3,3
  nrows <- get_nrows(X)
  indices <- rep(1:k, each=round(nrows/k), len=nrows)
  if (shuffle == TRUE){
    set.seed(random_state)
    indices <- sample(indices, nrows, replace = FALSE)
  }

  cv_scores = c()

  for (i in 1:k){
    X_train <- subset(X, indices!=i)
    y_train <- subset(y, indices!=i)
    train_data <- data.frame(X = X_train, y = y_train)
    lm <- lm(y ~ ., data = train_data)
    X_test <- subset(X, indices==i)
    y_test <- subset(y, indices==i)
    test_data <- data.frame(X = X_test, y = y_test)
    y_pred <- predict(lm, test_data)
    r_squared <- cor(y_test, y_pred)^2
    cv_scores <- append(cv_scores, r_squared)
  }

  return(cv_scores)

}



library(dplyr)

# helper function
#' gen_data(): returns data X, y for testing.
#' @import dplyr stats
#'
#' @param N number of obervations
#' @param perfect get perfect linear data or not
#' @return a list consisting of X and y (X - a dataframe, y - a numeric vector)
#' @examples
#' data = gen_data(100)
#' X <- data[[1]]
#' y <- data[[2]]
#'
gen_data <- function(N, perfect = FALSE){
  set.seed(123)
  dat <- data.frame(X1 = rnorm(N),
                    X2 = rnorm(N),
                    X3 = rnorm(N),
                    X4 = rnorm(N))
  dat <- dat %>%
    mutate(y = X1 + X2 + X3 + X4)
  if (perfect == FALSE){
    X <- dat[,c('X1', 'X2', 'X3')]
  } else {
    X <- dat[,c('X1', 'X2', 'X3', 'X4')]
  }
  y <- dat[,'y']
  return(list(X, y))
}


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

#' get_ncols(): returns the number of columns of data.
#'
#' @param data a dataframe or an atomic vector,
#' @return number of observations
#' @examples
#' ncols = get_ncols(1:10)
#' ncols = get_ncols(mtcars)
#'
get_ncols <- function(data){
  if (is.data.frame(data)){
    return(dim(data)[2])
  }else{
    return(1)
  }
}
