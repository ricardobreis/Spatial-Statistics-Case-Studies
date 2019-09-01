# carrega as extensões RGDAL, TMAP
library(rgdal)
library(tmap)

#Carrega o shapefile do mapa utilizando o pacote RGDAL
dsn <- system.file("C:/Users/Ricardo/Documents/R-Projetos/RendaSP/sp.shp", package = "rgdal")[1]
mapa <- rgdal::readOGR(dsn="C:/Users/Ricardo/Documents/R-Projetos/RendaSP/sp.shp",layer="sp")

#Filtra o mapa só para a capital
sp <- subset(mapa, !is.na(V005))

plot(sp)

#Muda o modo de visualização de estático para interativo (o Tmap chama o Leaflet)
tmap_mode("view")

#Seta o título do gráfico
titulo = "Renda - SP"

#Primeira layer = Mapa de SP
tm_shape(sp) +

  #Utiliza as cores para montar o mapa de calor baseado na coluna V005
  tm_fill(col = "V005", title = titulo, palette = "BuGn", n=8) +
  
  #Insere bordas para facilitar a visualização das áreas
  tm_borders() + tm_style("cobalt")
