# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke ZDA.csv
uvoziDrzave <- function() {
  return(read.table("podatki/ZDA_fixed.csv", sep = ";", as.is = TRUE, skip = 1,
                      col.names = c("State", "Capital city", "Largest city", "Population", 
                                    "Total area", "Land area", "Percentage of population", "Size"),
                      fileEncoding = "Windows-1250"))
}
cat("Uvažamo podatke o državah. \n")
ZDA <- uvoziDrzave()
