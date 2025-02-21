
test_that("get_info works", {
  # Création de données de test
  dbchene <- data.frame(
    id = c("1", "2", "3"),
    type = c("Chêne vert", "Chêne rouvre", "Chêne pédonculé"),
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
      "Belle truffe",
      "Truffe exceptionnelle",
      "Truffe moyenne",
      "Truffe petite",
      "Truffe moyenne"
    )
  )

  dbreensemence <- data.frame(
    idchene = c("1", "4", "4"),
    date_reens = c("2024-01-01", "2012-03-15", "2021-06-20")
  )
  # Test quand le chêne n'existe pas dans la base de données
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

  # Test quand le chêne existe dans la base de données
  expected_output <-
    list(
      chene = list(
        type = "Chêne pédonculé",
        date_plantation = structure(18067, class = "Date")
      ),
      truffes = list(
        poids_tot = 125,
        derniere_truffe = structure(19844, class = "Date"),
        comments = "2024-04-01 : Truffe petite<br>2024-05-01 : Truffe moyenne"
      ),
      reensemence = "-"
    )
  expect_equal(get_info(dbchene, dbtruffe, dbreensemence, "3"), expected_output)
})
