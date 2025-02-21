
test_that("connect_db works", {
  conn <- connect_db()

  # Vérifier que la connexion est valide
  expect_s4_class(conn, "SQLiteConnection")
})
