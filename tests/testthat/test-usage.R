test_that("Usage works", {
  conn <- connect_db()

  chenes_feularde_ <- dbReadTable(conn, name = "chenes_feularde")
  reens_ <- dbReadTable(conn, name = "reens")

  DBI::dbDisconnect(conn)
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
    chenes_feularde_
  )

  DBI::dbWriteTable(
    conn_usage,
    "reens",
    reens_
  )

  chenes_feularde <- dbReadTable(conn_usage, name = "chenes_feularde")
  truffe <- dbReadTable(conn_usage, name = "truffe")
  reens <- dbReadTable(conn_usage, name = "reens")


  ######################################
  chenes_feularde <- chenes_feularde |>
    dplyr::filter(present == 1)

  df_prep <- prepare_leaflet(
    dbchene = chenes_feularde,
    dbtruffe = truffe
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
