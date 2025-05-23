# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Amend DESCRIPTION with dependencies read from package code parsing
## install.packages('attachment') # if needed.
attachment::att_amend_desc()

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "carto_leaflet", with_test = TRUE) # Name of the module
golem::add_module(name = "dataviz", with_test = TRUE) # Name of the module

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct("helpers", with_test = TRUE)
golem::add_utils("helpers", with_test = TRUE)

## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file("utils")
golem::add_js_handler("handlers")
golem::add_css_file("custom")
golem::add_sass_file("custom")


golem::use_external_js_file("https://unpkg.com/leaflet@1.9.4/dist/leaflet.js")
golem::use_external_css_file("https://unpkg.com/leaflet@1.9.4/dist/leaflet.css")
golem::add_js_handler("leaflet_.js")

golem::use_external_js_file(url = "https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js")
golem::add_js_handler("chartjs_.js")

golem::use_external_js_file(url = "https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js")
golem::use_external_css_file(url = "https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css")
golem::add_js_handler("sweetalert2_.js")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "chenes_feularde", open = FALSE)

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# Documentation


usethis::use_pkgdown()
pkgdown::build_site(override = list(destination = "inst/site"))


## Vignette ----
usethis::use_vignette("truffles")
usethis::use_vignette("truffles_dev")
devtools::build_vignettes()

usethis::use_code_of_conduct("murielle@thinkr.fr")

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
##
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action()
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release()
usethis::use_github_action_check_standard()
usethis::use_github_action_check_full()
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis()
usethis::use_travis_badge()

# AppVeyor
usethis::use_appveyor()
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()
gitlabr::use_gitlab_ci(type = "check-coverage-pkgdown")

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
