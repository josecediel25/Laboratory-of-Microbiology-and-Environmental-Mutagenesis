##Principal Component Analysis##
##LMMA-UIS
##Jose Cediel##

setwd("D://7to_semestre_UIS/TRABAJO_DE_GRADO_1/Espectofotometría_pigmento/Extracción_con_Metanol/Datos ambientales/")
data <- read.csv("Ambientales.csv", sep = ";")
View(data)
attach(data)
env2 <- data[,5:9]
pca <- prcomp(env2, scale = TRUE) 
summary(pca)
str(pca)
library(factoextra)
get_eig(pca)
fviz_screeplot(pca, ncp = 2, addlabels = T, barfill = "#CCE5FF") + ylim(0,80) + labs(title = "Varianza explicada por cada C.P") + theme(plot.title = element_text(hjust = 0.5))
data$PLA <- as.factor(data$Localities.sampled)
par(mfrow =  c(1,1))
library(ggfortify)
autoplot(pca, data = data, colour = 'Localities.sampled', loadings = T, loadings.colour = "#660033") + theme_light()
jpeg("PCA1.jpeg", width=20, height = 12, units = "cm", res = 1200)
autoplot(pca, data = data, colour = 'Localities.sampled', loadings = T, loadings.label = F, loadings.label.size = 5, loadings.colour = "#660033", loadings.label.colour = "#202020") + theme_light() + stat_ellipse(type = "norm", level=0.78, aes(color = Localities.sampled)) + theme(text = element_text(family = "Calibri"))
dev.off()

