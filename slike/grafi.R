pdf("slike/grafi.pdf")

#grafični prikaz populacije z imeni držav

barplot(ZDA_area[1:51, c(5)]/100000, horiz=TRUE, names.arg = ZDA[1:51,c(1)],
        cex.names=0.7, col = rainbow(50), xlab = "Area (Mi^2) x 100000", ylab = "States", las=1,
        main = "Graf velikosti")

dev.off()


pdf("slike/grafi2.pdf")

#grafični prikaz populacije za vse države

barplot(ZDA_pop[1:51, c(4)]/1000000, horiz=TRUE, names.arg = ZDA_pop[1:51,1],
        cex.names=0.7, col = rainbow(50), xlab = "Population x 1000000", ylab = "States", las=1,
        main = "Graf prebivalstva")

dev.off()

leto <- demographics$Year
pop <- demographics$Population.x1000

pdf("slike/grafi3.pdf")

#prikaz spremembe populacije po letih

plot(leto, pop / 1000, 
     xlab = "Year", ylab = "Population x1000000", type = "h", lwd = 3.2, col = "steelblue",
     main = "Graf predstavja prebivalstvo v celitnih ZDA")

dev.off()
