library(readr)
library(dplyr)
conversion_table <- read_csv("data_retrieval/conv.csv")
names(conversion_table) <- tolower(names(conversion_table))
names(conversion_table) <- gsub(" ", "_", names(conversion_table))
conversion_table <- filter(conversion_table, !is.na(a))
conversion_table <- as.data.frame(conversion_table)



if(length(conversion_table$catalog_symbol) == length(unique(conversion_table$catalog_symbol))){
  save(conversion_table, file = "data/conversion table.RData")
} else {
  stop("catalog symbols not unique")
}
