
test_that("update_db_truffe works", {
  expect_true(inherits(update_db_truffe, "function"))

  conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Creating the truffle table in the database
  DBI::dbWriteTable(
    conn,
    "truffe",
    data.frame(
      idtruffe = "156",
      idchene = "15",
      date_trouve = 18294,
      poids = 12,
      estimation = 1,
      commentaires = "Comment"
    )
  )

  update_db_truffe(
    conn,
    idtruffe = "156",
    idchene = "15",
    date_trouve = 18294,
    poids = 22,
    estimation = 0,
    commentaires = "New comment"
  )

  # Check that the truffle has been correctly added to the database
  expected_output <-
    data.frame(
      idtruffe = "156",
      idchene = "15",
      date_trouve = 18294,
      poids = 22,
      estimation = 0,
      commentaires = formater_comment("New comment")
    )
  expect_equal(
    DBI::dbReadTable(conn, "truffe") |>
      dplyr::filter(idtruffe == "156"),
    expected_output
  )
})
