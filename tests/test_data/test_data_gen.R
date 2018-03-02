set.seed(123)
library(tidyverse)
data <- data.frame(X1 = rnorm(10),
                   X2 = rnorm(10),
                   X3 = rnorm(10),
                   X4 = rnorm(10))
data <- data %>%
  mutate(y = X1 + X2 + X3 + X4) %>%
  select(-X4)


write_csv(data, "tests/test_data/test_data.csv")
