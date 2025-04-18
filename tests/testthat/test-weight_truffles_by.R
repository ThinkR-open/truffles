
test_that("weight_truffles_by works", {
  truffles <- data.frame(
    idoak = c("1", "1", "2", "2", "3", "3"),
    weight = c(100, 150, 200, 250, 50, 75),
    date_found = c("2024-01-01", "2024-02-01", "2024-03-01", "2024-03-15", "2024-04-01", "2024-05-01")
  )

  # Test avec une seule variable de groupement
  expected_output_1 <- tibble::tibble(annee = c(2024), weight = c(825))
  expect_equal(weight_truffles_by(truffles, annee = lubridate::year(as.Date(date_found))), expected_output_1)

  # Test avec deux variables de groupement
  expected_output_2 <- tibble::tibble(
    idoak = c("1", "2", "3"),
    annee = c(
      2024,
      2024,
      2024
    ),
    weight = c(250, 450, 125)
  )
  expect_equal(weight_truffles_by(truffles, idoak, annee = lubridate::year(as.Date(date_found))), expected_output_2)
})
