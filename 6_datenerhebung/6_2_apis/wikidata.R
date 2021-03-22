#
# Erhebung von Daten von Wiki Data
#
# Pakete laden
library(WikidataR)
library(tidyverse)

# Suche nach einem Stichwort
bob.search <- find_item("Bob Ross")

df_search <- tibble(
  id = map(bob.search,"id"),
  label = map(bob.search,"label"),
  url = map(bob.search,"url") 
)

bob.item <- get_item(id="Q455511")
df_items <- get_item(id=df_search$id)


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
artists.search <- find_item(search_term=artists)

artists.search <- map(artists,find_item)



# Daten von einem Wikidata-Item bekommen
bob.item <- get_item(id="Q455511")
bob.properties <- get_property(id=names(bob.item$claims)[1])
bob.properties <- get_property(bob.item$claims[1])
# Statements: "genre" oder "influenced by" (https://www.wikidata.org/wiki/Q455511)

# artists.search <- find_item(search_term=c("Andy Warhol", "Pablo Picasso"))