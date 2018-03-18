#' train_test_split: Split X and ydata into two portions according to input ratio.
#' Default is for the split to include shuffling.
#'
#' @importFrom stats na.exclude
#'
#' @param X features, a dataframe or a vector,
#' @param y target, a vector or a dataframe.
#' @param test_size float between 0 and 1
#' @param random_state A integer for setting the random seed.
#' @param shuffle boolean, when TRUE, shuffle the data.
#' @return list of split data in the order X_train, X_test, y_train, y_test.
#'
#' @export
#'
#' @examples
#' X = data.frame(X = rnorm(100, 0, 10))
#' y =data.frame(y = 2 * X$X + rnorm(100))
#' split_data = train_test_split(X, y, test_size = 0.5)
#'

train_test_split <- function(X, y, test_size = 0.25, random_state = 0, shuffle = TRUE){
  # assure input types:
  if (!is.data.frame(X) & !is.atomic(X)) {
    stop('TypeError: X must be a dataframe or an atomic vector')}
  if (!is.data.frame(y) & !is.atomic(y)) {
    stop('TypeError: y must be a dataframe or an atomic vector')}
  if (!is.numeric(test_size)) {
    stop('TypeError: test_size must be a number')}
  if (!is.numeric(random_state)) {
    stop('TypeError: random_state must be a number')}
  if (!is.logical(shuffle)) {
    stop("TypeError: shuffle must be TRUE or FALSE")}

  # assure input values in range
  if (!(test_size>=0 & test_size<=1)) {
    stop('ValueError: test_size must be between 0 and 1')}
  if (!(random_state >= 0)) {
    stop('ValueError: random_state must be a nonnegative number')}


  # assure dimension match between X and y
  if (get_ncols(y)>1) {
    stop("DimensionError: y must not have more than one column")}
  if (get_nrows(X) != get_nrows(y)[1]) {
    stop("DimensionError: dimension of X does not equal dimension of y")}
  if (get_nrows(X) < 3) {
    stop("DimensionError: Sample size is less than 3, too small for splitting")}


  # Get splitting index Number
  N <- get_nrows(X)
  N_train <- round(N*(1-test_size))
  N_test <- N - N_train

  # Get indices
  if (shuffle == TRUE){
    set.seed(random_state)
    indice <- sample(N, N)
  }else{
    indice <- 1:N
  }

  # split X
  if (is.data.frame(X)){
    X_train <- X[indice[1:N_train],]
    X_test <- X[na.exclude(indice[N_train+1:N]),]
  }else{
    X_train <- X[indice[1:N_train]]
    X_test <- X[na.exclude(indice[N_train+1:N])]
  }
  # split y
  if (is.data.frame(y)){
    y_train <- y[indice[1:N_train],]
    y_test <- y[na.exclude(indice[N_train+1:N]),]
  }else{
    y_train <- y[indice[1:N_train]]
    y_test <- y[na.exclude(indice[N_train+1:N])]
  }

  # return results
  return(list(X_train = X_train, X_test = X_test,
              y_train = y_train, y_test = y_test))
}


## Helper functions
#' get_nrows(): returns the number of rows of a dataframe or the length of an atomic vector.
#'
#' @param data a dataframe or an atomic vector,
#' @return number of observations
#'
#' @export
#'
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

## Helper functions
#' get_ncols(): returns the number of columns of data.
#'
#' @param data a dataframe or an atomic vector,
#' @return number of observations
#'
#' @export
#'
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

