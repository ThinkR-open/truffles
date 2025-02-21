
test_that("prepare_leaflet works", {
  expect_true(inherits(prepare_leaflet, "function"))

  dbchene <- data.frame(
    id = c(1, 2, 3),
    chene_nom = c("Oak 1", "Oak 2", "Oak 3")
  )
  dbtruffe <- data.frame(
    idchene = c(1, 2, 3),
    estimation = c(1, 0, 1),
    poids = c(10, 15, NA)
  )

  # Execute function
  leaflet_data <- prepare_leaflet(dbchene, dbtruffe)

  # Check output type
  expect_type(leaflet_data, "list")

  # Check that the list length is correct
  expect_equal(length(leaflet_data$data_prep), nrow(dbchene))
})
