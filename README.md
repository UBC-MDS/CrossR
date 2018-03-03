# CrossR
The `CrossR` package (short for _Cross_-validation in _R_) is a set of functions for implementing cross-validation inside the R environment.  

### Contributors

* Nazli Ozum Kafaee / @nazliozum
* Daniel Raff / @raffrica
* Shun Chi / @ShunChi100

### Summary
Cross-validation is an important technique used in model selection and hyper-parameter optimization. Scores from cross-validation are a good estimation of test score of a predictive model in test data or new data as long as the IID assumption approximately holds in data. This package aims to provide a standardized pipeline for performing cross-validation for different modeling functions in R. In addition, summary statistics of the cross-validation results are provided for users.  


### Functions

Three main functions in `CrossR`:

- `train_test_split()`: This function partitions data into `k`-fold and returns the partitioned indices. A random shuffling option is provided. (`stratification` option for imbalanced representations will also be included if time allows).

- `cross_validation()`: This function performs `k`-fold cross validation using the partitioned data and a selected model. It returns the scores of each validation. Additional methods for corss validation will be implemented (such as "Leave-One-Out" if time allows).

- `summary_cv()`: This function outputs summary statistics(mean, standard deviation, mode, median) of cross-validation scores.


### Similar packages

Cross-validation can be implemented with the [`caret`](https://cran.r-project.org/web/packages/caret/caret.pdf) package in R. `caret` contains the function `createDataPartition()` to split the data and `train_Control()` to apply cross-validation with different methods depending on the `method` argument. We have observed that `caret` functions have some features that make the cross-validation process cumbersome. `createDataPartition()` splits the *indices* of the data which could be used later on to actually split the data into training and test data. This will be applied with one step using `split_data()` in `CrossR`.


### License
[MIT License](https://github.com/UBC-MDS/CrossR/blob/master/LICENSE)

### Contributing
This is an open source project. So feedback, suggestions and contributions are very welcome. For feedback and suggestions, please open an issue in this repo. If you are willing to contribute this package, please refer [Contributing](https://github.com/UBC-MDS/CrossR/blob/master/CONTRIBUTING.md) guidelines for details.
