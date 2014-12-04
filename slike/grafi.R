pdf("slike/grafi.pdf", paper="a4r")
#grafični prikaz populacije z imeni držav
barplot(ZDA[1:6,c(4)], names.arg = c(ZDA[1:6,1]), col = rainbow(50), xlab = "States", ylab = "Population")
#grafični prikaz populacije za vse države
barplot(ZDA[1:51,c(4)], col = rainbow(50), xlab = "States", ylab = "Population")
dev.off()