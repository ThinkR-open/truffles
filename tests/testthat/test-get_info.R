
test_that("get_info works", {
  # Creating test data
  dboak <- data.frame(
    idoak = c("1", "2", "3"),
    type = c("Green oak", "Sessile oak", "Pedunculate oak"),
    planting_date = c("2020-01-01", "2018-03-15", "2019-06-20")
  )

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
            "Beautiful truffle", 
            "Exceptional truffle",
            "Medium truffle",
            "Small truffle",
            "Medium truffle"
    )
  )

  dbreensemence <- data.frame(
    idoak = c("1", "4", "4"),
    date_reens = c("2024-01-01", "2012-03-15", "2021-06-20")
  )
  # Test quand le chene n'existe pas dans la base de donnees
  expected_output0 <- list(
    chene = list(
      type = character(0),
      planting_date = structure(numeric(0), class = "Date")
    ),
    truffes = list(
      weight_tot = 0,
      last_truffle = "-",
      last_comment = "-",
      other_comments = "-"
    ),
    reensemence = "2021-06-20"
  )

  expect_equal(get_info(dboak, dbtruffle, dbreensemence, "4"), expected_output0)

  # Test quand le chene existe dans la base de donnees
  expected_output <-
    list(
      chene = list(
        type = "Pedunculate oak",
        planting_date = structure(18067, class = "Date")
      ),
      truffes = list(
        weight_tot = 125,
        last_truffle = structure(19844, class = "Date"),
        last_comment = "2024-05-01 : Medium truffle",
        other_comments = "2024-04-01 : Small truffle"
      ),
      reensemence = "-"
    )
  expect_equal(get_info(dboak, dbtruffle, dbreensemence, "3"), expected_output)
})
