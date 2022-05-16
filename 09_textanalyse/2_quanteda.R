#
# Beispiele für Textanalyse mit Quanteda
#

# Zur Einführung siehe auch https://quanteda.io/articles/pkgdown/quickstart.html

#
# Packages laden ----
#

library(tidyverse)
library(quanteda)
library(readtext)


#
# Daten laden ----
#

# Dateien aus dem Ordner korpus laden
texte <- readtext("korpus",encoding="UTF-8")

# In quanteda-Corpus umwandeln
texte <- corpus(texte)

# Überblick über das Korpus
summary(texte)

# In quanteda-Token unterteilen
texte_token <- tokens(texte, remove_punct=T)

# Keywords-in-Context zum Wort "daten"
kwic_daten <- kwic(texte_token,"daten")

# Document-Feature-Matrix
texte_dfm <- dfm(texte_token,tolower=TRUE) %>% 
  dfm_remove(stopwords("german")) %>% 
  dfm_wordstem("de")


topfeatures(texte_dfm, 20) 

#
# Diktionärsbasierte Inhaltsanalyse ----
#

# Festlegen eines Diktionärs
dict <- dictionary(list(
  datenschutz = c("datenschutz", "daten","schutz","dsgvo"), 
  werbung = c("werbung","werben")))


# Anwenden eines Diktionärs
coded <- dfm_lookup(texte_dfm,dict) %>% 
  convert("data.frame")
