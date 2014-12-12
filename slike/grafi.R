pdf("slike/grafi.pdf", paper="a4r")
#grafični prikaz populacije z imeni držav
barplot(ZDA[1:6,c(4)], names.arg = c(ZDA[1:6,1]), col = rainbow(50), xlab = "States", ylab = "Population")
#grafični prikaz populacije za vse države
barplot(ZDA[1:51,c(4)],horiz=TRUE, names.arg = c(ZDA[1:51,1]), cex.names=0.7, col = rainbow(50), xlab = "Population", ylab = "States", las=1)
dev.off()
