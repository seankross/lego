#' LEGO set data
#'
#' Data about every LEGO set from 1970 to 2014.
#'
#' @source \url{http://brickset.com/}, downloaded 2014-08-06
#' @format A data frame with columns:
#' \describe{
#'  \item{Item_Number}{Item number for each LEGO set}
#'  \item{Name}{Name of set}
#'  \item{Year}{Year set was manufactured}
#'  \item{Theme}{Theme of set}
#'  \item{Subtheme}{Subtheme of set. Sets with no subtheme have an empty string
#'    \code{""} for subtheme.}
#'  \item{Pieces}{Number of pieces in set. Sets with \code{NA} pieces have an
#'    unknown number of pieces.}
#'  \item{Minifigures}{Number of minifigures in set. The vast majority of sets 
#'    with \code{NA} minifigures contain zero minifigures, however there 
#'    are a few exceptions.}
#'  \item{Image_URL}{URL to an image of the set}
#'  \item{GBP_MSRP}{Price of set in British Pounds (\code{NA} if price unavailable)}
#'  \item{USD_MSRP}{Price of set in US Dollars (\code{NA} if price unavailable)}
#'  \item{CAD_MSRP}{Price of set in Canadian Dollars (\code{NA} if price unavailable)}
#'  \item{EUR_MSRP}{Price of set in Euros (\code{NA} if price unavailable)}
#'  \item{Packaging}{Type of packaging for set}
#'  \item{Availability}{Availability of set}
#' }
#' @examples
#'  legosets
"legosets"
