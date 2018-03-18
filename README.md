# CrossR

[![Build Status](https://travis-ci.org/UBC-MDS/CrossR.svg?branch=master)](https://travis-ci.org/UBC-MDS/CrossR)

[![Coverage status](https://codecov.io/gh/Nazliozum/CrossR/branch/master/graph/badge.svg)](https://codecov.io/github/Nazliozum/CrossR?branch=master)

The `CrossR` package (short for _Cross_-validation in _R_) is a set of functions for implementing cross-validation inside the R environment.  

### Contributors

* Nazli Ozum Kafaee / @nazliozum
* Daniel Raff / @raffrica
* Shun Chi / @ShunChi100

### Summary
Cross-validation is an important technique used in model selection and hyper-parameter optimization. Scores from cross-validation are a good estimation of test score of a predictive model in test data or new data as long as the IID assumption approximately holds in data. This package aims to provide a standardized pipeline for performing cross-validation for different modeling functions in R. In addition, summary statistics of the cross-validation results are provided for users.  


### Functions

Three main functions in `CrossR`:

- `train_test_split()`: This function partitions data into `k`-fold and returns the partitioned objects. A random shuffling option is provided.

- `cross_validation()`: This function performs `k`-fold cross validation using the partitioned data and a selected model. It returns the scores of each validation. Additional methods for corss validation will be implemented (such as "Leave-One-Out" if time allows).

- `summary_cv()`: This function outputs summary statistics(mean, standard deviation, mode, median) of cross-validation scores.

Additionally, we've built a helper function that generates data for the above functions:

- `gen_data()`: This function generates a list of X and y data that can be passed in to `train_test_split()` or `cross_validation()`  

It can be used as follows:

```
data <- gen_data(100)
X <- data.frame(data[[1]])
y_vec <- data[[2]]
y <- data.frame(y = y_vec)
```

### Installation and examples:
To install the package:
```
devtools::install_github("UBC-MDS/CrossR")
```

Given `X` (explanatory variable) and `y` (response variable) as dataframes/atomic vectors, one can split the data

```
library(CrossR)
split_data <- train_test_split(X, y, test_size = 0.25, random_state = 0, shuffle = TRUE)

# to assign split data into individual variables
X_train = split_data[[1]]
X_test = split_data[[2]]
y_train = split_data[[3]]
y_test = split_data[[4]]
```

To do cross-validation on `X`, `y` using the linear regression `lm()` model:
```
scores <- cross_validation(split_data[['X_train']], split_data[['y_train']])
```
To see the summary of scores:
```
summary_cv(scores)
```

### Similar packages

Cross-validation can be implemented with the [`caret`](https://cran.r-project.org/web/packages/caret/caret.pdf) package in R. `caret` contains the function `createDataPartition()` to split the data and `train_Control()` to apply cross-validation with different methods depending on the `method` argument. We have observed that `caret` functions have some features that make the cross-validation process cumbersome. `createDataPartition()` splits the *indices* of the data which could be used later on to actually split the data into training and test data. This will be applied with one step using `split_data()` in `CrossR`.


### License
[MIT License](https://github.com/UBC-MDS/CrossR/blob/master/LICENSE)

### Contributing
This is an open source project. So feedback, suggestions and contributions are very welcome. For feedback and suggestions, please open an issue in this repo. If you are willing to contribute this package, please refer [Contributing](https://github.com/UBC-MDS/CrossR/blob/master/CONTRIBUTING.md) guidelines for details.
