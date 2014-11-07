# Analiza podatkov s programom R, 2014/15

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Tema mojega projekta je analiza vseh posameznih držav iz ZDA. V projektu bom za vsako državo podal: njeno glavno mesto - imenska, njeno velikost (podano v km^2) - številska, njeno populacijo -številska, gostoto prebivalstva (1/km^2) - številska, kolikšen del države predstavljajo vode (reke/jezera) -številska in ali med državami ZDA po velikosti spada med večje al manjše - urejenostna.

Moj cilj je pridobiti idejo o porazdelitvi prebivalstva v celotni ZDA prav tako kot o vsaki državi posebej.

Podatke bom za vsako državo posebej pridobil na strani Wikipedie (za Kentucky: http://en.wikipedia.org/wiki/Kentucky in enako za vse ostale), vse podatke bom shranil v tabelo, ki jo bom potem lahko uvozil v R.

## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
