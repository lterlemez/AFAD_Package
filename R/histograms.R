#' Quick histogram of depth of downloaded earthquake data 
#' 
#' Draws a quick ggplot2 histogram of **depth** distribution of the downloaded earthquake data with a couple of plot settings from _Earthquake Web Service_ API provided by AFAD.
#' 
#' @param eqdata Downloaded earthquake data as data frame from AFAD's _Event Web Service_.
#' @param bins Number of bins for histogram, default is 30.
#' @param col Color of plotting line.
#' @param fill Color of fill.
#' @param title The text for the title.
#' @param caption The text for caption.
#' @param xlabel Title for x axis.
#' @param ylabel Title for y axis.
#' @examples
#' equake=read.AFAD(start = "2023-08-01",end="2023-08-15",lat=27.142826,lon=38.423733,maxrad=100000)
#' histog.depth(equake,col="red",fill = "black")
#' histog.magni(equake,col="red",fill = "black",title="August 2023 Eartquakes - Radial Search")
#' @export

histog.depth<-function(eqdata,bins=NULL,col=NULL,fill=NULL,title=NULL,caption=NULL,xlabel=NULL,ylabel=NULL)
  {
    
    bins=ifelse(is.null(bins)==FALSE,bins,30)
    if(is.null(title)) title="Histogram Depth"
    if(is.null(caption)) caption=paste("AFAD Event Web Service",Sys.time(),sep=" ")
    if(is.null(xlabel)) xlabel="Depth"
    if(is.null(ylabel)) ylabel="Count" 
    if(is.null(col)) col="black"
    if(is.null(fill)) fill="white"
    
    ggplot(equake,aes(depth))+geom_histogram(bins=bins,color=col,fill=fill)+labs(title=title,caption=caption,x=xlabel,y=ylabel)+theme_classic()
  }

#' Quick histogram of magnitude of downloaded earthquake data 
#' 
#' Draws a quick ggplot2 histogram of **magnitude** distribution of the downloaded earthquake data with a couple of plot settings from _Event Web Service_ API provided by AFAD.
#' 
#' @param eqdata Downloaded earthquake data as data frame from AFAD's _Event Web Service_.
#' @param bins Number of bins for histogram, default is 30.
#' @param col Color of plotting line.
#' @param fill Color of fill.
#' @param title The text for the title.
#' @param caption The text for the caption.
#' @param xlabel Title for x axis.
#' @param ylabel Title for y axis.
#' @examples
#' equake=read.AFAD(start = "2023-08-01",end="2023-08-31",lat=27.142826,lon=38.423733,maxrad=100000)
#' histog.magni(equake,col="red",fill = "black",title="August 2023 Eartquakes - Radial Search")
#' histog.depth(equake,col="red",fill = "black")
#' @export

histog.magni<-function(eqdata,bins=NULL,col=NULL,fill=NULL,title=NULL,caption=NULL,xlabel=NULL,ylabel=NULL)
{
  
  bins=ifelse(is.null(bins)==FALSE,bins,30)
  if(is.null(title)) title="Histogram Magnitude"
  if(is.null(caption)) caption=paste("AFAD Event Web Service",Sys.time(),sep=" ")
  if(is.null(xlabel)) xlabel="Magnitude"
  if(is.null(ylabel)) ylabel="Count" 
  if(is.null(col)) col="black"
  if(is.null(fill)) fill="white"
  
  ggplot(equake,aes(magnitude))+geom_histogram(bins=bins,color=col,fill=fill)+labs(title=title,caption=caption,x=xlabel,y=ylabel)+theme_classic()
}