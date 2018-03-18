context("Integration test")

data <- gen_data(100, perfect = TRUE)
X <- data[[1]]
y <- data[[2]]

# train_test_split generating train data for cross_calidation
data_split <- train_test_split(X, y)
X_train <- data_split[[1]]
X_test <- data_split[[2]]
y_train <- data_split[[3]]
y_test <- data_split[[4]]

# cross_validation on train data
cv_scores <- cross_validation(X_train, y_train)

# summary on the cross validation scores
summary <- summary_cv(cv_scores)

test_that("Three functions integration", {
  # Compare to expected results
  expect_equal(summary[[1]], 1, tolerance=1e-7)
  expect_equal(summary[[2]], 1)
  expect_equal(summary[[3]], 0, tolerance=1e-7)
  
})
