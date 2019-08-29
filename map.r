# carrega as extensões RGDAL, TMAP
library(rgdal)
library(tmap)

#Carrega o shapefile do mapa utilizando o pacote RGDAL
dsn <- system.file("~/Desktop/setores/areacens_sp/areacens_sp.shp", package = "rgdal")[1]
mapa <- rgdal::readOGR(dsn="~/Desktop/setores/areacens_sp",layer="areacens_sp")
plot(mapa)

#Carrega CSV de pontos
pontos <- read.csv2("~/Desktop/localidades.csv")

#Transforma o dataframe de pontos em SpatialPointsDataFrame utilizando o pacote SP
coordinates(pontos)<-~Long+Lat

#Plota o mapa utilizando o pacote TMAP
titulo = "Renda Média"

#Primeira layer = Mapa de SP
tm_shape(mapa) +
  #Utiliza as cores para montar o mapa de calor baseado na coluna RENDA
  tm_fill(col = "RENDA", title = titulo, palette = "BuGn", n = 3) +
  #Insere bordas para facilitar a visualização das áreas censitárias
  tm_borders() + 
  #Insere a segunda layer = Localidades (lat,lon)
  tm_shape(pontos) + 
  #Desenha os pontos
  tm_dots(size = 0.05)
