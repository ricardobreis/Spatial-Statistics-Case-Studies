# carrega as extensões RGDAL, TMAP
library(rgdal)
library(tmap)

#Carrega o shapefile do mapa utilizando o pacote RGDAL
dsn <- system.file("C:/Users/Ricardo/Documents/R-Projetos/CrimeMG/crime_mg.shp", package = "rgdal")[1]
mapa <- rgdal::readOGR(dsn="C:/Users/Ricardo/Documents/R-Projetos/CrimeMG/crime_mg.shp",layer="crime_mg")
plot(mapa)

#Plota o mapa utilizando o pacote TMAP
titulo = "Índice de Criminalidade em MG - 1995"

#Primeira layer = Mapa de SP
tm_shape(mapa) +
  #Utiliza as cores para montar o mapa de calor baseado na coluna INDICE95
  tm_fill(col = "INDICE95", title = titulo, palette = "BuGn") +
  #Insere bordas para facilitar a visualização das áreas
  tm_borders() 
