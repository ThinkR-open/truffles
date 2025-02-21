
test_that("get_info_chene_truffe works", {
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

  # Test quand le chêne n'existe pas dans la base de données
  expect_equal(
    get_info_chene_truffe(dbtruffe, "4"),
    list(
      poids_tot = 0,
      derniere_truffe = "-",
      comments = "-"
    )
  )

  # Test quand le chêne existe dans la base de données
  expected_output <-
    list(
      poids_tot = 125,
      derniere_truffe = as.Date("2024-05-01"),
      comments = "2024-04-01 : Truffe petite<br>2024-05-01 : Truffe moyenne"
    )

  expect_equal(get_info_chene_truffe(dbtruffe, "3"), expected_output)
})
