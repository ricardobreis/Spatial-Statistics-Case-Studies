# carrega as extensões RGDAL, TMAP
library(rgdal)
library(tmap)

#Carrega o shapefile do mapa utilizando o pacote RGDAL
dsn <- system.file("C:/Users/Ricardo/Documents/R-Projetos/RendaSP/sp.shp", package = "rgdal")[1]
mapa <- rgdal::readOGR(dsn="C:/Users/Ricardo/Documents/R-Projetos/RendaSP/sp.shp",layer="sp")

#Filtra o mapa só para a capital
sp <- subset(mapa, !is.na(V005))

plot(sp)

#Carrega CSV de pontos
pontos <- read.csv2("~/Desktop/localizacoes.csv")

#Transforma o dataframe de pontos em SpatialPointsDataFrame utilizando o pacote SP
coordinates(pontos)<-~Long+Lat

#Muda o modo de visualização de estático para interativo (o Tmap chama o Leaflet)
tmap_mode("view")

#Seta o título do gráfico
titulo = "Renda - SP"

#Seta o os valores das quebras na legenda
breaks = c(1000, 3000, 5000, 10000, 20000, 75000) 

#Primeira layer = Mapa de SP
tm_shape(sp) +

  #Utiliza as cores para montar o mapa de calor baseado na coluna V005
  tm_fill(col = "V005", title = titulo, palette = "BuGn", breaks = breaks) +
  
  #Insere bordas para facilitar a visualização das áreas
  tm_borders() +

  #Adiciona o estilo cobalt
  tm_style("cobalt") +

  #Insere a segunda layer = Localidades (lat,lon)
  tm_shape(pontos) + 

  #Desenha os pontos
  tm_dots(size = 0.05)
