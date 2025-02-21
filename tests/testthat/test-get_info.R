
test_that("get_info works", {
  # Creating test data
  dbchene <- data.frame(
    id = c("1", "2", "3"),
    type = c("Green oak", "Sessile oak", "Pedunculate oak"),
    date_plantation = c("2020-01-01", "2018-03-15", "2019-06-20")
  )

  dbtruffe <- data.frame(
    idchene = c("1", "1", "2", "3", "3"),
    poids = c(100, 150, 200, 50, 75),
    date_trouve = c(
      "2024-01-01",
      "2024-02-01",
      "2024-03-01",
      "2024-04-01",
      "2024-05-01"
    ),
    commentaires = c(
            "Beautiful truffle", 
            "Exceptional truffle",
            "Medium truffle",
            "Small truffle",
            "Medium truffle"
    )
  )

  dbreensemence <- data.frame(
    idchene = c("1", "4", "4"),
    date_reens = c("2024-01-01", "2012-03-15", "2021-06-20")
  )
  # Test quand le chene n'existe pas dans la base de donnees
  expected_output0 <- list(
    chene = list(
      type = character(0),
      date_plantation = structure(numeric(0), class = "Date")
    ),
    truffes = list(
      poids_tot = 0,
      derniere_truffe = "-",
      comments = "-"
    ),
    reensemence = as.Date("2021-06-20")
  )

  expect_equal(get_info(dbchene, dbtruffe, dbreensemence, "4"), expected_output0)

  # Test quand le chene existe dans la base de donnees
  expected_output <-
    list(
      chene = list(
        type = "Pedunculate oak",
        date_plantation = structure(18067, class = "Date")
      ),
      truffes = list(
        poids_tot = 125,
        derniere_truffe = structure(19844, class = "Date"),
        comments = "2024-04-01 : Small truffle<br>2024-05-01 : Medium truffle"
      ),
      reensemence = "-"
    )
  expect_equal(get_info(dbchene, dbtruffe, dbreensemence, "3"), expected_output)
})
