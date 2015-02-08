# 3. faza: Izdelava zemljevida

# Najprej je treba naloziti paketa za delo z zemljevidi.
library(sp)
library(maptools)
library(rgeos)
gpclibPermit()

source("lib/uvozi.zemljevid.r")

pdf("slike/drzave_zda.pdf")

# USA1 <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/USA_adm.zip",
#                        "USA", "USA_adm1.shp", mapa = "zemljevidi")

USA <- uvozi.zemljevid("http://audrey.fmf.uni-lj.si/states_21basic.zip",
                          "USA", "states.shp", mapa = "zemljevid")

nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
states <- USA[!(USA$STATE_NAME %in% nocemo),]

m <- match(states$STATE_NAME, rownames(ZDA))
pop <- ZDA[m,4] # populacija je v 4. stolpcu
n <- 4 # 4 kategorije
q <- quantile(pop, (1:n)/n, na.rm = TRUE)
barve <- topo.colors(n)
plot(states, border = "dimgray", col = barve[sapply(pop, function(x) which(x <= q)[1])],
     main = "ZDA deljena v skupine glede na populacijo")

legend("bottomleft",
       legend=c("Največja populacija", "Visoka populacija", "Nizka populacija", "Najnižja populacija"), col=c("yellow","green","cyan","blue"),
       lty = c("solid", "solid", "solid", "solid"),
       lwd = c(10, 10, 10, 10),
       bg = "white",
       title="Legenda")

#Vrišemo glavna mesta na zemljevid
#Iz datoteke uscapitals.csv sem izvzel določena imena glavnih mest zaradi prenatrpanosti
capitals <- read.csv("podatki//uscapitals_1.csv", row.names = 1)

points(coordinates(capitals[c("long", "lat")]),
       col = "red",
       pch = 10, cex = 0.2)

text(coordinates(capitals[c("long", "lat")]), labels = capitals$capital,
     pos = 1, cex = 0.4, offset = 0.1)

dev.off()
