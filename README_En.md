# AFAD Event Web Service Earthquake Data Download Package: AFADEarthQuakeData[^1][^2]

<p align="justify">
The purpose of this package is to enable the transfer of earthquake catalog data distributed through the <a href="https://deprem.afad.gov.tr/event-service" style="text-decoration:none;">Event Web Service</a> offered by the <i><b>Emergency and Disaster Management Authority</b></i> (AFAD) to R, the statistical calculation and graphics software, and to quickly obtain some basic statistics and graphics for descriptive data analysis.<br/>
The package content currently consists of 10 items:

Function | Explanation
----------|---------
calc.Havershine |	Calculates Havershine distances of earthquake events according to the coordinates of a given point.
calc.meanCenter |	Calculates average and weighted average center values.
calc.StDevEllipse	 |	Calculates the standard ellipse.
calc.StDistance |	Calculates the standard distance.
histog.depth |	Draws a fast earthquake depth histogram for downloaded earthquake data.
histog.magni |	Draws a fast earthquake magnitude histogram for downloaded earthquake data.
map.AFAD	|	maps of earthquake data downloaded with the maps package.
opensmap.AFAD |	Maps earthquake data downloaded with the OpenStreetMap package.
read.AFAD	|	Retrieves earthquake data from AFAD Earthquake Web Service.
turkiye_and_neighborhood_gazetteer |	Türkiye and Neighborhood Gazetteer.
</p>

For example, properties for an earthquake with a known _eventID_ can be retrieved from the Web Service.

```R
  equake<-read.AFAD(eventid=512359)
# View(equake)
# equake
#  country                   date depth district eventid latitude        location longitude magnitude neighborhood  province  rms type iseventupdate lastupdatedate
#1 Türkiye 2021-09-16T09:40:27.44  7.07      Çan  512359  40.0066 Çan (Çanakkale)   27.0065       1.6        Hurma Çanakkale 0.71   ML         false               
``` 

<p align="justify">
Another example is to retrieve earthquake data covering a certain time interval. If you want to retrieve earthquake data that occurred in Turkey between September 01 - September 30, 2023, a data frame will be obtained as follows.
</p>

```R
  equake<-read.AFAD(start="2023-09-01T00:00:00",end="2023-09-30T23:59:59")
  head(equake)
#  country                date depth   district eventid latitude             location longitude magnitude neighborhood province  rms type iseventupdate             lastupdatedate
#1    Irak 2023-09-10T21:43:48  7.00             602422   35.024 Daquq, Kerkük (Irak)    44.411       4.8                       0.68   MW          true 2023-09-10T22:12:31.523207
#2         2023-09-16T18:56:31 33.96             603132   34.436              Akdeniz    32.675       1.9                       0.44   ML         false                           
#3 Türkiye 2023-09-01T00:02:01 12.15   Sungurlu  601270   40.120     Sungurlu (Çorum)    34.467       2.0  Büyükincesu    Çorum 0.38   ML         false                           
#4 Türkiye 2023-09-01T00:04:50  7.00    Pütürge  601271   38.135    Pütürge (Malatya)    38.637       1.5       Üçyaka  Malatya 0.39   ML         false                           
#5 Türkiye 2023-09-01T00:06:26  7.00 Bahçesaray  601272   38.109     Bahçesaray (Van)    42.687       2.6      Çiçekli      Van 0.46   ML         false                           
#6 Türkiye 2023-09-01T00:54:51  3.34 Bahçesaray  601273   38.104     Bahçesaray (Van)    42.702       2.1     Ulubeyli      Van 0.63   ML         false    
```
<p align="justify">
If the data downloaded from AFAD Earthquake Web Service is to be mapped quickly and earthquake depth and magnitude distributions are to be visualized quickly, <strong>map.AFAD</strong> and/or <strong>opensmap.AFAD</strong>, <strong>histog.depth</strong> and <strong>histog.magni</strong> functions can be used respectively.
</p>

```R
opensmap.AFAD(equake,gap=.5,title="Standart Arama Deprem Haritası",subtitle="Sadece Tarih-Zaman Filtresi: Eylül 2023" ,xlab="Boylam",ylab="Enlem",minnumtiles=10)
histog.depth(equake,title="Eylül 2023 - Deprem Derinlik Dağılımı")
histog.magni(equake,title="Eylül 2023 - Deprem Büyüklük Dağılımı")
```
<p>
<img src="https://github.com/lterlemez/AFAD_Package/assets/99257171/6ee7076e-3444-46be-9fa4-5fc90573f9ac" width=50% height=50%, title="OpenStreetMap ile Deprem Haritalama">
</p>
<img src="https://github.com/lterlemez/AFAD_Package/assets/99257171/f85bc9d5-db95-4482-9d2e-ad6ad791bf12" width="500" title="Deprem Derinlik Dağılımı">
<img src="https://github.com/lterlemez/AFAD_Package/assets/99257171/1d342980-8e66-4e28-b0ec-ab291132bd92" width="500" title="Deprem Büyüklük Dağılımı">

<!-- ![Deprem Derinlik Dağılımı](https://github.com/lterlemez/AFAD_Package/assets/99257171/f85bc9d5-db95-4482-9d2e-ad6ad791bf12|width=200)
![Deprem Büyüklük Dağılımı](https://github.com/lterlemez/AFAD_Package/assets/99257171/1d342980-8e66-4e28-b0ec-ab291132bd92|width=200) -->

## Box Search Example
<div align="justify">
In this example, the <b>RDS</b> map file being used with the <b>map.AFAD</b> function can be accessed by selecting version 3.6 from the <a href="https://gadm.org/old_versions.html" style="text-decoration:none;">Old GADM data</a> link.
</div>

```R
equake<-read.AFAD(start="1990-01-01T12:00:00",end="2023-01-02T12:00:00",minlat=39,maxlat=42,minlon=26,maxlon=42,orderby ="magnitude",minmag=4)
#RDS dosyası için https://gadm.org/old_versions.html linki üzerinden versiyon 3.6'yı seçerek ulaşılabilir.
map.AFAD(equake,"gadm36_TUR_0_sp.rds")
opensmap.AFAD(equake,gap=.5,title="Box Search Plot",xlab="Boylam",ylab="Enlem",minnumtiles = 10); 
histog.depth(equake,col="grey",fill = "black")
histog.magni(equake,col="blue",fill = "black")
c.mean<-calc.meanCenter(equake,type="mean")
stdis<-calc.StDistance(equake)
stdev<-calc.StDevEllipse(equake,addplt=TRUE,plt=p)
# Takip eden grafik çizimi için ggforce paketi gerekmektedir.
library(ggforce)
p<-opensmap.AFAD(equake,gap=.5,minnumtiles=10)
p+geom_point(color="red",aes(x=c.mean[,1],y=c.mean[,2]))
+geom_circle(aes(x0=c.mean[,1], y0=c.mean[,2], r=calc.StDistance(equake)), inherit.aes=FALSE)
+geom_ellipse(color="red",aes(x0=c.mean[,1],y0=c.mean[,2],angle=stdev$rot,a=stdev$A,b=stdev$B))
#Deprem büyüklüğü 5'in üzerinde olan depremlerin şiddetlerinin harita üzerinde metin şeklinde gösterilmesi
eqmag<-equake[which(equake$magnitude>5),]
opensmap.AFAD(equake,gap=.5,title="Box Search Plot",xlab="Boylam",ylab="Enlem",minnumtiles = 10)+ geom_text(data=eqmag,aes(longitude,latitude,label=magnitude),color="red")
```

[^1]: İçöz, C., & Terlemez, L. (2024). AFAD Deprem Veri ve Görselleştirmelerine İlişkin Bir R Paketi: AFADEarthQuakeData. Türk Deprem Araştırma Dergisi. https://doi.org/10.46464/tdad.1375464
[^2]: Unfortunately, due to the recent changes made by AFAD, old earthquake data is no longer available. As of now, Event Web Service only provides data on earthquake events for the last 5 days.  You can use the link https://deprem.afad.gov.tr/apiv2/event/filter?start=2020-09-14%2010:00:00&end=2021-09-16%2010:00:00&format=xml to see the sample error result.
