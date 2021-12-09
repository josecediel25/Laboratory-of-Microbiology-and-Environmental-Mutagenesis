##Biogeochemical data and map##
##LMMA-UIS##
##Jhon Suescún and José Cediel##

setwd("D:/7to_semestre_UIS/TRABAJO_DE_GRADO_1/Mapa/")
install.packages("raster")
library(raster)
occ <- read.csv("Smocc.csv", header = T, sep = ";")
View(occ)
coordinates(occ)  <-  ~decimalLongitude+decimalLatitude
plot(occ)

# Elevation data extraction
elevCol <- getData('alt', country = 'COL', mask=TRUE)
altura <- extract(elevCol, occ)

# Bioclimatic data extraction
temCol <- getData('worldclim', var='tmean', res=0.5, lon=-75 , lat=1)
temperatura <- extract(temCol, occ)
temperatura <- apply(temperatura, 1, FUN=mean, trim=0)
temperatura <- temperatura/10
temperatura

precCol <- getData('worldclim', var='bio', res=0.5, lon=-75 , lat=1)
precip <- extract((precCol$bio12_23), occ)

# Obtaining irradiance solar data. Download zip: https://www.worldclim.org/data/worldclim21.html Found per month.(kJ m-2 day-1)unzip("wc2.1_10m_srad.zip")
srad1 <- raster("wc2.1_30s_srad_01.tif")
psrad1 <- extract(srad1, occ)
srad2 <- raster("wc2.1_30s_srad_02.tif")
psrad2 <- extract(srad2, occ)
srad3 <- raster("wc2.1_30s_srad_03.tif")
psrad3 <- extract(srad3, occ)
srad4 <- raster("wc2.1_30s_srad_04.tif")
psrad4 <- extract(srad4, occ)
srad5 <- raster("wc2.1_30s_srad_05.tif")
psrad5 <- extract(srad5, occ)
srad6 <- raster("wc2.1_30s_srad_06.tif")
psrad6 <- extract(srad6, occ)
srad7 <- raster("wc2.1_30s_srad_07.tif")
psrad7 <- extract(srad7, occ)
srad8 <- raster("wc2.1_30s_srad_08.tif")
psrad8 <- extract(srad8, occ)
srad9 <- raster("wc2.1_30s_srad_09.tif")
psrad9 <- extract(srad9, occ)
srad10 <- raster("wc2.1_30s_srad_10.tif")
psrad10 <- extract(srad10, occ)
srad11 <- raster("wc2.1_30s_srad_11.tif")
psrad11 <- extract(srad11, occ)
srad12 <- raster("wc2.1_30s_srad_12.tif")
psrad12 <- extract(srad12, occ)
srad <- cbind(psrad1, psrad2, psrad3, psrad4, psrad5, psrad6, psrad7, psrad8, psrad9, psrad10, psrad11, psrad12)

# Average annual irradiance (kJ m-2 day-1)
promsrad <- apply(srad, 1, FUN=mean, trim=0)

# Climate data union
geoclim <- cbind(altura, temperatura, precip, promsrad)
write.csv(geoclim, "geoclim.csv", row.names = F)

##Example map
install.packages("rgdal")
library("rgdal")
# Mapa pol?tico Colombia 2018 https://geoportal.dane.gov.co/servicios/descarga-y-metadatos/descarga-mgn-marco-geoestadistico-nacional/
poliCol <- shapefile("MGN_DPTO_POLITICO.shp")

# Data dimensions
extent(occ)

install.packages("rgeos")
library(rgeos)
# Corte de Raster, creaci?n de raster para el corte.
r <-  raster(xmn=-74.6,xmx=-72.4,ymn=5.7,ymx=8.2)
elev <- crop(elevCol, extent(r))
poli <- crop(poliCol, extent(r))
poli2 <- rasterize(poli, r, field = 1)

table <- read.csv("Smocc.csv", header = T, sep = ";")
occnames <- table$`?..Código`

dev.off()
jpeg("Map of Santander.jpeg", width =8.5, height = 6.9, units = "in", res = 1200)
map <- plot.new()
map <- par(mar = c(6, 5, 1, 1), mfrow = c(1,1), cex=1)
map <- plot(elev, ylab = "Decimal latitude", xlab = "Decimal longitude", asp = 1, ylim = c(5.6,8.2), xlim = c(-74.6, -72.4), cex.lab=1.3, cex.axis=1.3)
map <- plot(poli, add = TRUE)
map <- points(occ$decimalLongitude, occ$decimalLatitude, pch= c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,2,2,2,5,5,5,5,5,5,5),cex= 2, font=2, cex.lab=1.3, cex.axis=1.3)
#map <- legend("right", legend= occnames,pch = c(16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,15,15,15,15,15,15,15,17,17,17,4,4,4,4,4,4,4), merge = F,cex = 0.74, pt.cex = 0.74, text.font = 1, bty = "n")
#map <- mtext("Altitud (m.s.n.m.)", font = 2, line = 5.8, side = 4, las = 2, adj = 1.18, padj = -17, cex = 0.72)
dev.off()

