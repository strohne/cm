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

# In quanteda-Token umwandeln
texte <- tokens(texte)

# Überblick über das Korpus
summary(texte)

# Keywords in Context zum Wort "daten"
kwic_daten <- kwic(texte,"daten")

