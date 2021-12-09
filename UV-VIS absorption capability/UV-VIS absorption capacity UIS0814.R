##UV-VIS absorption capability figure##
##LMMA-UIS##
##Jose Cediel##

setwd("D://7to_semestre_UIS/TRABAJO_DE_GRADO_1/Espectofotometría_pigmento/Extracción_con_Metanol/CEPA UIS0814/")

tabla<-read.csv2("UIS0814.csv")
names(tabla)
attach(tabla)

x = tabla$nm
y = c(X100., X50., X25., X12.5., X6.25., X3.12.)
err = c(EE, EE.1, EE.2, EE.3, EE.4, EE.5)

jpeg("Spectrum-UIS0814.jpeg", width=28, height = 20, units = "cm", res = 1200)
par(mar = c(5, 6, 3, 3))

plot( X100.~ nm, xlab = "Wavelength (nm)", ylab = "Absorbance", ylim = c(0, 4),xlim=c(200,600),type = "n", cex.lab=1.6, cex.axis=1.6) +
  arrows(x, y - err, x, y + err, length = 0.06, angle = 90, code = 3) +
  lines(X100.~ nm, col = "black", type = "o", pch = 1,bg="white", cex = 1.8) +
  lines(X50. ~ nm, col = "black", type = "o", pch = 2, bg="white", cex = 1.8) +
  lines(X25. ~ nm, col = "black", type = "o", pch = 5, bg="white", cex = 1.8) +
  lines(X12.5.~ nm, col = "black", type = "o", pch = 6, bg="white",cex = 1.8) +
  lines(X6.25.~ nm, col = "black", type = "o", pch = 11, bg="white", cex = 1.8) +
  lines(X3.12.~ nm, col = "black", type = "o", pch = 7, bg="white",cex = 1.8)

#title(list("Extract UIS0814", cex = 1.5))
legend(325,4.15, legend=c("40.8 μg/mL(λc = 370 nm)","19.4 μg/mL(λc = 360 nm)","11.9 μg/mL(λc = 370 nm)","4.3 μg/mL(λc = 360 nm)","2.3 μg/mL(λc = 360 nm)","0.9 μg/mL(λc = 360 nm)"),pch = c(1, 2, 5, 6, 11, 7),pt.bg = c("white", "white", "white", "white", "white", "white"), cex = 1.5,pt.cex =c(1.8,1.8,1.8,1.8,1.8,1.8), bty="n")

#legend(x = "topright", inset = c(-0.28, 0),legend = c("100% (λc = 370 nm)", "50% (λc = 360 nm)","25% (λc = 370 nm)","12.5% (λc = 360 nm)","6.25% (λc = 360 nm)","3.12% (λc = 360 nm)","1.56% (λc = 350 nm)","0.78% (λc = 327 nm)"),
       #pch = c(1, 2, 5, 6, 11, 7, 4,14),pt.bg = c("white", "white", "white", "white", "white", "white", "white","white"), cex = 1.5,pt.cex =c(2.1,2.1,2.1,2.1,2.1,2.1,2.1,2.1),
       #xpd = TRUE, bty="n")

dev.off()

