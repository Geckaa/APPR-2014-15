# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke ZDA.csv
uvoziDrzave <- function() {
  return(read.table("podatki/ZDA_fixed.csv", sep = ";", as.is = TRUE, skip = 1,
                    col.names = c("State", "Capital city", "Largest city", "Population", 
                                  "Total area", "Land area", "Percentage of population", "Size"),
                    fileEncoding = "Windows-1250"))
}
ZDA1 <- uvoziDrzave()

# Funkcija, ki uvozi podatke iz datoteke US_demographics.csv
demographics <- function() {
  return(read.table("podatki/US_demographics.csv", sep = ";", as.is = TRUE, skip = 1,
                    col.names = c("Year", "Population x1000"),
                    fileEncoding = "Windows-1250"))
}
USAdemographics <- demographics()

source("lib/xml.r")
ZDA <- uvozi.drzave()

#dodamo stolpec ki državo uvrsti po velikosti na tri razrede
attach(ZDA)
moznosti <- c("Large", "Average", "Small")
stolpec <- character(nrow(ZDA))
stolpec[Total.area.in.mi2..km2. > 100000] <- "Large"
stolpec[Total.area.in.mi2..km2. <100000 & Total.area.in.mi2..km2. > 50000] <- "Average"
stolpec[Total.area.in.mi2..km2. < 50000 ] <- "Small"
Size <- factor(stolpec, levels = moznosti, ordered = TRUE)
detach(ZDA)
ZDA <- data.frame(ZDA, Size)

ZDA$Statehood <- NULL
ZDA$House.seat.s. <- NULL

#Tabeli ZDA dodal stolpec z gostoto prebivalstva
ZDA["Pop.Density"] <- NA
ZDA$Pop.Density <- ZDA$Population..2013.est. / ZDA$ Total.area.in.mi2..km2.

#Tabeli ZDA dodal stolpec z gostoto prebivalstva (gledano samo na površino zemlje)
ZDA["Pop.Density.per.Land.area"] <- NA
ZDA$Pop.Density.per.Land.area <- ZDA$Population..2013.est. / ZDA$Land.area.in.mi2..km2.

#Tabeli ZDA dodal stolpec s podatkom kolikšen delež države je kopnega
ZDA["Percentage.of.Land.area"] <- NA
ZDA$Percentage.of.Land.area <-ZDA$Land.area.in.mi2..km2. / ZDA$Total.area.in.mi2..km2.

#Tabela  v kateri so države namesto po abecedi razporejene po populaciji
#To sem naredil da sem narisal graf kjer so države razporejene po populaciji namesti abecedi
ZDA_pop. <- ZDA[order(ZDA$Population..2013.est., decreasing=TRUE),]
