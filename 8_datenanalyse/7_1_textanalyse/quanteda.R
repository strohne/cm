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
texte_token <- tokens(texte, remove_punct=T)

# Keywords-in-Context zum Wort "daten"
kwic_daten <- kwic(texte_token,"daten")

# Document-Feature-Matrix
texte_dfm <- dfm(texte_token,tolower=TRUE) %>% 
  dfm_remove(stopwords("german")) %>% 
  dfm_wordstem("de")


topfeatures(texte_dfm, 20) 

dict <- dictionary(list(terror = c("terrorism", "terrorists", "threat"), economy = c("jobs", 
                                                                                     "business", "grow", "work")))
library(quanteda)

# the devtools package needs to be installed for this to work
devtools::install_github("kbenoit/quanteda.dictionaries") 
library(quanteda.dictionaries)
tmp <- data_dictionary_sentiws


output_lsd <- liwcalike(quanteda.corpora::data_corpus_movies, 
                        dictionary = data_dictionary_NRC)
