
test_that("get_info_chene works", {
  dbchene <- data.frame(
    id = c("1", "2", "3"),
    type = c("Green oak", "Sessile oak", "Pedunculate oak"),
    date_plantation = c("2020-01-01", "2018-03-15", "2019-06-20")
  )

  # Test quand le chene n'existe pas dans la base de donnees
  expect_equal(
    get_info_chene(dbchene, "4"),
    list(
      type = character(0),
      date_plantation = structure(numeric(0), class = "Date")
    )
  )

  # Test quand le chene existe dans la base de donnees
  expect_equal(
    get_info_chene(dbchene, "2"),
    list(type = "Sessile oak", date_plantation = as.Date("2018-03-15"))
  )

  expect_error(get_info_chene(iris, "2"))

  expect_error(get_info_chene(iris, mtcars), regexp = "theidchene must be a character")
})
