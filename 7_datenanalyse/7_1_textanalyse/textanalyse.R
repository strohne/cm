#
# Beispiele zur Aufbereitung und Analyse von Texten
#



#
# Packages laden ----
#

library(tidyverse)
library(stringr)
library(readtext)
library(tidytext)
library(stopwords)
library(SnowballC)
library(widyr)
library(ggwordcloud)

#
# Texte einlesen ----
#

# Dateien aus dem Ordner korpus laden
texte <- readtext("korpus",encoding="UTF-8") 


#
# Texte aufbereiten ----
#

# Tokenisieren
woerter <- unnest_tokens(texte,wort,text,to_lower = F)

# In Kleinschreibung umwandeln
woerter <- woerter %>% 
  mutate(wort =  str_to_lower(wort,locale = "de"))


# Stoppwörter im Package stopwords anzeigen
# und in einem Tibble ablegen
stopwords("de")
stoppwoerter <- tibble(wort=stopwords("de"))

# Stoppwörter aus dem Korpus entfernen
woerter <- woerter %>% 
  anti_join(stoppwoerter,by="wort")


# Stemming mit dem Package SnowballC
woerter <- woerter %>% 
  mutate(stem =  wordStem(wort,language = "de"))

#
# Wörter zählen ----
#

# Anzahl der Wörter auszählen
woerter %>% 
  count(wort, sort = T)


# Abspeichern der 50 häufigsten Wörter in einem neuen Tibble
topterms <- woerter %>% 
  count(wort, sort = T) %>% 
  slice_head(n = 50)


# Topterms in einer Wordcloud visualiseren
topterms %>% 
  
  # Erstellen der Wordcloud 
  ggplot(aes(label = wort, size=n, color=n)) +
  geom_text_wordcloud() +
  
  # Formatieren der Wordcloud
  theme_bw(base_size = 10) +
  scale_size_area(max_size = 15) 

# Abspeichern der Wordcloud
ggsave("wordcloud.png",units="cm",width=20,height=10,dpi = 300)


# Kookkurrenz im gleichen Text auszählen (package widyr)
kookkurrenz <- woerter %>% 
  pairwise_count(wort,doc_id) 

  
#
# Tf-idf berechnen ----
#

# tf = term frequency = Häufigkeit eines Wortes / Anzahl aller Wörter je Dokument; 
#      umso höher umso häufiger ist das Wort im Dokument
# idf = inverse document frequency = log (Anzahl aller Dokumente / Anzahl der Dokumente mit dem Wort)
#      umso höher, umso seltener ist das Wort in allen Dokumenten
# tf_idf = tf x idf
#      umso höher, umso spezifischer ist das Wort für das Dokument    

tfidf <- woerter %>% 
  count(wort,doc_id) %>%
  bind_tf_idf(wort,doc_id,n) 


#
# Positive Pointwise Mutial Information berechnen (PPMI) ----
#

pmi <- woerter %>% 
  pairwise_count(wort,doc_id) %>% 
  
  mutate(p = n / sum(n)) %>%
  
  group_by(item1) %>% 
  mutate(n1=sum(n)) %>% 
  ungroup() %>% 
  mutate(p1=n1/sum(n)) %>% 
  
  group_by(item2) %>% 
  mutate(n2=sum(n)) %>% 
  ungroup() %>% 
  mutate(p2=n2/sum(n)) %>% 
  
  mutate(pmi = log(p / (p1 * p2)),
         ppmi = pmax(pmi,0))


#
# N-Gramme und Skip-Gramme analysieren ----
#


# Bigramme tokenisieren 
bigrams <- texte %>% 
  unnest_tokens(bigram,text,token="ngrams",n=2)

# Kollokationen zählen (pairwise_count)
bigrams  <- bigrams %>%
  mutate(bigram_no = row_number()) %>% 
  unnest_tokens(wort, bigram) %>% 
  pairwise_count(wort, bigram_no)

# Positive Pointwise Mutial Information berechnen (PPMI)
bigrams <- bigrams %>%
  
  # Auftretenswahrscheinlichkeit des Bigrams
  mutate(p = n / sum(n)) %>%
  
  # Auftretenswahrscheinlichkeit für Wort 1
  group_by(item1) %>% 
  mutate(n1=sum(n)) %>% 
  ungroup() %>% 
  mutate(p1=n1/sum(n)) %>% 
  
  # Auftretenswahrscheinlichkeit für Wort 2
  group_by(item2) %>% 
  mutate(n2=sum(n)) %>% 
  ungroup() %>% 
  mutate(p2=n2/sum(n)) %>% 
  
  # Berechnung von pmi
  mutate(pmi = log(p / (p1 * p2)),
         ppmi = pmax(pmi,0)) 


# Skip-Gramme ----

# Tokenisieren
# (Wörter mit einem Abstand zwischen 2 und 5 Wörtern)
skipgrams <- texte %>% 
  unnest_tokens(skipgram,text,token="skip_ngrams",n=2,n_min=2,k=5)

# Kollokationen zählen (pairwise_count)
skipgrams  <- skipgrams %>%
  mutate(no = row_number()) %>% 
  unnest_tokens(wort, skipgram) %>% 
  anti_join(stoppwoerter) %>% 
  pairwise_count(wort, no, diag = F, upper=T,sort = TRUE)

# Positive Pointwise Mutial Information berechnen (PPMI)
skipgrams <- skipgrams %>%
  mutate(p = n / sum(n)) %>%
  
  group_by(item1) %>% 
  mutate(n1=sum(n)) %>% 
  ungroup() %>% 
  mutate(p1=n1/sum(n)) %>% 
  
  group_by(item2) %>% 
  mutate(n2=sum(n)) %>% 
  ungroup() %>% 
  mutate(p2=n2/sum(n)) %>% 
  
  mutate(pmi = log(p / (p1 * p2)),
         ppmi = pmax(pmi,0))


