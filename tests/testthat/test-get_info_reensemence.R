
test_that("get_info_reensemence works", {
  expect_true(inherits(get_info_reensemence, "function"))
  expect_error(get_info_reensemence("not a data frame", "theidoak"), "dbreensemence must be a data.frame")
  expect_error(get_info_reensemence(data.frame(), 123), "theidoak must be a character")

  dbreensemence <- data.frame(
    idoak = c("theidoak", "otherid", "theidoak"),
    date_reens = c(as.Date("2022/01/01"), as.Date("2024/01/02"), as.Date("2024/01/05"))
  )
  expect_equal(get_info_reensemence(dbreensemence, "nonexistentid"), "-")
  expect_equal(get_info_reensemence(dbreensemence, "theidoak"), "2024-01-05")
})
