#
# Beispiele für Textanalyse mit Quanteda
#

# Zur Einführung siehe auch https://quanteda.io/articles/pkgdown/quickstart.html

#
# Packages laden ----
#

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
token <- tokens(texte)

# Keywords-in-Context zum Wort "daten"
kwic_daten <- kwic(token,"daten")

