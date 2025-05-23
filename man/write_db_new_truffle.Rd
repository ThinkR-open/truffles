% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_db_new_truffle.R
\name{write_db_new_truffle}
\alias{write_db_new_truffle}
\title{Write new truffle data to the database}
\usage{
write_db_new_truffle(
  conn = connect_db(),
  theidoak,
  date_found,
  weight,
  estimation,
  comment,
  digest_ = Sys.time()
)
}
\arguments{
\item{conn}{A connection to the database.}

\item{theidoak}{The ID of the oak tree (oak) where the truffle was found.}

\item{date_found}{The date the truffle was found.}

\item{weight}{The weight of the truffle in grams.}

\item{estimation}{logical indicating whether the weight was estimated or not.}

\item{comment}{Any additional comments related to the truffle.}

\item{digest_}{The digest of the truffle.}
}
\description{
This function writes new truffle data to the specified database table.
}
\examples{
# write_db_new_truffle(theidoak = "chene")
}
