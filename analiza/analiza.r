# 4. faza: Analiza podatkov

#Leto 1935 je naše izhodišče, zato ga postavimo kot leto 0

pdf("slike/populacija.pdf")

leto <- demographics$Year - 1900
pop <- demographics$Population.x1000 / 1000

plot(leto, pop, xlab = "Leto", ylab = "Populacija x 1000000")

legend(40, 300, c("Linerana", "Kvadratna"), lty=c(1,1), col = c("blue","red"))

#Npišemo funkcijo za linearno rast

linearna <- lm(pop ~ leto)
abline(linearna, col="blue")

#Preverimo če je populacija kvadratna funkcija

kvadratna <- lm(pop ~ I(leto^2) + leto)
curve(predict(kvadratna, data.frame(leto=x)), add = TRUE, col = "red")  

#Loess model za primerjavo (model loess uporablja lokalno prilagajanje)

loess <- loess(pop ~ leto)

#Pogledamo ostanke pri modelih. Tisti, ki ima manjši ostanek je bolj natančen

vsota.kvadratov <- sapply(list(linearna, kvadratna, loess), function(x) sum(x$residuals^2))

dev.off()

#Narisali bomo napoved za rast prebivalstva do leta 2030 po modelu za modeala linear in kvadratna

pdf("slike/napoved.pdf")

plot(demographics$Year, pop, xlim = c(1935, 2050), ylim = c(120, 450), 
     xlab = "Leto", ylab = "Populacija (v mil)",
     main = "Predvidena rast prebivalstva po različnih modelih")     
abline(h = 400,col = "black", lwd = 1.5, lty = 1)

#Presečišča izračunamo na roko

points(2040, 400,  col = "black", pch = 21)
points(2048, 400,  col = "black", pch = 21)

#V presečiščih potegnemo navpične črte

abline(v=2040, col = "magenta", lty = 1)
abline(v=2048, col = "magenta", lty = 1)


napoved <- function(x,model){predict(model, data.frame(leto=x-1900))}

curve(napoved(x, linearna), add= TRUE, lwd = 1.5, col = "blue")
curve(napoved(x, kvadratna), add = TRUE, lwd = 1.5, col = "red")

#Narišemo še legendo
legend(1932, 380, c("Linerana (lm(pop ~ leto))", "Kvadratna (lm(pop ~ I(leto^2) + leto))",
                    "400 miljonov prebivalcev"),
       lty=c(1,1), col = c("blue","red", "black"))

dev.off()




# Narisali bomo še graf ZDA po gostoti prebivalstva, saj je to ena izmed stvari, ki me je 
# na začetku zanimala

#Paketi za delo z zemljevidi
library(sp)
library(maptools)
library(rgeos)
gpclibPermit()

pdf("slike/gostota.pdf")

USA <- uvozi.zemljevid("http://audrey.fmf.uni-lj.si/states_21basic.zip",
                       "USA", "states.shp", mapa = "zemljevid")

nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
states <- USA[!(USA$STATE_NAME %in% nocemo),]

m <- match(states$STATE_NAME, rownames(ZDA))

gostota <- ZDA[,8]
max.gostota <- max(gostota)
min.gostota <- min(gostota)
norm.gostota <- (gostota - min.gostota)/(max.gostota - min.gostota)
#Uporabimo koren zaradi bolj enakomerne porazdelitve
barve <- rgb(1, 0, 0, sqrt(norm.gostota))

k <- 8 # število stopenj
stopnje <- seq(min.gostota, max.gostota, (max.gostota - min.gostota)/(k-1))
norm.stopnje <- (stopnje - min.gostota)/(max.gostota - min.gostota)
barve.stopnje <- rgb(1, 0, 0, sqrt(norm.stopnje))

plot(states, col = barve[m])
title( main = expression(paste("Gostota prebivalstva podana v ", 1/mi^2)))

legend("bottomleft", legend = round(stopnje), fill = barve.stopnje, cex = 0.7)

dev.off()



#k-means clustering
#Iz tabelele ZDA poberemo vse imenske spremenljivke (Abbr, Capital, Largest.City, Size)

data <- ZDA
data$Abbr <- NULL 
data$Capital<- NULL 	
data$Largest.City <- NULL 
data$Size<- NULL 

data1 <- scale(data)

#Narišemo nekaj grafov

rezultati <- kmeans(data1, centers = 4)
center <- rezultati$centers
skupina <- rezultati$cluster
barve <- c("red", "green", "blue", "yellow")

pdf("slike/clustering_1.pdf")


plot(data[,"Population.2013"]/1000000,data[,"Pop.Density"], col = barve[skupina],
     xlab = "Populacija v milijonih", ylab = "Gostota prebivalstva",
     main = "Razvrščanje - Odvisnost gostote od populacije")

dev.off()

pdf("slike/clustering_2.pdf")

plot(data[,"Total.area.in.mi2"]/1000, data[,"Population.2013"]/1000000, col = barve[skupina],
     xlab = "Velikost x 1000 (mi^2)", ylab = "Populacija v milijonih",
     main = "Razvrščanje - Odvisnot populacije od velikosti države")

dev.off()

pdf("slike/clustering_3.pdf")

plot(data[,"Total.area.in.mi2"]/1000, data[,"Pop.Density"], col = barve[skupina],
     xlab = "Velikost x 1000 (mi^2)", ylab = "Gostota prebivalstva",
     main = "Razvrščanje - Odvisnost gostote od velikosti države")

dev.off()

#Narišemo še zemljevid in ga pobarvamo po skupinah

pdf("slike/zemljevid_grupe.pdf")

USA <- uvozi.zemljevid("http://audrey.fmf.uni-lj.si/states_21basic.zip",
                       "USA", "states.shp", mapa = "zemljevid")
                       
nocemo <- c("Alaska", "Hawaii", "Puerto Rico", "U.S. Virgin Islands")
states <- USA[!(USA$STATE_NAME %in% nocemo),]

plot(states, col = barve[skupina])
title( main = "Države razdeljene po skupinah glede na k-means razvrščanje")

dev.off()
