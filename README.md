# convertr

An R package for converting things to other things. Not on cran but hopefully can be installed using:

```
install.packages("devtools")
devtools::install_github("GShotwell/convertr")
```

There's only one function which converts a numerical vectors from one unit to another. 

```
convert(1:20, "kg", "g")
convert(1:20, "sq yd", "km2")

/don't run
convert(1:20, "kg", "km2)
```
