test_that("connect_db works", {
  if (interactive()){

    conn <- connect_db()

    # Check that the connection is valid
    expect_s4_class(conn, "PqConnection")
  
  }
})
