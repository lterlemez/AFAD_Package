#' Calculates Mean and Weighted Mean Center
#'
#' Calculates mean and weighted mean centers of the downloaded earthquake data.
#' 
#' @param eqdata Downloaded earthquake data as data frame from AFAD's _Event Web Service_.
#' @param type Type of the mean center as __mean__ for mean center and __weighted__ for weighted mean center. Default is "mean".
#' @param weight Weight data for weighted center mean.
#' @return A data frame of earthquake events mean center consists of mean longitude and latitude.
#'
#' @examples
#' equake<-read.AFAD(start="2022-01-01T12:00:00",end="2023-01-02T12:00:00",lat=35.5,lon=37,maxrad=format(100000,scientific=FALSE))
#' c.mean<-calc.meanCenter(equake,type="mean")
#' c.wmean<-calc.meanCenter(equake,type="weighted",equake$depth)
#' opensmap.AFAD(equake,gap=.5,minnumtiles=20)+geom_point(color="red",aes(x=c.mean[,1],y=c.mean[,2]))+geom_point(shape=8,color="red",aes(x=c.wmean[,1],y=c.wmean[,2]))
#' 
#' @export

calc.meanCenter<-function(eqdata=NULL,type=NULL,weight=NULL)
  {
  if(is.null(type) || type=="mean")
    {
      type<-"mean"
      xbar<-mean(eqdata$longitude)
      ybar<-mean(eqdata$latitude)
      #ybar<-mean(eqdata$longitude)
      #xbar<-mean(eqdata$latitude)
    }
  else
    {
      type<-"weighted"
      xbar<-weighted.mean(eqdata$longitude,w=weight)
      ybar<-weighted.mean(eqdata$latitude,w=weight)
    }
  return(data.frame(c.longitude=xbar,c.latitude=ybar))
  }

#' Calculates Standard Distance
#' 
#' Calculates standard distance of the downloaded earthquake data.
#' 
#' @param eqdata Downloaded earthquake data as data frame from AFAD's _Event Web Service_.
#' 
#' @return Standard distance value.
#' 
#' @examples
#' equake<-read.AFAD(start="2022-01-01T12:00:00",end="2023-01-02T12:00:00",lat=37.8,lon=38.3,maxrad=99999)
#' c.mean<-calc.meanCenter(equake,type="mean")
#' stdis<-calc.StDistance(equake)
#' p<-opensmap.AFAD(equake,gap=.5,minnumtiles=10)
#' p+geom_point(color="red",aes(x=c.mean[,1],y=c.mean[,2]))
#' p+geom_circle(aes(x0=c.mean[,1], y0=c.mean[,2], r=calc.StDistance(equake)), inherit.aes=FALSE)
#' 
#' @export 

calc.StDistance<-function(eqdata=NULL)
  {
    varx<-var(eqdata$longitude)*((length(eqdata$longitude)-1)/length(eqdata$longitude))
    vary<-var(eqdata$latitude)*((length(eqdata$latitude)-1)/length(eqdata$latitude))
    sdist<-sqrt(varx+vary)
    return(sdist)
  }

#' Calculates Standard Deviation Ellipse.
#' 
#' Calculates standard deviation ellipse of the downloaded earthquake data.
#' 
#' @param eqdata Downloaded earthquake data as data frame from AFAD's _Event Web Service_.
#' 
#' @format NULL
#' 
#' @returns A data frame containing related results.
#' 
#' \describe{
#'   \item{Tetha}{Angle of the ellipse}
#'   \item{sigma.x}{Deviation along the x axis}
#'   \item{sigma.y}{Deviation along the y axis}
#'   \item{area.ellipse}{Area of the std. deviation ellipse}
#'   \item{A}{Major axis}
#'   \item{B}{Minor axis}
#'   \item{rotation}{Rotation correction}
#'   }
#'   
#' @examples
#' library(ggforce)
#' equake<-read.AFAD(start="2022-01-01T12:00:00",end="2023-01-02T12:00:00",lat=37.8,lon=38.3,maxrad=99999)
#' c.mean<-calc.meanCenter(equake,type="mean")
#' stdis<-calc.StDistance(equake)
#' stdev<-calc.StDevEllipse(equake)
#' p<-opensmap.AFAD(equake,gap=.5,minnumtiles=10)
#' p<-p+geom_point(color="red",aes(x=c.mean[,1],y=c.mean[,2]))
#' p<-p+geom_circle(aes(x0=c.mean[,1], y0=c.mean[,2], r=calc.StDistance(equake)), inherit.aes=FALSE)
#' p<-p+geom_ellipse(color="red",aes(x0=c.mean[,1],y0=c.mean[,2],angle=stdev$rot,a=stdev$A,b=stdev$B))
#' p
#' 
#' @export 

calc.StDevEllipse<-function(eqdata=NULL)
  {
    mc<-calc.meanCenter(eqdata)
    ceqdata<-data.frame(x=eqdata$longitude-mc[,1],y=eqdata$latitude-mc[,2])
    tanteta<-((sum(ceqdata$x^2)-sum(ceqdata$y^2))+sqrt((sum(ceqdata$x^2)-sum(ceqdata$y^2))^2+4*(sum(ceqdata$x*ceqdata$y)^2)))/(2*sum(ceqdata$x*ceqdata$y))
    if(atan(tanteta)*180/pi<0)
      {teta<-180+(atan(tanteta)*180/pi)}
    else
      {teta<-(atan(tanteta)*180/pi)}
    
    costeta=cos(teta*pi/180)
    sinteta=sin(teta*pi/180)

    sigmax<-sqrt(2*sum((ceqdata$x*costeta-ceqdata$y*sinteta)^2)/(nrow(ceqdata)-2))
    sigmay<-sqrt(2*sum((ceqdata$x*sinteta-ceqdata$y*costeta)^2)/(nrow(ceqdata)-2))
    
    areaellipse=pi*sigmax*sigmay
    
    B <- min(sigmax, sigmay)
    A <- max(sigmax, sigmay)
    
    rot<-(90-teta)*pi/180
    
    return(data.frame(teta=teta,sigma.x=sigmax,sigma.y=sigmay,area.ellipse=areaellipse,A=A,B=B,rotation=rot,sinteta=sinteta,costeta=costeta))
  }