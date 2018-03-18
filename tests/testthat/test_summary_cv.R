context("Testing summary_cv()")

# Exceptional Cases

## Checking inputs
test_that("TypeErrors", {
  scores <- c(0.96, 0.97, 0.98)
  expect_is(scores, c('numeric'))
  expect_equal(is.vector(scores), TRUE)
  expect_equal(is.atomic(scores), TRUE)

  expect_error(summary_cv(scores = data.frame(c(0.96, 0.97, 0.98, 0.99))),
               "TypeError: `scores` must be an atomic vector.")
  expect_error(summary_cv(scores = c(0.96, 0.97, list(0.98, 0.99))),
               "TypeError: `scores` must be an atomic vector.")
  expect_error(summary_cv(scores = c(0.96, 0.97, "0.98"),
                          "TypeError: `scores` must be an atomic vector."))
})

test_that("ValueErrors", {
  expect_error(summary_cv(scores = c(0.96, 0.97, -0.98),
                          "ValueError: `scores` must be a nonnegative number."))
  expect_error(summary_cv(scores = c(0.96, 0.97, 1.98),
                          "ValueError: `scores` must be between 0 and 1."))
})


## Checking outputs
test_that("Output is of correct type and dimension", {
  # Generate an output
  cv_scores <- c(0.97, 0.96, 0.98)
  summary <- summary_cv(cv_scores)

  # Check the output type
  expect_is(summary, 'list')

  # Check the output length
  expect_equal(length(summary), 3)

  # assign outputs
  mean_cv <- summary[[1]]
  median_cv <- summary[[2]]
  sd_cv <- summary[[3]]

  # check the output types of elements in the list
  expect_is(mean_cv, 'numeric')
  expect_is(median_cv, 'numeric')
  expect_is(sd_cv, 'numeric')

})

# Normal Cases

test_that("summary_cv outputs are of correct values", {
  # Generate an output
  cv_scores <- c(0.97, 0.96, 0.98, 0.97, 0.95, 0.97)
  summary <- summary_cv(cv_scores)

  # Compare to expected results
  expect_equal(summary[[1]], 0.9666667, tolerance=1e-7)
  expect_equal(summary[[2]], 0.97)
  expect_equal(summary[[3]], 0.01032796, tolerance=1e-7)

})
