#' summary_cv: Summary statistics of cross-validation scores
#'
#' @importFrom stats median sd
#'
#' @param scores vector of cross-validation scores
#'
#' @return list of summary statistics consisting of mean, median, and standard deviation
#'
#'
#' @export
#'
#' @examples
#' cv_scores = c(0.97, 0.96, 0.98)
#' summary_cv(scores = cv_scores)

summary_cv <- function(scores){
  # Get summary statistics here
  if (!is.vector(scores) | !is.atomic(scores)) {
    stop("TypeError: `scores` must be an atomic vector.")}
  if (any(scores>1 | scores < 0)) {
    stop("DimensionError: `scores` cannot be of length zero.")}

  list(mean = mean(scores),
       median = median(scores),
       sd = sd(scores)
       )

}

