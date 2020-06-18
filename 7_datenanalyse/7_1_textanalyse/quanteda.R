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

# In ein quanteda-Korpus umwandeln
texte <- corpus(texte)
summary(texte)

#
# Keywords in Context ----
#

kwic_daten <- kwic(texte,"daten")
