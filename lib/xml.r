# Uvoz s spletne strani
 
library(XML)
 
# Vrne vektor nizov z odstranjenimi začetnimi "prazninami" (whitespace)
# in iz vozlišč, ki ustrezajo podani poti.
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1",
                                gsub("^(.*?)\\[.*$", "\\1",
                                     xmlValue(y)))))
}
uvozi.drzave <- function() {
  url.drzave <- "http://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States"
  doc.drzave <- htmlTreeParse(url.drzave, useInternalNodes=TRUE)
  
  # Pobrišemo nevidno vsebino
  for (t in getNodeSet(doc.drzave, "//span[@style='display:none']")) {
    xmlValue(t) <- ""
  }
  
  # Poiščemo vse tabele v dokumentu
  tabele <- getNodeSet(doc.drzave, "//table")
  
  # Iz prve tabele dobimo seznam vrstic (<tr>) neposredno pod
  # trenutnim vozliščem
  vrstice <- getNodeSet(tabele[[1]], "./tr")
  
  # Seznam vrstic pretvorimo v seznam (znakovnih) vektorjev
  # s porezanimi vsebinami celic (<td>) neposredno pod trenutnim vozliščem
  seznam <- lapply(vrstice[2:length(vrstice)], stripByPath, "./td")
  
  # Iz seznama vrstic naredimo matriko
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  
  # Imena stolpcev matrike dobimo iz celic glave (<th>) v prvi vrstici
  colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[1]], ".//th")[-1])
  # Imena vrstic matrike dobimo iz celic glave (<th>) v ostalih vrsticah
  rownames(matrika) <- unlist(lapply(vrstice[2:length(vrstice)], stripByPath, "./th"))
  
  # Podatke iz matrike spravimo v razpredelnico
  # Prvi 4 stolpci: besedilo - pustimo, kot je
  # Zadnjih 5 stolpcev: številke - pobrišemo ločila tisočic in številke v oklepajih
  return(
    data.frame(matrika[,1:4], apply(gsub("([0-9]+).*", "\\1",
                                    gsub(",", "", matrika[,5:9])),
                                  2, as.numeric))
    )
  
}
