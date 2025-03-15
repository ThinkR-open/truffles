
test_that("get_info_chene_truffe works", {
  dbtruffe <- data.frame(
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
    get_info_chene_truffe(dbtruffe, "4"),
    list(
      weight_tot = 0,
      derniere_truffe = "-",
      last_comment = "-",
      other_comments = "-"
    )
  )

  # Test when oak exists in the database
  expected_output <-
    list(
      weight_tot = 125,
      derniere_truffe = as.Date("2024-05-01"),
      last_comment = "2024-05-01 : Truffe moyenne",
      other_comments = "2024-04-01 : Truffe petite"
    )

  expect_equal(get_info_chene_truffe(dbtruffe, "3"), expected_output)
})
