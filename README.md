# quantgen

<!-- badges: start -->
<!-- badges: end -->

## Overview

`quantgen` is an R package that provides tools for quantitative genetic analyses. Currently, it includes tools for calculating selection intensity with optional adjustment for finite population size.

## Installation

You can install the development version of quantgen from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("austin-putz/quantgen")
```

## Example

Load the library as usual:

```r
library(quantgen)
```

Use the basic function with the main argument the proportion selected. 

```{r}
# Calculate selection intensity when selecting the top 10%
intensity(0.1)
```

You can also specify a population size to make an adjustment to intensity. 

```{r}
# With finite population adjustment
intensity(0.1, pop_size = 100)
```

## Functions

### intensity()

Calculates the intensity of selection, which is the mean of the selected group expressed in standard deviation units of the unselected population.

#### Parameters:
- `p`: Proportion selected (between 0 and 1, not percentage)
- `pop_size`: Optional finite population size for adjusted calculation

#### Returns:
A list with three components:
- `i`: Intensity of selection
- `var_reduc`: Variance reduction
- `var_sel`: Variance in selected population

