pdf("slike/grafi.pdf")

#grafični prikaz populacije z imeni držav
barplot(ZDA[1:51,c(6)]/100000, horiz=TRUE, names.arg = ZDA[1:51,1], cex.names=0.7, col = rainbow(50), xlab = "Area (Mi^2) x 100000", ylab = "States", las=1)

dev.off()

pdf("slike/grafi2.pdf")

#grafični prikaz populacije za vse države
barplot(ZDA[1:51,c(5)]/1000000, horiz=TRUE, names.arg = ZDA[1:51,1], cex.names=0.7, col = rainbow(50), xlab = "Population x 1000000", ylab = "States", las=1)

dev.off()
