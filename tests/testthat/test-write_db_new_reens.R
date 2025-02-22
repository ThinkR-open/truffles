
test_that("write_db_new_reens works", {
  conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  # Creating the truffle table in the database
  DBI::dbWriteTable(
    conn,
    "reens",
    data.frame(
      idreens = character(),
      idoak = numeric(),
      date_reens = character()
    )
  )

  # write a new truffle to the database
  theidoak <- 1
  date_reens <- "2024-03-08"

  write_db_new_reens(conn, theidoak, date_reens, digest_ = date_reens)

  # Check that the truffle has been correctly added to the database
  expected_output <-
    data.frame(
      idreens = digest::digest(date_reens),
      idoak = 1,
      date_reens = "2024-03-08"
    )
  expect_equal(DBI::dbReadTable(conn, "reens"), expected_output)

  DBI::dbDisconnect(conn)
})
