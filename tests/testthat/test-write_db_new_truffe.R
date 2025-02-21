
test_that("write_db_new_truffe works", {
  conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Creating the truffle table in the database
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

  # write a new truffle to the database
  theidchene <- 1
  date_trouvee <- "2024-03-08"
  poids <- 50
  comment <- "Freshly found truffle"
  estimation <- 1
  write_db_new_truffe(conn, theidchene, date_trouvee, poids, estimation, comment, digest_ = date_trouvee)

  # Check that the truffle has been correctly added to the database
  expected_output <-
    data.frame(
      idtruffe = digest::digest(date_trouvee),
      idchene = 1,
      date_trouve = 19790,
      poids = 50,
      estimation = 1,
      commentaires = formater_comment("Freshly found truffle")
    )
  expect_equal(DBI::dbReadTable(conn, "truffe"), expected_output)
})
