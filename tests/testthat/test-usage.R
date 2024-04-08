test_that("Usage works", {
  conn <- connect_db()

  chenes_feularde_ <- dbReadTable(conn, name = "chenes_feularde")

  DBI::dbDisconnect(conn)
  # Creation d'une DB temporaire pour les tests:
  conn_usage <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Création de la table truffe dans la base de données
  DBI::dbWriteTable(
    conn_usage,
    "truffe",
    data.frame(
      idtruffe = character(),
      idchene = character(),
      date_trouve = numeric(),
      poids = numeric(),
      estimation = logical(),
      commentaires = character()
    )
  )

  DBI::dbWriteTable(
    conn_usage,
    "chenes_feularde",
    chenes_feularde_
  )

  chenes_feularde <- dbReadTable(conn_usage, name = "chenes_feularde")
  truffe <- dbReadTable(conn_usage, name = "truffe")


  ######################################
  chenes_feularde <- chenes_feularde |>
    dplyr::filter(present == 1)

  df_prep <- prepare_leaflet(
    dbchene = chenes_feularde,
    dbtruffe = truffe
  )

  ######################################
  # ADD A NEW TRUFFLE WITH ALL INFO
  theidchene <- sample(
    df_prep$data_prep |>
      purrr::map(1),
    size = 1
  ) [[1]]

  info <- get_info(dbchene = chenes_feularde, dbtruffe = truffe, theidchene = theidchene)

  write_db_new_truffe(
    conn = conn_usage,
    theidchene = theidchene,
    date_trouvee = "2024-01-01",
    poids = 25,
    estimation = 0,
    comment = "Un commentaire"
  )

  ######################################
  # ADD A NEW TRUFFLE WITHOUT WEIGHT

  theidchene <- sample(
    df_prep$data_prep |>
      purrr::map(1),
    size = 1
  ) [[1]]

  info <- get_info(dbchene = chenes_feularde, dbtruffe = truffe, theidchene = theidchene)

  write_db_new_truffe(
    conn = conn_usage,
    theidchene = theidchene,
    date_trouvee = "2024-01-01",
    poids = NA,
    estimation = 1,
    comment = "Un commentaire"
  )

  ######################################
  # ADD A NEW TRUFFLE WITH ESTIMATE WEIGHT

  theidchene <- sample(
    df_prep$data_prep |>
      purrr::map(1),
    size = 1
  )[[1]]

  info <- get_info(dbchene = chenes_feularde, dbtruffe = truffe, theidchene = theidchene)

  write_db_new_truffe(
    conn = conn_usage,
    theidchene = theidchene,
    date_trouvee = "2024-01-01",
    poids = 100,
    estimation = 1,
    comment = "Un commentaire"
  )

  truffe <- dbReadTable(conn_usage, name = "truffe")

  expect_equal(nrow(truffe), 3)

  DBI::dbDisconnect(conn_usage)
})
