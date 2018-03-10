#' train_test_split: Split X and ydata into two portions according to input ratio.
#' Default is for the split to include shuffling.
#'
#' @param X features, a dataframe or a vector,
#' @param y target, a vector or a dataframe.
#' @param test_size float between 0 and 1
#' @param random_state A integer for seting the random seed.
#' @param shuffle boolean, when TRUE, shuffle the data.
#' @return list of split data in the order X_train, X_test, y_train, y_test.
#' @examples
#' X = data.frame(X = rnorm(100, 0, 10))
#' y =data.frame(y = 2 * X$X + rnorm(100))
#' split_data = train_test_split(X, y, test_size = 0.5)
#'

train_test_split <- function(X, y, test_size = 0.25, random_state = 0, shuffle = TRUE){
  # assure input types:
  if (!is.data.frame(X) & !is.atomic(X)) stop('TypeError: X must be a dataframe or an atomic vector')
  if (!is.data.frame(y) & !is.atomic(y)) stop('TypeError: y must be a dataframe or an atomic vector')
  if (!is.numeric(test_size)) stop('TypeError: test_size must be a number')
  if (!is.numeric(random_state)) stop('TypeError: random_state must be a number')
  if (!is.logical(shuffle)) stop("TypeError: shuffle must be TRUE or FALSE")

  # assure input values in range
  if (!(test_size>=0 & test_size<=1)) stop('ValueError: test_size must be between 0 and 1')
  if (!(random_state >= 0)) stop('ValueError: random_state must be a nonnegative number')


  # assure dimension match between X and y
  if (dim(y)[2]>1) stop("DimensionError: y must not have more than one column")
  if (dim(X)[1] != dim(y)[1]) stop("DimensionError: dimension of X does not equal dimension of y")
  if (dim(X)[1] < 3) stop("DimensionError: Sample size is less than 3, too small for splitting")


  # split data here
  N <- dim(X)[1]
  N_train <- round(N*(1-test_size))
  N_test <- N - N_train

  if (shuffle == TRUE){
    set.seed(random_state)
    indice <- sample(N, N)
  }else{
    indice <- 1:N
  }

  X_train <- X[indice[1:N_train],]
  #print()
  X_test <- X[na.exclude(indice[N_train+1:N]),]
  y_train <- y[indice[1:N_train],]
  y_test <- y[na.exclude(indice[N_train+1:N]),]

  return(list(X_train = X_train, X_test = X_test, y_train = y_train, y_test = y_test))
}



#' cross_validation: Implement k-fold cross validation, with specified k, returning the scores
#' for each fold.
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
#' cross_validation(model = lm, X = X_iris, y = y_iris, k = 5)

cross_validation <- function(X, y, k = 3, shuffle = TRUE, random_state = 0) {
  # assure input types:
  if (!is.data.frame(X) & !is.atomic(X)) stop('TypeError: X must be a dataframe or an atomic vector')
  if (!is.data.frame(y) & !is.atomic(y)) stop('TypeError: y must be a dataframe or an atomic vector')
  if (!is.numeric(k)) stop('TypeError: value of k must be a number')
  #if (round(k) != k) stop('TypeError: value of k must be an integer')
  if (!is.numeric(random_state)) stop('TypeError: random_state must be a number')
  if (!is.logical(shuffle)) stop("TypeError: shuffle must be TRUE or FALSE")

  # assure input dimensions:
  if (is.data.frame(y) & dim(y)[2] > 1) stop('DimensionError: y must not have more than one column')
  if (dim(X)[1] != dim(y)[1]) stop('DimensionError: dimension of X does not equal dimension of y')
  if (dim(X)[1] < 3) stop('DimensionError: Sample size is less than 3, too small for CV')

  # assure input values in range
  if (k > dim(X)[1]) stop('ValueError: value of k must be less than or equal to sample size')
  if (k < 2) stop('ValueError: value of k must be an greater than or equal to 2')
  if (random_state < 0) stop('ValueError: random_state must be a nonnegative number')


  # Helper function for cross-validation
  split_indices <- function(X2, k2, shuffle2 = TRUE) {
    set.seed(random_state)
    length <- dim(X2)[1]
    random_column <- sample(rep(1:k2, length))
    df <- data.frame(cbind(data_index = 1:length, groups = random_column))
    if (shuffle2 == FALSE){
      df <- df[order(df$groups),]
    } else {
      df
    }
    indices_list <- list()
    for (number in 1:k2){
      indices_list[[number]] <- df[df$group == number,]$data_index
    }
    return(indices_list)
  }

  # Apply cross_validation here
  if (shuffle == TRUE){
    indices_list <- split_indices(X2 = X, k2 = k, shuffle2 = TRUE)
  } else{
    indices_list <- split_indices(X2 = X, k2 = k, shuffle2 = FALSE)
  }

  cv_scores = c()

  for (i in 1:k){
    data_lm <- data.frame(X[indices_list[[k]],], y = y[indices_list[[k]],])
    lm <- lm(y ~ ., data = data_lm)
    cv_scores <- append(cv_scores, summary(lm)$r.squared)
  }

  return(cv_scores)

}


#' summary_cv: Summary statistics of cross-validation scores
#'
#' @param scores vector of cross-validation scores
#'
#' @return list of summary statistics consisting of mean, standard deviation, mode and median
#'
#' @export
#'
#' @examples
#' cv_scores = c(0.97, 0.96, 0.98)
#' summary_cv(scores = cv_scores)

summary_cv <- function(scores){
  # Get summary statistics here
}

