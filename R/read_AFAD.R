#' Read earthquake data from AFAD Event Web Service
#' 
#' Downloads earthquake data from AFAD (Disaster and Emergency Management Authority of Republic of Turkiye) using _Earthquake Web Service_ API provided by AFAD.
#' 
#' @param eventid A unique ID number assigned to an event by the database. **eventid** suppresses all other arguments.
#' @param start,end Time constraints limiting events occurring on or after the specified start time to on or before the specified end time. These constraints are required for all filters except _eventid_. 
#' @param minlat,maxlat,minlon,maxlon Southern, northern, western and eastern boundaries of the box search in _degrees_, respectively. At least one of these constraints should be filled. If there is at least one empty constraint, the filter will declare boundaries and execute filtration.Box search is incompatible with radial search.
#' @param lat,lon,maxrad,minrad Specifies the latitude and longitude of a geographic point as a center point in _degrees_. Using maximum and minimum distances from this geographic point in _meters_ defines a _radial_ or a _circular_ search according to minimum distance, respectively. These constraints should be given by user, except _**minrad**_.
#' @param minmag,maxmag,magtype Limit to events from a magnitude larger than or equal to the specified minimum to a magnitude smaller than or equal to the specified maximum in _float_ by type of magnitude in _text_ used to test minimum and maximum limits, respectively.
#' @param mindepth,maxdepth Limits to events from depths equal to or greater than the specified depth to depths less than or equal to the specified depth in _km_, respectively.
#' @param orderby Valid orderby argument includes _*time*_ order by origin ascending time as _default_, _*timedesc*_ order by origin descending time, _*magnitude*_ order by ascending magnitude, _*magnitudedesc*_ order by descending magnitude in _text_.
#' @param eventid	A unique ID number assigned to an event by the database. eventid suppresses all other arguments.
#' @format NULL
#' @return A data frame of earthquake events with 15 variables provided by the API.
#'  \describe{
#'   \item{country}{Country which the earthquake event occured in the case of listing eathquake events in neighbour countries and/or seas.}
#'   \item{date}{Date of the earthquake event occured.}
#'   \item{depth}{Depth of the earthquake event occured in km.}
#'   \item{district}{District which the earthquake event occured inside Turkiye's borders, too.}
#'   \item{eventid}{Event ID assigned uniqly to the earthquake event.}
#'   \item{latitude}{Latitude of the earthquake event.}
#'   \item{location}{Exact location of the earthquake event.}
#'   \item{longitude}{Longitude of the earthquake event.}
#'   \item{magnitude}{Magnitude of the earthquake event.}
#'   \item{neighborhood}{Neighborhood of the earthquake event.}
#'   \item{province}{Province which the earthquake event.}
#'   \item{rmd}{RMS of the earthquake event.}
#'   \item{type}{Magnitude type of the earthquake event.}
#'   \item{iseventupdate}{State of the earthquake event record as original record or an event record's update.}
#'   \item{lastupdatedate}{Date of the last update of the earthquake event record.}   
#'   }
#' @examples
#' #An example for a specific earthquake data with an event id,
#' equake<-read.AFAD(eventid=512359)
#' #Another example for earthquake data with time and magnitute type constraints,
#' equake<-read.AFAD(start="2022-01-01T12:00:00",end="2023-01-02T12:00:00",magtype="Mw")
#' @import rvest
#' @import XML
#' @export  
"read.AFAD"

read.AFAD<-function(start=NULL,end=NULL,minlat=NULL,maxlat=NULL,minlon=NULL,maxlon=NULL,lat=NULL,lon=NULL,maxrad=NULL,minrad=NULL,minmag=NULL,maxmag=NULL,magtype=NULL,mindepth=NULL,maxdepth=NULL,limit=NULL,offset=NULL,orderby=NULL,eventid=NULL)
  {
    ana_adres="https://deprem.afad.gov.tr/apiv2/event/filter?"
    if(is.null(eventid)==FALSE)
    {
      adres=paste(ana_adres,paste("eventid=",eventid,sep=""),"format=XML",sep="&")
      print(adres)
      veri<-internalREADv2(adres)
    }
    else
    {
      if(is.null(start)==FALSE & is.null(end)==FALSE)
      {
        adres=paste(ana_adres,paste("start=",start,sep=""),paste("end=",end,sep=""),sep="&")
        dortgen=NULL;radyal=NULL;magi=NULL
        if(is.null(minlat)==FALSE | is.null(maxlat)==FALSE | is.null(minlon)==FALSE | is.null(maxlon)==FALSE)
        {
          if(is.null(minlat)==FALSE) dortgen=paste(dortgen,paste("minlat=",minlat,sep=""),sep="&");
          if(is.null(maxlat)==FALSE) dortgen=paste(dortgen,paste("maxlat=",maxlat,sep=""),sep="&")
          if(is.null(minlon)==FALSE) dortgen=paste(dortgen,paste("minlon=",minlon,sep=""),sep="&")
          if(is.null(maxlon)==FALSE) dortgen=paste(dortgen,paste("maxlon=",maxlon,sep=""),sep="&")
          adres=paste(adres,dortgen,sep="")
        }
        else if(is.null(lat)==FALSE | is.null(lon)==FALSE | is.null(maxrad)==FALSE | is.null(minrad)==FALSE)
        {
           if(is.null(lat)==FALSE) radyal=paste(radyal,paste("lat=",lat,sep=""),sep="&")
           if(is.null(lon)==FALSE) radyal=paste(radyal,paste("lon=",lon,sep=""),sep="&")
           if(is.null(maxrad)==FALSE) radyal=paste(radyal,paste("maxrad=",maxrad,sep=""),sep="&")
           if(is.null(minrad)==FALSE) radyal=paste(radyal,paste("minrad=",minrad,sep=""),sep="&")
           adres=paste(adres,radyal,sep="")
        }
        
        if(is.null(minmag)==FALSE) magi=paste(magi,paste("minmag=",minmag,sep=""),sep="&")
        if(is.null(maxmag)==FALSE) magi=paste(magi,paste("maxmag=",maxmag,sep=""),sep="&")
        if(is.null(magtype)==FALSE) magi=paste(magi,paste("magtype=",magtype,sep=""),sep="&")
        
        if(is.null(magi)==FALSE) adres=paste(adres,magi,sep="")
        if(is.null(limit)==FALSE) adres=paste(adres,paste("limit=",limit,sep=""),sep="&")
        if(is.null(offset)==FALSE) adres=paste(adres,paste("offset=",offset,sep=""),sep="&")
        if(is.null(orderby)==FALSE) adres=paste(adres,paste("orderby=",orderby,sep=""),sep="&")
        
        adres=paste(adres,"format=XML",sep="&")
        veri<-internalREADv2(adres)
      }
    }
    if(exists("veri")==TRUE) return(veri);
  }

#' Calculates Havershine Distances of the earthquake events to a given point's coordinates.
#' 
#' Calculates Havershine Distances of downloads earthquake data from AFAD's _Event Web Service_ to a given point's coordinates as longitude and latitude.
#'
#' @param x longitude of the fix point.
#' @param y latitude of the fix point.
#' @param eqdata Earthquake data downloaded as data frame from AFAD's _Event Web Service_.
#' @param R Radius of the Earth; default is 6371 km.
#' @returns A vector of Havershine distances of earthquake events to the given coordiantes of a point.
#' @examples
#' equake<-read.AFAD(eventid=539822)
#' opensmap.AFAD(equake,gap=.5,minnumtiles=20)
#' d<-calc.Havershine(35.3161,36.9637,equake,R=6378)
#' @export 

calc.Havershine<-function(x=NULL,y=NULL,eqdata=NULL,R=NULL)
  {
    if(is.null(R)) R=6371
    if(length(x)==2) {radx=internal.rad_deg(x[1]);rady=internal.rad_deg(x[2])}
      else {radx=internal.rad_deg(x);rady=internal.rad_deg(y)}
    d<-NULL
    for(i in 1:nrow(eqdata))
      {
        tempx<-internal.rad_deg(eqdata$longitude[i])
        tempy<-internal.rad_deg(eqdata$latitude[i])
        d<-c(d,internalHAVERSHINE(radx,rady,tempx,tempy,R))
      }
    return(d)
  }

internalHAVERSHINE<-function(x1=NULL,y1=NULL,x2=NULL,y2=NULL,r=NULL)
  {
    latdif<-y2-y1
    londif<-x1-x2
    a=sin(latdif/2)^2+cos(y1)*cos(y2)*sin(londif/2)^2
    c<-2*atan2(sqrt(a),sqrt(1-a))
    havershine<-r*c
    return(havershine)
  }
internalREAD<-function(adres)
  {
    sayfa <- read_html(adres)
    temp<-html_nodes(sayfa, "arrayofearthquake")[[1]] 
    tempo=xmlParse(temp)
    root=xmlRoot(tempo)
    temp <- xmlToDataFrame(root)
    if(sum(temp$latitude==0)>0 & sum(temp$longitude==0)>0) temp<-temp[-which(temp$latitude==0 & temp$longitude==0,arr.ind=TRUE),]
    for(i in 1:ncol(temp))
    {
      Encoding(temp[,i])<-"UTF-8"
      if(sum(suppressWarnings({!is.na(as.numeric(temp[,i]))})==FALSE)==0) temp[,i]=as.numeric(temp[,i])
    }
    return(temp)
  }
internalREADv2<-function(adres)
  {
    tryCatch(
              exp=
                {
                  sayfa <- read_html(adres)
                  temp<-html_nodes(sayfa, "arrayofearthquake")[[1]] 
                  tempo=xmlParse(temp)
                  root=xmlRoot(tempo)
                  temp <- xmlToDataFrame(root)
                  if(sum(temp$latitude==0)>0 & sum(temp$longitude==0)>0) temp<-temp[-which(temp$latitude==0 & temp$longitude==0,arr.ind=TRUE),]
                  for(i in 1:ncol(temp))
                    {
                      Encoding(temp[,i])<-"UTF-8"
                      if(sum(suppressWarnings({!is.na(as.numeric(temp[,i]))})==FALSE)==0) temp[,i]=as.numeric(temp[,i])
                    }
                },
              error=
                  function(e)
                    {
                      cat(paste("Error with parameters...!\n"))
                      askerr = readline(prompt = "Would you like to see the error as server responce? (Y/N)")
                      if(sum(askerr==c("Y","y"))>0) browseURL(adres)
                    }
            )
    return(temp)
  }
internal.rad_deg<-function(angle=NULL,unit=NULL)
  {
    #Default returns degree to radian.
    if(is.null(unit) || unit=="radian") {result<-(angle*pi)/180}
      else {result<-(angle*180)/pi}
    return(result)
  }

#' Mapping of earthquake data using maps.
#' 
#' Plots some simple charts described in the service depending on package **maps** of the earthquake data from Event Web Service API provided by AFAD (Disaster and Emergency Management Authority of Republic of Turkiye).
#' 
#' @param eqdata Earthquake data as data frame from AFAD's _Event Web Service_.
#' @param mapfile Map file for graphical output.
#' @param ... Other arguments to be passed to *points*.
#' @examples
#' equake=read.AFAD(start = "2023-08-01",end="2023-08-15",lat=27.142826,lon=38.423733,maxrad=format(100000,scientific=FALSE))
#' map.AFAD(equake,"gadm36_TUR_2_sp.rds",col=equake$magnitude)
#' @import maps
#' @export

map.AFAD<-function(eqdata=NULL,mapfile=NULL,...)
  {
    map(readRDS(mapfile),xlim=c(min(eqdata$longitude[eqdata$longitude>0])-.5,max(eqdata$longitude)+.5),ylim=c(min(eqdata$latitude[eqdata$latitude>0])-.5,max(eqdata$latitude)+.5))
    map.axes()
    grid(lty=2,lwd=1.5)
    points(eqdata$longitude,eqdata$latitude,...)
  }

#' Mapping of earthquake data using OpenStreetMap
#' 
#' Plots some simple charts described in the service depending on package **OpenStreetMap** of the earthquake data from Event Web Service API provided by AFAD (Disaster and Emergency Management Authority of Republic of Turkiye).
#' 
#' @param eqdata Earthquake data as data frame  from AFAD's _Event Web Service_.
#' @param gap Adds some extra region to the map according to minimum and maximum longitude and latitude values of observed events in degrees to prevent events shown at the edges of the map.
#' @param title The text for the title.
#' @param subtitle The text for the subtitle.
#' @param caption The text for the caption.
#' @param xlab,ylab Axes titles.
#' @param pch Plotting character.
#' @param size Size of the plotting character.
#' @param col Coloring of the plotting character.
#' @param minnumtiles Argument to be passed to other argument with the same name of **openmap** from _OpenStreetMap_ which is set to 4 as default.
#' @format NULL
#' @examples
#' equake=read.AFAD(start = "2023-08-01",end="2023-08-15",lat=27.142826,lon=38.423733,maxrad=format(100000,scientific=FALSE))
#' opensmap.AFAD(equake,gap=.5,title="Radial Search Plot",xlab="Boylam",ylab="Enlem")
#' @import ggplot2
#' @import OpenStreetMap
#' @export

opensmap.AFAD<-function(eqdata=NULL,gap=NULL,title=NULL,subtitle=NULL,caption=NULL,xlab=NULL,ylab=NULL,col=NULL,size=NULL,pch=NULL,minnumtiles=NULL)
{
  if(is.null(minnumtiles)) minnumtiles=4
  if(is.null(title)) title="Event Data"
  if(is.null(subtitle)) subtitle="Date - Time Filter Only"
  if(is.null(caption)) caption=paste("AFAD Event Web Service",Sys.time(),sep=" ")
  eq.mc<-calc.meanCenter(eqdata)
  eq.stDist<-calc.StDistance(eqdata)
  eq.stDist.coor<-data.frame(cbind(long=c(eq.mc$c.longitude-eq.stDist,eq.mc$c.longitude+eq.stDist),lati=c(eq.mc$c.latitude-eq.stDist,eq.mc$c.latitude+eq.stDist)))

  upper_left<-c(max(max(eqdata$latitude[eqdata$latitude>0]),eq.stDist.coor[2,2])+gap,min(min(eqdata$longitude[eqdata$longitude>0]),eq.stDist.coor[1,1])-gap)
  lower_right<-c(min(min(eqdata$latitude[eqdata$latitude>0]),eq.stDist.coor[1,2])-gap,max(max(eqdata$longitude[eqdata$longitude>0]),eq.stDist.coor[2,1])+gap)
  #upper_left<-c(max(eqdata$latitude[eqdata$latitude>0])+gap,min(eqdata$longitude[eqdata$longitude>0])-gap)
  #lower_right<-c(min(eqdata$latitude[eqdata$latitude>0])-gap,max(eqdata$longitude[eqdata$longitude>0])+gap)
  
  map_osm <- openmap(upper_left, lower_right, type = 'osm-public-transport',minNumTiles=minnumtiles)
  #map_osm <- openmap(upper_left, lower_right, type = 'esri-topo',minNumTiles=minnumtiles)
  map_osm <- openproj(map_osm)
  p<-autoplot.OpenStreetMap(map_osm,expand = TRUE)+geom_point(eqdata,shape=ifelse(is.null(pch)==FALSE,pch,16),mapping=aes(y=latitude,x=longitude,col={{col}},size={{size}}))
  p+labs(title = title,subtitle = subtitle,caption=caption,x=xlab,y=ylab)
}


