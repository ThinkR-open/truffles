
test_that("write_db_new_truffe works", {
  conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Creating the truffle table in the database
  DBI::dbWriteTable(
    conn,
    "truffe",
    data.frame(
      idtruffle = character(),
      idoak = numeric(),
      date_found = character(),
      weight = numeric(),
      estimation = logical(),
      comment = character()
    )
  )

  # write a new truffle to the database
  theidoak <- 1
  date_found <- "2024-03-08"
  weight <- 50
  comment <- "Freshly found truffle"
  estimation <- 1
  write_db_new_truffe(conn, theidoak, date_found, weight, estimation, comment, digest_ = date_found)

  # Check that the truffle has been correctly added to the database
  expected_output <-
    data.frame(
      idtruffle = digest::digest(date_found),
      idoak = 1,
      date_found = "2024-03-08",
      weight = 50,
      estimation = 1,
      comment = formater_comment("Freshly found truffle")
    )
  expect_equal(DBI::dbReadTable(conn, "truffe"), expected_output)
})
