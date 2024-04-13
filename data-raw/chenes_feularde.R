## code to prepare `chenes_feularde` dataset goes here

library(geojsonio)
library(dplyr)
library(RSQLite)

# chenes_feularde <- geojson_read("data-raw/map(2).geojson")
dates <- as.numeric(seq(as.Date("2015-01-01"), as.Date("2015-12-31"), by = "day"))

chenes_feularde <- readr::read_csv("data-raw/points(5).csv")
chenes_feularde <- chenes_feularde |>
  mutate(
    ID = as.character(ID),
    date_plantation = sample(dates, size = 1),
    Present = case_when(
      is.na(Present) ~ TRUE,
      TRUE ~ Present
    ),
    Type = case_when(
      is.na(Type) ~ "Normal",
      TRUE ~ "Green"
    )
  ) |>
  janitor::clean_names()

chenes_feularde$reensemence <- sample(c(0, 1), size = nrow(chenes_feularde), replace = TRUE)


conn <- dbConnect(SQLite(), "inst/chenes_truffe.sqlite")
dbWriteTable(conn, "chenes_feularde", chenes_feularde, overwrite = TRUE)

dates <- as.numeric(seq(as.Date("2022-01-01"), as.Date("2024-01-31"), by = "day"))
truffe <- data.frame(
  idtruffe = paste0("truffe", 1:100),
  idchene = sample(chenes_feularde$id, 100, replace = TRUE) |> as.character(),
  date_trouve = sample(dates, size = 100, replace = TRUE),
  poids = sample(c(1:200), 100, replace = TRUE),
  commentaires = paste(c(1:100), "- commentaires")
)

truffe$estimation <- 0
truffe$estimation[c(1, 2, 10)] <- 1

dbWriteTable(conn, "truffe", truffe, overwrite = TRUE)

reens <- data.frame(
  idchene = chenes_feularde |>
    filter(reensemence == 1) |>
    pull(id)
)

reens$date_reens <- sample(dates, size = nrow(reens), replace = TRUE)


dbWriteTable(conn, "reens", reens, overwrite = TRUE)
DBI::dbDisconnect(conn)
