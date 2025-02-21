
test_that("write_db_new_truffe works", {
  conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Création de la table truffe dans la base de données
  DBI::dbWriteTable(
    conn,
    "truffe",
    data.frame(
      idtruffe = character(),
      idchene = numeric(),
      date_trouve = numeric(),
      poids = numeric(),
      estimation = logical(),
      commentaires = character()
    )
  )

  # Écrire une nouvelle truffe dans la base de données
  theidchene <- 1
  date_trouvee <- "2024-03-08"
  poids <- 50
  comment <- "Truffe fraîchement trouvée"
  estimation <- 1
  write_db_new_truffe(conn, theidchene, date_trouvee, poids, estimation, comment, digest_ = date_trouvee)

  # Vérifier si la truffe a été correctement ajoutée à la base de données
  expected_output <-
    data.frame(
      idtruffe = digest::digest(date_trouvee),
      idchene = 1,
      date_trouve = 19790,
      poids = 50,
      estimation = 1,
      commentaires = formater_comment("Truffe fraîchement trouvée")
    )
  expect_equal(DBI::dbReadTable(conn, "truffe"), expected_output)
})
