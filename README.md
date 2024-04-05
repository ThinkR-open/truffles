
<!-- README.md is generated from README.Rmd. Please edit that file -->

# truffles

<!-- badges: start -->
<!-- badges: end -->

R Package for Truffle Orchard Mapping and Management

truffles is an R package designed to facilitate the visualization and
management of truffle orchards through a mobile application format. With
truffles, users can efficiently map out truffle orchards, visualize them
cartographically, and interactively manage truffle-related data.

## Features

- **Cartographic Visualization**: truffles enables users to visualize
  truffle orchards on a map interface, providing a comprehensive
  overview of the orchard layout.

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
remotes::install_gitlab("https://gitlab.com/MurielleDelmotte/truffles")
```

## Getting Started

After installation, you can load the truffles package in R and launch
the mobile application using the following commands:

``` r
library(truffles)
run_app()
```
