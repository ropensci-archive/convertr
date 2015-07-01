library(readr)
library(dplyr)
conversion_table <- read_csv("data_retrieval/conv.csv")
names(conversion_table) <- tolower(names(conversion_table))
names(conversion_table) <- gsub(" ", "_", names(conversion_table))
conversion_table <- filter(conversion_table, !is.na(a))
conversion_table <- as.data.frame(conversion_table)

conversion_table$a <- as.numeric(conversion_table$a)
conversion_table$b <- as.numeric(conversion_table$b)
conversion_table$c <- as.numeric(conversion_table$c)
conversion_table$d <- as.numeric(conversion_table$d)


if(length(conversion_table$catalog_symbol) == length(unique(conversion_table$catalog_symbol))){
  save(conversion_table, file = "data/conversion table.RData")
} else {
  stop("catalog symbols not unique")
}
