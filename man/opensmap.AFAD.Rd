% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_AFAD.R
\name{opensmap.AFAD}
\alias{opensmap.AFAD}
\title{Mapping of earthquake data using OpenStreetMap}
\usage{
opensmap.AFAD(
  eqdata = NULL,
  gap = NULL,
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  xlab = NULL,
  ylab = NULL,
  col = NULL,
  size = NULL,
  pch = NULL,
  minnumtiles = NULL
)
}
\arguments{
\item{eqdata}{Earthquake data as data frame  from AFAD's \emph{Event Web Service}.}

\item{gap}{Adds some extra region to the map according to minimum and maximum longitude and latitude values of observed events in degrees to prevent events shown at the edges of the map.}

\item{title}{The text for the title.}

\item{subtitle}{The text for the subtitle.}

\item{caption}{The text for the caption.}

\item{xlab, ylab}{Axes titles.}

\item{col}{Coloring of the plotting character.}

\item{size}{Size of the plotting character.}

\item{pch}{Plotting character.}

\item{minnumtiles}{Argument to be passed to other argument with the same name of \strong{openmap} from \emph{OpenStreetMap} which is set to 4 as default.}
}
\description{
Plots some simple charts described in the service depending on package \strong{OpenStreetMap} of the earthquake data from Event Web Service API provided by AFAD (Disaster and Emergency Management Authority of Republic of Turkiye).
}
\examples{
equake=read.AFAD(start = "2023-08-01",end="2023-08-15",lat=27.142826,lon=38.423733,maxrad=format(100000,scientific=FALSE))
opensmap.AFAD(equake,gap=.5,title="Radial Search Plot",xlab="Boylam",ylab="Enlem")
}
