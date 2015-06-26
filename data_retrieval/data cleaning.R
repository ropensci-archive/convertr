library(readr)
library(dplyr)
conversion_table <- read_csv("conv.csv")
names(conversion_table) <- tolower(names(conversion_table))
names(conversion_table) <- gsub(" ", "_", names(conversion_table))
conversion_table <- conversion_table[, 1:10]
conversion_table <- filter(conversion_table, !is.na(a))
save(conversion_table, file = "data/conversion table.RData")
