# Analiza podatkov s programom R, 2014/15

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Tema mojega projekta je analiza vseh posameznih držav iz ZDA. V projektu bom za vsako državo podal: njeno glavno mesto - imenska, največje mesto - imenska, njeno površino (podano v mi^2 in km^2) - številska, njeno površino zemlje (podano b mi^2 in km^2) - številska, njeno populacijo -številska, številska delež prebivalstva ZDA (%) - številska, in ali po velikosti sodi med večje ali manjše - urejenostna.

Moj cilj je pridobiti idejo o porazdelitvi prebivalstva v celotni ZDA prav tako kot gostoti.

Podatke sem pridobil na strani Wikipedie http://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States in http://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population.


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
