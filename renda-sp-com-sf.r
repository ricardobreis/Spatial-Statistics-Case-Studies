################################################################################################
#
# ESTATÍSTICA ESPACIAL - MBA Business Analytics e Big Data
# Por: RICARDO REIS
#
# CASE - MAPA DE RENDA MÉDIA DO MUNICÍPIO DE SÃO PAULO
#
################################################################################################

#------------------------------------------------------------------------------------------------#

#----PACOTES----#

#------------------------------------------------------------------------------------------------#

# carrega as extensões SF, TMAP, DPLYR e PRYR
library(tmap)
library(sf)
library(dplyr)
library(pryr)

#------------------------------------------------------------------------------------------------#

#----CARREGA MAPAS, DADOS E PREPARA O MAPA BASE----#

#------------------------------------------------------------------------------------------------#


#Carrega o shapefile do mapa utilizando o pacote SF (Mais simples que o RGDAL)
mapa <- st_read("C:/Users/Ricardo/Documents/R-Projetos/MapaSP/33SEE250GC_SIR.shp")

#O pacote SF carrega o shapefile como um dataframe (Diferente do RGDAL que carrega um SpatialPolygonsDataFrame)
class(mapa)

#Plota apenas os polígonos do mapa
plot(st_geometry(mapa))

#Carrega o DF do Censo 2010
censo2010 <- read.csv2("~/R-Projetos/MapaSP/Basico_SP1.csv")

#Transforma a coluna Cod_setor do formato científico para o inteiro 
censo2010$Cod_setor <- as.factor(format(censo2010$Cod_setor, scientific = FALSE))

#Select da coluna renda
renda <- select(censo2010, Cod_setor, Nome_do_distrito, V005)

#Join do mapa com a renda
maparenda <- inner_join(mapa, renda, by= c("CD_GEOCODI" = "Cod_setor"))

#Plota apenas os polígonos do mapa
plot(st_geometry(maparenda))

#------------------------------------------------------------------------------------------------#

#----CASO SEJA NECESSÁRIO DIMINUIR O TAMANHO DO ARQUIVO----#

#------------------------------------------------------------------------------------------------#

#Função do pacote pryr que retorna o tamanho do arquivo
object_size(maparenda)

#Computa o número de vértices no objeto
pts_maparenda <- st_cast(maparenda$geometry, "MULTIPOINT")
cnt_maparenda <- sapply(pts_maparenda, length)
sum(cnt_maparenda)

#Simplifica o obejto (Diminui o tamanho)
maparenda_simples <- st_simplify(maparenda, 
                                    preserveTopology = TRUE, 
                                    dTolerance = 10000)

#Função do pacote pryr que retorna o tamanho do arquivo
object_size(maparenda_simples)

#Computa o número de vértices no objeto
pts_maparenda_simples <- st_cast(maparenda_simples$geometry, "MULTIPOINT")
cnt_maparenda_simples <- sapply(pts_maparenda_simples, length)
sum(cnt_maparenda_simples)

#------------------------------------------------------------------------------------------------#

#----RENDERIZA O MAPA----#

#------------------------------------------------------------------------------------------------#


#Seta o mapa para o formato interativo (Com leaflet)
tmap_mode("view")

#Seta o título do gráfico
titulo = "Renda - SP"

#Seta o os valores das quebras na legenda
breaks = c(1000, 3000, 5000, 10000, 20000, 75000) 

#Primeira layer = Mapa de SP
tm_shape(maparenda_simples) +
  
  #Utiliza as cores para montar o mapa de calor baseado na coluna V005
  tm_fill(col = "V005", title = titulo, palette = "BuGn", breaks = breaks) +
  
  #Insere bordas para facilitar a visualização das áreas
  tm_borders() +
  
  #Adiciona o estilo cobalt
  tm_style("cobalt") 
