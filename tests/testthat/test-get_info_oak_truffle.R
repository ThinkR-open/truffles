
test_that("get_info_oak_truffle works", {
  dbtruffle <- data.frame(
    idoak = c("1", "1", "2", "3", "3"),
    weight = c(100, 150, 200, 50, 75),
    date_found = c(
      "2024-01-01",
      "2024-02-01",
      "2024-03-01",
      "2024-04-01",
      "2024-05-01"
    ),
    comment = c(
      "Belle truffe",
      "Truffe exceptionnelle",
      "Truffe moyenne",
      "Truffe petite",
      "Truffe moyenne"
    )
  )

  # Test when oak does not exist in the database
  expect_equal(
    get_info_oak_truffle(dbtruffle, "4"),
    list(
      weight_tot = 0,
      last_truffle = "-",
      last_comment = "-",
      other_comments = "-"
    )
  )

  # Test when oak exists in the database
  expected_output <-
    list(
      weight_tot = 125,
      last_truffle = as.Date("2024-05-01"),
      last_comment = "2024-05-01 : Truffe moyenne",
      other_comments = "2024-04-01 : Truffe petite"
    )

  expect_equal(get_info_oak_truffle(dbtruffle, "3"), expected_output)



  dbtruffle <- data.frame(
    idoak = c("1"),
    weight = c(100),
    date_found = c(
      "2024-01-01"
    ),
    comment = c(
      "Belle truffe"
    )
  )

  expect_equal(get_info_oak_truffle(dbtruffle, "1"), list(
    weight_tot = 100, last_truffle = structure(19723, class = "Date"),
    last_comment = "2024-01-01 : Belle truffe", other_comments = "-"
  ))

})
