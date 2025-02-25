## code to prepare `chenes` dataset goes here

library(geojsonio)
library(dplyr)
library(RSQLite)

# chenes <- geojson_read("data-raw/map(2).geojson")
dates <- as.character(seq(as.Date("2015-01-01"), as.Date("2015-12-31"), by = "day"))

chenes <- readr::read_csv("data-raw/points(5).csv")
chenes <- chenes |>
  mutate(
    idoak = as.character(ID),
    planting_date = sample(dates, size = 1),
    Present = case_when(
      is.na(Present) ~ TRUE,
      TRUE ~ Present
    ),
    Type = case_when(
      is.na(Type) ~ "Normal",
      TRUE ~ "Green"
    )
  ) |>
  select(-ID) |>
  janitor::clean_names()

chenes$reensemence <- sample(c(0, 1), size = nrow(chenes), replace = TRUE)

#readr::write_csv(chenes, "chenes_truffe.csv")

conn <- dbConnect(SQLite(), "inst/chenes_truffe.sqlite")
dbWriteTable(conn, "chenes", chenes, overwrite = TRUE)

dates <- as.character(seq(as.Date("2022-01-01"), as.Date("2024-01-31"), by = "day"))
truffe <- data.frame(
  idtruffle = paste0("truffe", 1:100),
  idoak = sample(chenes$idoak, 100, replace = TRUE) |> as.character(),
  date_found = sample(dates, size = 100, replace = TRUE),
  weight = sample(c(1:200), 100, replace = TRUE),
  comment = paste(c(1:100), "- comment")
)

truffe$estimation <- 0
truffe$estimation[c(1, 2, 10)] <- 1
#readr::write_csv(truffe, "truffe.csv")

dbWriteTable(conn, "truffe", truffe, overwrite = TRUE)

reens <- data.frame(
  idoak = chenes |>
    filter(reensemence == 1) |>
    pull(idoak)
)

reens$date_reens <- sample(dates, size = nrow(reens), replace = TRUE)
reens <- reens |>
  mutate(idreens = row_number()) |>
  select(idreens, everything())

#readr::write_csv(reens, "reens.csv")

dbWriteTable(conn, "reens", reens, overwrite = TRUE)
DBI::dbDisconnect(conn)
