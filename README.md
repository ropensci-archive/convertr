# convertr

[![Travis-CI Build Status](https://travis-ci.org/GShotwell/convertr.svg?branch=master)](https://travis-ci.org/GShotwell/convertr)

An R package for converting things to other things. The package is not on CRAN but can be installed using:

```
install.packages("devtools")
devtools::install_github("GShotwell/convertr")
```

The package contains one function which converts numerical vectors from one unit to another. Data on conversion factors comes from the [POSC Units of Measure Dictionary v2.2](http://w3.energistics.org/uom/poscUnits22.xml) and [Wikipedia](https://en.wikipedia.org/wiki/Conversion_of_units). 

```
convert(1:20, "kg", "g")
convert(1:20, "sq yd", "km2")

#This will produce and error
convert(1:20, "kg", "km2)
```

You can also launch a shiny gadget to explore the available units either with `convert_gadget()` or through the addin menu. To access the addin make sure you are using a recent version of RStudio. 

![Gadget Animation](inst/media/convertr_gif.gif)

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
