##Pearson correlation analysis##
##LMMA-UIS##
##Jose Cediel##

setwd("D://7to_semestre_UIS/TRABAJO_DE_GRADO_1/Espectofotometría_pigmento/Extracción_con_Metanol/SPF-PRO/")
datos<- read.csv2("SPF-PRO.csv",header = T,sep=";")
attach(datos)
jpeg("FigureX.jpeg", width =28, height = 20, units = "cm", res = 1200)
par(mar = c(5, 6, 3, 4))

plot(SPF1~ PRO1, ylab = expression("SPF" * italic("" ["in vitro"])), xlab = expression("Prodigiosin (µg/mL)"), col ="black",cex.lab = 1.6,  cex.axis = 1.6, cex=2.0, pch=1, ylim=c(0,25), xlim=c(0,82))

  cor.test(x = SPF1, y = PRO1, method = "pearson")
  modelo_lineal <- lm(SPF1~ PRO1, tabla)
  summary(modelo_lineal)
  abline(modelo_lineal, lwd=3)
  legend(x = 40, y = 12, legend = c("Y = 0.2934x - 0.7041", "R = 0.99 (p < 0.05)"), bty = "n", text.col = "black", cex = 1.6)
  
  ley1 <- expression("Pure compound")
  #ley2 <- expression(italic("S. marcescens ") * "extracts")
  leyenda <- c(ley1)
  legend("topleft",
         legend = leyenda, pch = c(1), cex = 1.6, pt.cex = 2, bty = "n")
  
  dev.off()
  
  
  
 
  