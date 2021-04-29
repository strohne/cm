#
# Erhebung von Daten von Wiki Data
#
# Pakete laden
library(WikidataR)
library(tidyverse)

# Suche nach einem Stichwort
bob.search <- find_item("Bob Ross")

# Suchergebnisse rausziehen
# Variante 1
df_search <- tibble(
  id = map_chr(bob.search,"id"),
  label = map_chr(bob.search,"label"),
  url = map_chr(bob.search,"url") 
)

# Variante 2 
df_search <- map_df(bob.search,~.[c("id","label","url")])


# Suche nach Liste von Stichwörtern
artists <- c("Andy Warhol",
             "Pablo Picasso",
             "Bob Ross",
             "Vincent van Gogh",
             "Leonardo da Vinci",
             "Henri Matisse",
             "Michaelangelo",
             "Jackson Pollock",
             "Claude Monet",
             "Salvador Dali")

artists.search <- map(artists,find_item)

# Suchergebnisse rausziehen
df_search <- tibble(res = artists.search)
#...und dann weiß ich noch nicht weiter



bob.item <- get_item(id="Q455511")
df_items <- get_item(id=df_search$id)


# Daten von einem Wikidata-Item bekommen
bob.item <- get_item(id="Q455511")
bob.properties <- get_property(id=names(bob.item$claims)[1])
bob.properties <- get_property(bob.item$claims[1])
# Statements: "genre" oder "influenced by" (https://www.wikidata.org/wiki/Q455511)

# artists.search <- find_item(search_term=c("Andy Warhol", "Pablo Picasso"))