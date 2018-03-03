#' train_test_split: Split X and ydata into two portions according to input ratio.
#' Default is for the split to include shuffling.
#'
#' @param X features, a dataframe,
#' @param y target, a dataframe.
#' @param test_size float between 0 and 1
#' @param random_state A integer for seting the random seed.
#' @param shuffle boolean, when TRUE, shuffle the data.
#' @return split data into X_train, X_test, y_train, y_test.
#' @examples
#' X = data.frame(X = rnorm(100, 0, 10))
#' y =data.frame(y = 2 * X$X + rnorm(100))
#' X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.5)
#'

train_test_split <- function(X, y, test_size = 0.25, random_state = 0, shuffle = TRUE){
  # split data here

}



#' cross_validation: Implement k-fold cross validation, with specified k, returning the scores
#' for each fold.
#'
#' @param model string for model name(options --> "lm", "glm")
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

cross_validation <- function(model, X, y, k = 3, shuffle = TRUE, random_state = 0) {
  # apply cross validation here
}



#' summary_cv: Summary statistics of cross-validation scores
#'
#' @param scores vector of cross-validation scores
#'
#' @return vector of summary statistics consisting of mean, standard deviation, mode and median
#'
#' @export
#'
#' @examples
#' cv_scores = c(0.97, 0.96, 0.98)
#' summary_cv(scores = cv_scores)

summary_cv <- function(scores){
  # Get summary statistics
}

