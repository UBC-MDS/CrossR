# CrossR
The `CrossR` package (short for _Cross_-validation in _R_) is a set of functions for implementing cross-validation inside the R environment.  

### Contributors

* Nazli Ozum Kafaee / @nazliozum
* Daniel Raff / @raffrica
* Shun Chi / @ShunChi100

### Summary
Cross-validation is a important technique used in model selection and hyper-parameter optimization. Scores from cross-validation is a good estimation of test score of a predictive model in test data or new data as long as the IID assumption approximately holds in data. This package aims to provide a standardized pipeline for performing cross-validation for different modeling functions in R. In addition, visualization of the cross-validation results is provided for users.  

__To be added.__

### Functions

Three main functions in `CrossR`:

- `split_data()`: This function partitions data into `k`-fold and returns the partitioned indices. A random shuffling option is provided. (`stratification` option for imbalanced representations will also be included if time allows.)

- `cross_validation()`: This function performs `k`-fold cross validation using the partitioned data and a selected model. It returns the scores of each validation.

- `plot()`: This function visualizes the cross-validation scores against the tuning hyper-parameters. For many hyper-parameters, it outputs a grid of plots with one plot for one hyper-parameter.


### Similar packages

- `caret`


### License
[MIT License](https://github.com/ShunChi100/CrossR/blob/master/LICENSE)

### Contributing
This is an open source project. So feedback, suggestions and contributions are very welcome. For feedback and suggestions, please open an issue in this repo. If you are willing to contribute this package, please refer [Contributing](https://github.com/UBC-MDS/CrossR/blob/master/CONTRIBUTING.md) guidelines for details.
