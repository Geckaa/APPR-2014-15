# 3. faza: Izdelava zemljevida

# Najprej je treba naloziti paketa za delo z zemljevidi.
library(sp)
library(maptools)
gpclibPermit()

source("lib/uvozi.zemljevid.r")

pdf("slike/drzave_zda.pdf")

USA <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/USA_adm.zip",
                       "USA", "USA_adm1.shp", mapa = "zemljevidi")

nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
states <- USA[!(USA$NAME_1 %in% nocemo),]

m <- match(states$NAME_1, rownames(ZDA))
pop <- ZDA[m,5] # populacija je v 5. stolpcu
n <- 4 # 4 kategorije
q <- quantile(pop, (1:n)/n, na.rm = TRUE)
barve <- topo.colors(n)
plot(states, col = barve[sapply(pop, function(x) which(x <= q)[1])])


#Vrišemo glavna mesta na zemljevid
capitals <- read.csv("podatki/uscapitals.csv", row.names = 1)
points(coordinates(capitals[c("long", "lat")]),
       col = "red",
       pch = 10, cex = 0.2)

text(coordinates(capitals[c("long", "lat")]), labels = capitals$capital,
     pos = 1, cex = 0.4, offset = 0.1)

dev.off()
