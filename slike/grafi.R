pdf("slike/grafi.pdf")

#grafični prikaz populacije z imeni držav

barplot(ZDA[1:51,c(6)]/100000, horiz=TRUE, names.arg = ZDA[1:51,c(1)], cex.names=0.7, col = rainbow(50), xlab = "Area (Mi^2) x 100000", ylab = "States", las=1)

dev.off()


pdf("slike/grafi2.pdf")

#grafični prikaz populacije za vse države
barplot(ZDA_po_pop.[1:51,c(5)]/1000000, horiz=TRUE, names.arg = ZDA_po_pop.[1:51,1], cex.names=0.7, col = rainbow(50), xlab = "Population x 1000000", ylab = "States", las=1)

dev.off()


pdf("slike/grafi3.pdf")

#prikaz spremembe populacije po letih

leto <- USA_demographics$Year
pop <- USA_demographics$Population.x1000

plot(leto, pop, 
     xlab = "Year", ylab = "Population x1000", type = "h", lwd = 3.2, col = "steelblue")

dev.off()
