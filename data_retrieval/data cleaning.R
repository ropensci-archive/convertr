library(readr)
library(dplyr)
conversion_table <- read_csv("data_retrieval/conv.csv")
conversion_table <- conversion_table[, 1:10]

names(conversion_table) <- tolower(names(conversion_table))
names(conversion_table) <- gsub(" ", "_", names(conversion_table))
conversion_table <- filter(conversion_table, !is.na(a))
conversion_table <- as.data.frame(conversion_table)

conversion_table$a <- as.numeric(conversion_table$a)
conversion_table$b <- as.numeric(conversion_table$b)
conversion_table$c <- as.numeric(conversion_table$c)
conversion_table$d <- as.numeric(conversion_table$d)

#Identify whether a base unit has more than one unit which it can convert to.
multiple_units <- conversion_table %>%
  group_by(base_unit) %>%
  tally() %>%
  filter(n > 1) %>%
  .$base_unit

conversion_table$multi_unit <- conversion_table$base_unit %in% multiple_units

if(length(conversion_table$catalog_symbol) == length(unique(conversion_table$catalog_symbol))){
  devtools::use_data(conversion_table, internal = TRUE, overwrite = TRUE)
} else {
  stop("catalog symbols not unique")
}

