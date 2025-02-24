test_that("Usage works", {

  # Creation d'une DB temporaire pour les tests:
  conn_usage <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Creating the truffle table in the database
  DBI::dbWriteTable(
    conn_usage,
    "truffe",
    data.frame(
      idtruffle = character(),
      idoak = character(),
      date_found = character(),
      weight = numeric(),
      estimation = logical(),
      comment = character()
    )
  )

  DBI::dbWriteTable(
    conn_usage,
    "chenes_feularde",
    structure(list(idoak = c("1", "2", "3", "4"), lon = c(
      1.53193333748493,
      1.53198654139325, 1.53203490858186, 1.53208085741133
    ), lat = c(
      47.9984324222873,
      47.9984696419663, 47.9985181893329, 47.99855540895
    ), type = c(
      "Normal",
      "Normal", "Normal", "Normal"
    ), present = c(
      TRUE, TRUE, TRUE,
      TRUE
    ), planting_date = c(
      "2015-05-20", "2015-05-20", "2015-05-20",
      "2015-05-20"
    )), row.names = c(NA, 4L), class = "data.frame")
  )

  DBI::dbWriteTable(
    conn_usage,
    "reens",
    structure(list(idreens = c(
      "e294c59bb131c6d58c836c323b1d7c69",
      "f19aaf4b06711b747f5272268b875941"
    ), idoak = c("19", "79"), date_reens = c(
      "2025-02-21",
      "2025-02-04"
    )), class = "data.frame", row.names = c(NA, -2L))
  )

  chenes_feularde <- dbReadTable(conn_usage, name = "chenes_feularde")
  truffe <- dbReadTable(conn_usage, name = "truffe")
  reens <- dbReadTable(conn_usage, name = "reens")


  ######################################
  chenes_feularde <- chenes_feularde |>
    dplyr::filter(present == 1)

  df_prep <- prepare_leaflet(
    dbchene = chenes_feularde,
    dbtruffe = truffe,
    dbreens = reens
  )

  ######################################
  # ADD A NEW TRUFFLE WITH ALL INFO
  theidoak <- sample(
    df_prep$data_prep |>
      purrr::map(1),
    size = 1
  )[[1]]

  info <- get_info(
    dbchene = chenes_feularde,
    dbtruffe = truffe,
    dbreensemence = reens,
    theidoak = theidoak
  )

  write_db_new_truffe(
    conn = conn_usage,
    theidoak = theidoak,
    date_found = "2024-01-01",
    weight = 25,
    estimation = 0,
    comment = "Un commentaire"
  )

  ######################################
  # ADD A NEW TRUFFLE WITHOUT WEIGHT

  theidoak <- sample(
    df_prep$data_prep |>
      purrr::map(1),
    size = 1
  )[[1]]

  info <- get_info(
    dbchene = chenes_feularde,
    dbtruffe = truffe,
    dbreensemence = reens,
    theidoak = theidoak
  )

  write_db_new_truffe(
    conn = conn_usage,
    theidoak = theidoak,
    date_found = "2024-01-01",
    weight = NA,
    estimation = 1,
    comment = "Un commentaire"
  )

  ######################################
  # ADD A NEW TRUFFLE WITH ESTIMATE WEIGHT

  theidoak <- sample(
    df_prep$data_prep |>
      purrr::map(1),
    size = 1
  )[[1]]

  info <- get_info(
    dbchene = chenes_feularde,
    dbtruffe = truffe,
    dbreensemence = reens,
    theidoak = theidoak
  )

  write_db_new_truffe(
    conn = conn_usage,
    theidoak = theidoak,
    date_found = "2024-01-01",
    weight = 100,
    estimation = 1,
    comment = "Un commentaire"
  )

  truffe <- dbReadTable(conn_usage, name = "truffe")

  expect_equal(nrow(truffe), 3)

  DBI::dbDisconnect(conn_usage)
})
