# 3. faza: Izdelava zemljevida

# Najprej je treba naloziti paketa za delo z zemljevidi.
library(sp)
library(maptools)
gpclibPermit()

#Narišemo zemljevid (zaradi preglednosti sem izpustil zvezno državo Alasko)
pdf("slike/drzave_zda.pdf", width=6, height=4)

USA <- readShapeLines("D:./././podatki/usa/statesp020.shp")

nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
contiguous.states <- USA[!(USA$STATE %in% nocemo),]
barve= if contiguous.states$AREA > 10, ["red"], ["green"]
plot(contiguous.states, col=barve)

#Vrišemo glavna mesta na zemljevid

text(coordinates(capitals[c("long", "lat")]), labels = capitals$capital,
     pos = 1, cex = 0.6, offset = 0.3)



dev.off()
