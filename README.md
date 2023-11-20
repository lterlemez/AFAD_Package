# AFAD Event Web Service Earthquake Data Download Package: AFADEarthQuakeData

<p align="justify">
Bu paketin amacı; <i><b>Acil ve Afet  Durum Yönetim Başkanlığının</b></i> (AFAD) sunmakta olduğu <a href="https://deprem.afad.gov.tr/event-service" style="text-decoration:none;">Deprem Web Servisi</a> aracılığı ile dağıtımı yapılan deprem katalog verilerinin istatistik hesaplama ve grafik yazılımı R'ye aktarınını kolaylaştırmak ve açıklayıcı veri analizine yönelik bazı temel istatistiklerin grafiklerin hızlıca elde edilebilmesini sağlamaktır.
Paket içeriği an itibari 10 ögeden oluşmaktadır:

Fonksiyon | Açıklama
----------|---------
calc.Havershine |	Verilen bir nokta koordinatlarına göre deprem olaylarının Havershine uzaklıklarını hesaplar.
calc.meanCenter |	Ortalama ve ağırlıklı ortalama merkez değerlerini hesaplar.
calc.StDevEllipse	 |	Standart elipsi hesaplar.
calc.StDistance |	Standard uzaklığı hesaplar.
histog.depth |	İndirilen deprem verisi için hızlı deprem derinliği	histogramı çizer.
histog.magni |	İndirilen deprem verisi için hızlı deprem büyüklüğü	histogramı çizer.
map.AFAD	|	maps paketi ile indirilen deprem verisinin haritalar.
opensmap.AFAD |	OpenStreetMap paketi ile indirilen deprem verisini haritalar.
read.AFAD	|	AFAD Deprem Web Servisinden deprem verisi çeker.
turkiye_and_neighborhood_gazetteer |	Türkiye ve Çevresi Coğrafi Ad Dizini (CAD)
</p>

Örneğin, _eventID_'si bilinen bir depreme ilişkin özellikler, Web Servisinden çekilebilir.

```R
  equake<-read.AFAD(eventid=512359)
# View(equake)
# equake
#  country                   date depth district eventid latitude        location longitude magnitude neighborhood  province  rms type iseventupdate lastupdatedate
#1 Türkiye 2021-09-16T09:40:27.44  7.07      Çan  512359  40.0066 Çan (Çanakkale)   27.0065       1.6        Hurma Çanakkale 0.71   ML         false               
``` 

<p align="justify">
Diğer bir örnek de belli bir zaman aralığını kapsayacak şeklinde deprem verisi çekmek üzerine verilebilir. 01 Eylül - 30 Eylül 2023 tarihleri arasında Türkiye genelinde meydana gelmiş deprem verisi çekilmek istendiğinde aşağıdaki şekilde bir veri çerçevesi elde edilecektir.
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
AFAD Deprem Web Servisinden indirilen veri hızlı bir şekilde haritalandırılmak ve deprem derinlik ve büyüklük dağılımları hızlı bir şekilde görselleştirilmek istenir ise sırası ile <strong>map.AFAD</strong> ve/veya <strong>opensmap.AFAD</strong>, <strong>histog.depth</strong> ve <strong>histog.magni</strong> fonksiyonlarından yararlanılabilir.
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

## Dikdörtgen Arama Örneği

Bu örnekte, **map.AFAD** fonksiyonu ile kullanılmakta olan __RDS__ harita dosyası için <a href="https://gadm.org/old_versions.html" style="text-decoration:none;">Old GADM data</a> linki üzerinden versiyon 3.6'yı seçerek ulaşılabilir.

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

<p align="justify">
</p>
