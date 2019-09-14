# carrega as extensões SF, TMAP
library(tmap)
library(sf)
library(dplyr)

#Carrega o shapefile do mapa utilizando o pacote SF (Mais simples que o RGDAL)
mapa <- st_read("C:/Users/Ricardo/Documents/R-Projetos/RendaSP/sp.shp")
#O pacote SF carrega o shapefile como um dataframe (Diferente do RGDAL que carrega um SpatialPolygonsDataFrame)
class(mapa)

#O pacote SF permite a manipulação do shapefile com o DPLYR
sp <- filter(mapa, !is.na(V005))

#Plota apenas os polígonos do mapa
plot(st_geometry(sp))

#Coordinate reference system. Todo mapa precisa ter um sistema de coordenadas de referência
st_crs(sp)

#Caso o mapa não tenha um CRS, basta adicionar um seguindo o código de exemplo abaixo
crs_1 <- "+proj=longlat +ellps=GRS80 +no_defs"
st_crs(trees) <- crs_1

#Não se pode plotar layers que não tenham o mesmo CRS
#-------------------------Transformando Vector e Raster no mesmo CRS----------------------------#

# Plot canopy and neighborhoods (run both lines together)
# Do you see the neighborhoods?
plot(canopy) #raster
plot(neighborhoods, add = TRUE) #vector

# See if canopy and neighborhoods share a CRS
st_crs(neighborhoods)
st_crs(canopy)

# Save the CRS of the canopy layer
the_crs <- crs(canopy, asText = TRUE)

# Transform the neighborhoods CRS to match canopy
neighborhoods_crs <- st_transform(neighborhoods, crs = the_crs)

# Re-run plotting code (run both lines together)
# Do the neighborhoods show up now?
plot(canopy)
plot(neighborhoods_crs, add = TRUE)

# Simply run the tmap code
tm_shape(canopy) + 
  tm_raster() + 
  tm_shape(neighborhoods_crs) + 
  tm_polygons(alpha = 0.5)
