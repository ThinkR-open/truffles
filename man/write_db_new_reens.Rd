% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_db_new_reens.R
\name{write_db_new_reens}
\alias{write_db_new_reens}
\title{Write new reensemencement data to the database}
\usage{
write_db_new_reens(
  conn = connect_db(),
  theidoak,
  date_reens,
  digest_ = Sys.time()
)
}
\arguments{
\item{conn}{A connection to the database.}

\item{theidoak}{The ID of the oak tree (oak) where the truffle was found.}

\item{date_reens}{The date of the reensemencement.}

\item{digest_}{The digest of the reensemencement data.}
}
\description{
This function writes new reensemencement data to the specified database table.
}
\examples{
# write_db_new_reens(theidoak = "chene")
}
