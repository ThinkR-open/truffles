
test_that("get_info_chene_last_truffe works", {
  expect_true(inherits(get_info_chene_last_truffe, "function"))

  dbtruffe <- data.frame(
    idchene = c("123", "123", "456", "789"),
    estimation = c(1, 0, 1, 0),
    poids = c(NA, 5, 10, 100),
    date_trouve = as.Date(c("2023-01-01", "2023-03-15", "2023-02-01", "2022-12-01"))
  )
  # Case where the specified tree has truffles in the database
  expect_equal(nrow(get_info_chene_last_truffe(dbtruffe, "123")), 1)
  expect_equal(get_info_chene_last_truffe(dbtruffe, "123")$idchene, "123")
  expect_equal(get_info_chene_last_truffe(dbtruffe, "123")$date_trouve, as.Date("2023-03-15"))

  expect_equal(get_info_chene_last_truffe(dbtruffe, "123", filter_missing_info = TRUE)$date_trouve, as.Date("2023-01-01"))


  # Case where the specified tree does not exist in the database
  expect_equal(nrow(get_info_chene_last_truffe(dbtruffe, "999")), 0)
})
