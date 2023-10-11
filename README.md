# AFAD_Package
AFAD Event Web Service Earthquake Data Download Package



<p align="justify">
Bu paketin amacı; Acil ve Afet  Durum Yönetim Başkanlığının (AFAD) sunmakta olduğu Deprem Web Servisi aracılığı ile dağıtımı yapılan deprem katalog verilerinin istatistik hesaplama ve grafik yazılımına aktarınını kolaylaştırmak ve açıklayıcı veri analizine yönelik bazı temel istatistiklerin grafiklerin hızlıca elde edilebilmesini sağlamaktır.
Paket içeriği an itibari 10 ögeden oluşmaktadır:

Fonksiyon | Açıklama
----------|---------
calc.Havershine |	Verilen bir nokta koordinatlarına göre deprem olaylarının Havershine uzaklıklarını hesaplar.
calc.meanCenter |	Ortalama ve ağırlıklı ortalama merkez değerlerini hesaplar.
calc.StDevEllipse	 |	Standart elipsi hesaplar.
calc.StDistance |	Standard uzaklığı hesaplar.
histog.depth |	İndirilen deprem verisi için hızlı deprem derinliği	histogramı çizer.
histog.magni |	İndirilen deprem verisi için hızlı deprem büyüklüğü	histogramı çizer.
map.AFAD	|	maps paketti ile indirilen deprem verisinin haritaaını çizer.
opensmap.AFAD |	OpenStreetMap paketti ile indirilen deprem verisinin haritaaını çizer.
read.AFAD	|	AFAD Deprem Web Servisinden deprem verisi çeker.
turkiye.cities |	Türkiye illerine ilişkin enlem, boylam bilgisini örnekler.
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
AFAD Deprem Web Servisinden indirilen veri hızlı bir şekilde haritalandırılmak ve deprem derinlik ve büyüklük dağılımları hızlı bir şekilde görselleştirilmek istenir ise sırası ile *map.AFAD* ve/veya *opensmap.AFAD*, *histog.depth* ve *histog.magni* fonksiyonlarından yararlanılabilir.
</p>

```R
opensmap.AFAD(equake,gap=.5,title="Standart Arama Deprem Haritası",subtitle="Sadece Tarih-Zaman Filtresi: Eylül 2023" ,xlab="Boylam",ylab="Enlem",minnumtiles=10)
histog.depth(equake,title="Eylül 2023 - Deprem Derinlik Dağılımı")
histog.magni(equake,title="Eylül 2023 - Deprem Büyüklük Dağılımı")
```
![OpenStreeMap Deprem Haritası](https://github.com/lterlemez/AFAD_Package/assets/99257171/6ee7076e-3444-46be-9fa4-5fc90573f9ac)
![Deprem Derinlik Dağılımı](https://github.com/lterlemez/AFAD_Package/assets/99257171/f85bc9d5-db95-4482-9d2e-ad6ad791bf12)
![Deprem Büyüklük Dağılımı](https://github.com/lterlemez/AFAD_Package/assets/99257171/1d342980-8e66-4e28-b0ec-ab291132bd92)


<p align="justify">
</p>
