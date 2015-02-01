# 4. faza: Analiza podatkov

#Leto 1935 je naše izhodišče, zato ga postavimo kot leto 0

pdf("slike/populacija.pdf")

plot(leto, pop, xlab = "Leto", ylab = "Populacija x 1000000")

leto <- demographics$Year - 1900
pop <- demographics$Population.x1000 / 1000

#Npišemo funkcijo za linearno rast

linearna <- lm(pop ~ leto)
abline(linearna, col="blue")

#Preverimo če je populacija kvadratna funkcija

kvadratna <- lm(pop ~ I(leto^2) + leto)
curve(predict(kvadratna, data.frame(leto=x)), add = TRUE, col = "red")   

#Loess model za primerjavo (model loess uporablja lokalno prilagajanje)

loess <- loess(pop ~ leto)

#Pogledamo ostanke pri modelih. Tisti, ki ima manjši ostanek je bolj natančen
ostanki <- sapply(list(linearna, kvadratna, loess, power3, power4, power9), function(x) sum(x$residuals^2))

dev.off()

#Narisali bomo napoved za rast prebivalstva do leta 2030 po modelu za modeala linear in kvadratna

pdf("slike/napoved.pdf")

plot(demographics$Year, pop, xlim = c(1935, 2050), ylim = c(120, 450), 
     xlab = "Leto", ylab = "Populacija (v mil)")     

napoved <- function(x,model){predict(model, data.frame(leto=x-1900))}

curve(napoved(x, linearna), add= TRUE, col = "blue")
curve(napoved(x, kvadratna), add = TRUE, col = "red")

dev.off()
