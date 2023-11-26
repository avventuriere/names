# This script generates lists of names from the SSA baby names dataset. 
# https://www.ssa.gov/oact/babynames/
# It allows filtering based on gender, year range, and name ambiguity.
# Requires 'tidyverse' and 'babynames' packages.
# See examples at the bottom for usage.

require(tidyverse)
require(babynames)

list_of_names <- function(year_range=1990:2009, 
                          sex_value="F", 
                          names="both",
                          how_many=20){
  
  if (!names %in% c("only ambiguous", "only unambiguous", "both")) 
    stop("Invalid 'names' parameter. Choose from 'only ambiguous', 'only unambiguous', or 'both'.")

  df_babynames = babynames::babynames

  # Filter names based on the specified ambiguity
  df_babynames <- filter_names(df_babynames, sex_value, names)
  
  df_babynames = df_babynames %>%
    filter(year %in% year_range) %>%
    group_by(name) %>%
    summarize(count = sum(n)) %>%
    ungroup() %>%
    arrange(-count) %>%
    slice(1:how_many)

  return(df_babynames) 
}


# Helper function to filter names based on ambiguity
filter_names <- function(df, sex_value, names) {
  # The middle name problem:
  # In the SSA data, some names used primarily for one sex might appear for the other sex,
  # often as middle names (probably to honor a relative). Currently, there is no good way to separate those.
  # The 'names' parameter is set to "both" by default. As a result, if one doesn't want ambiguous names 
  # in their data, they have to filter those out themselves. The middle name problem is not as prevalent with 
  # non-Anglo-Saxon names. As a result, "only unambiguous" returns a list of mostly non-Anglo-Saxon names.
  # The "only ambiguous" option currently does not work as expected, but I leave it here for completeness.

  opposite_sex_df <- df %>% filter(sex != sex_value)
  if (names == "only unambiguous") {
    df %>% filter(sex == sex_value & !name %in% opposite_sex_df$name)
  } else if (names == "only ambiguous") {
    df %>% filter(sex == sex_value & name %in% opposite_sex_df$name)
  } else { # names == "both"
    df %>% filter(sex == sex_value)
  }
}

# Examples of function usage
# Uncomment to run
# list_of_names(sex_value = "M", how_many = 100)
# list_of_names(sex_value = "F", how_many = 200)
# list_of_names(sex_value = "M", year_range = 1970:1989)
# list_of_names(sex_value = "F", year_range = 1970:1989)
# list_of_names(sex_value = "F", names = "only ambiguous")
# list_of_names(sex_value = "F", names = "only unambiguous")

