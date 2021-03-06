% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{haversine_dist}
\alias{haversine_dist}
\title{Distance between coordinate (Haversine method)}
\usage{
haversine_dist(long1, lat1, long2, lat2)
}
\arguments{
\item{long1}{float, longitude of the first coordinate}

\item{lat1}{float, latitude of the first coordinate}

\item{long2}{float, longitude of the second coordinate}

\item{lat2}{float, latitude of the second coordinate}
}
\description{
Calculate distance in meters between two coordinates (latitude, longitude).
}
\seealso{
https://www.movable-type.co.uk/scripts/latlong.html
}
