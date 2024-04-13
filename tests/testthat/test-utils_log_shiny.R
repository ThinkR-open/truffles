test_that("utils log shiny works", {
  
expect_type(info("fakeinfo"), "character")
expect_type(danger("fakedanger"), "character")
expect_type(rule("fakerule"), "character")
expect_type(log_info_dev("fake"), "character")
expect_type(log_danger_dev("fake"), "character")
expect_type(log_rule_dev("fake"), "character")

})
