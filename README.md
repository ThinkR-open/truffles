
<!-- README.md is generated from README.Rmd. Please edit that file -->

# truffles <img src="man/figures/hex-truffles.png" align="right" alt="" width="120" />

R package for mapping and managing a truffle tree plantation

truffles is an R package designed to facilitate the visualization and
management of a truffle tree plantation via a mobile application. With
truffles, users can efficiently map a truffle tree plantation, visualize
them cartographically and interactively manage truffle data.

## Features

- **Cartographic Visualization**: enables users to visualize truffle
  trees on a cartographic interface, providing an overview of the
  plantation layout.

- **Interactive Information Display**: Each truffle tree is clickable,
  allowing users to access detailed information such as planting date
  and total weight of truffles found.

- **Truffle Declaration and Recording**: Users can declare and record
  newly found truffles directly within the application. By specifying
  the weight of the truffle, users can maintain accurate records of
  truffle yields.

- **Yield Analysis**: truffles includes a dedicated tab for yield
  analysis, allowing users to generate graphical representations of
  truffle yields over different years. This feature aids in trend
  analysis and decision-making for orchard management.

## Installation

To install truffles, you can use the following command in your R
environment:

``` r
# install.packages("remotes")
remotes::install_github("Thinkr-open/truffles") # Stable development version
# remotes::install_github("Thinkr-open/truffles@dev") # Bleeding edge development version
```

## Getting Started

After installation, you can load the truffles package in R and launch
the mobile application using the following commands:

``` r
library(truffles)
run_app()
```

## Cartography tab

### Visualization of home page

![](man/figures/accueil.png)

### View information on truffles found to complete

![](man/figures/infoacompleter.png)

### Visualization of reseeded truffle oak trees

![](man/figures/reensemence.png)

## Graphics tab

### View truffle oak yields

![](man/figures/dataviz.png)

## Developper

The developer documentation is available in the pkgdown:
<https://thinkr-open.github.io/truffles/>
