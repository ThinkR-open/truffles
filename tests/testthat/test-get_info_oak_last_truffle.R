
test_that("get_info_oak_last_truffle works", {
  expect_true(inherits(get_info_oak_last_truffle, "function"))

  dbtruffle <- data.frame(
    idoak = c("123", "123", "456", "789"),
    estimation = c(1, 0, 1, 0),
    weight = c(NA, 5, 10, 100),
    date_found = as.Date(c("2023-01-01", "2023-03-15", "2023-02-01", "2022-12-01"))
  )
  # Case where the specified tree has truffles in the database
  expect_equal(nrow(get_info_oak_last_truffle(dbtruffle, "123")), 1)
  expect_equal(get_info_oak_last_truffle(dbtruffle, "123")$idoak, "123")
  expect_equal(get_info_oak_last_truffle(dbtruffle, "123")$date_found, as.Date("2023-03-15"))

  expect_equal(get_info_oak_last_truffle(dbtruffle, "123", filter_missing_info = TRUE)$date_found, as.Date("2023-01-01"))


  # Case where the specified tree does not exist in the database
  expect_equal(nrow(get_info_oak_last_truffle(dbtruffle, "999")), 0)
})
