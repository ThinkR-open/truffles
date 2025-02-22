
test_that("update_db_truffe works", {
  expect_true(inherits(update_db_truffe, "function"))

  conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Creating the truffle table in the database
  DBI::dbWriteTable(
    conn,
    "truffe",
    data.frame(
      idtruffle = "156",
      idoak = "15",
      date_found = 18294,
      weight = 12,
      estimation = 1,
      comment = "Comment"
    )
  )

  update_db_truffe(
    conn,
    idtruffle = "156",
    idoak = "15",
    date_found = 18294,
    weight = 22,
    estimation = 0,
    comment = "New comment"
  )

  # Check that the truffle has been correctly added to the database
  expected_output <-
    data.frame(
      idtruffle = "156",
      idoak = "15",
      date_found = 18294,
      weight = 22,
      estimation = 0,
      comment = formater_comment("New comment")
    )
  expect_equal(
    DBI::dbReadTable(conn, "truffe") |>
      dplyr::filter(idtruffle == "156"),
    expected_output
  )
})
