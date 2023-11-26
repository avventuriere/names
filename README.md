# Package "names"

## Overview
The package generates lists of names from the U.S. Social Security Administration's (SSA) baby names dataset. The package allows users to filter names based on sex, year range, and name ambiguity.

## Installation
Clone this repository using 
```R
devtools::install_github("avventuriere/names")
```
or download the source code to your local machine. Ensure that the required packages (`tidyverse` and `babynames`) are available in your R environment.

## Usage
Import the main function `list_of_names` from the package. Here are some examples of how to use it:

```R
# Generate a list of top 100 male names from 1990 to 2009
list_of_names(sex_value = "M", how_many = 100)

# Generate a list of top 200 female names from 1970 to 1989
list_of_names(sex_value = "F", year_range = 1970:1989, how_many = 200)
```

## Features
- **Sex-specific Filtering (`sex_value`):** Create name lists based on sex (`"M"` for male, `"F"` for female).
- **Year Range Selection (`year_range`)**: Filter names within specific year ranges (e.g. `1970:1989`).
- **Number of Names (`how_many`)**: Specify the number of top names to be returned from the filtered list.
- **Name Ambiguity Handling (`names`)**: Options include `"only unambiguous"` (including only sex-specific names), `"only ambiguous"` (including only names used for both sexes), or `"both"` (including both sex-ambiguous and sex-unambiguous names).

## Prerequisites
- `tidyverse` package
- `babynames` package
