# 3. faza: Izdelava zemljevida

# Najprej je treba naloziti paketa za delo z zemljevidi.
library(sp)
library(maptools)
gpclibPermit()

#Narišemo zemljevid (zaradi preglednosti sem izpustil zvezno državo Alasko)
pdf("D:/APPR-2014-15/slike/drzave_zda.pdf", width=6, height=4)

USA <- readShapeLines("D:/APPR-2014-15/podatki/usa/statesp020.shp")

nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
states <- USA[!(USA$STATE %in% nocemo),]
plot(states)


#Vrišemo glavna mesta na zemljevid
capitals <- read.csv("D:/APPR-2014-15/podatki/uscapitals.csv", row.names = 1)
points(coordinates(capitals[c("long", "lat")]),
       col = "red",
       pch = 10, cex = 0.2)

text(coordinates(capitals[c("long", "lat")]), labels = capitals$capital,
     pos = 1, cex = 0.4, offset = 0.1)

dev.off()
