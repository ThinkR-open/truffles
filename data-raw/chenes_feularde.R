## code to prepare `chenes_feularde` dataset goes here

library(geojsonio)
library(dplyr)
library(RSQLite)

# chenes_feularde <- geojson_read("data-raw/map(2).geojson")
dates <- seq(as.Date("2015-01-01"), as.Date("2015-12-31"), by = "day")

chenes_feularde <- readr::read_csv("data-raw/points(4).csv")
chenes_feularde <- chenes_feularde |>
  mutate(id = paste0("chenes", row_number())) |>
  mutate(
    type = sample(c("A", "B", "C"), size = 1),
    date_plantation = sample(dates, size = 1)
  ) |>
  select(id, lat, lon, type, date_plantation)

conn <- dbConnect(SQLite(), "inst/chenes_truffe.sqlite")
dbWriteTable(conn, "chenes_feularde", chenes_feularde, overwrite = TRUE)

dates <- seq(as.Date("2022-01-01"), as.Date("2024-01-31"), by = "day")
truffe <- data.frame(
  id_truffe = paste0("truffe", 1:100),
  id_chene = sample(chenes_feularde$id, 100, replace = TRUE),
  date_trouve = sample(dates, size = 100, replace = TRUE),
  poids = sample(c(1:200), 100, replace = TRUE)
)
dbWriteTable(conn, "truffe", truffe, overwrite = TRUE)

col_names <- c("id_chene", "date_reens")
reens <- data.frame(matrix(ncol = length(col_names), nrow = 0))
colnames(reens) <- col_names

dbWriteTable(conn, "reens", reens, overwrite = TRUE)
DBI::dbDisconnect(conn)
