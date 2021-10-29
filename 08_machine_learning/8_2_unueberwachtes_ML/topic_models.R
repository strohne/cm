#
# Pakete laden ---- 
#

library(tidyverse)
library(tidytext)
library(stopwords)
library(ldatuning)
library(topicmodels)


#
# Korpus einlesen ----
#

texte <- read_csv2("korpus/artikel.csv")

#
# Aufbereitung ---- 
#

# In Wörter aufteilen (unnest_tokens),
# Häufigkeit eines Wortes je Artikel auszählen
woerter <- texte %>% 
  unnest_tokens(wort,text) %>% 
  count(id,wort) 

# Stoppwörter und Wörter aus Zahlen oder 
# Sonderzeichen entfernen
pruning <- c("dass", stopwords("de"))

woerter <- woerter %>% 
  anti_join(tibble(wort=pruning)) %>%
  filter(str_detect(wort, "^[a-zöäü]")) 

# Document-Term-Matrix erstellen
dtm <- woerter %>% 
  cast_dtm(id, wort, n)

# Visualisierung Document-Term-Matrix
t(as.matrix(dtm[1:10,1:10]))


#
# Topic Modeling ----
#

# Modell zunächst mit 10 topics erstellen (dauert eine Weile)
#  (seed stellt sicher, dass Zufallsfunktionen immer zum gleichen Ergebnis kommen)
topmod <- LDA(dtm, k=3, control=list(seed=48))


# Wahrscheinlichkeit, mit der ein Term zu einem Topic gehört
lda_woerter <- tidy(topmod, matrix="beta")


# Wahrscheinlichkeiten der Themen, die in einem Dokument enthalten sind. 

lda_topics <- tidy(topmod, matrix="gamma")


#
# Validierung ----
#

# Top-Wörter auswerten
top_woerter <- lda_woerter %>% 
  group_by(topic) %>%
  top_n(15, beta) %>%
  ungroup() %>%
  arrange(topic, beta)

# Top-Wörter visualisieren
top_woerter %>%
  mutate(
    thema = factor(topic),
    wort = reorder_within(term, beta, topic)
  ) %>%
  ggplot(aes(wort, beta, fill = thema)) +
  geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(facets = vars(thema), scales = "free", ncol = 3) +
  coord_flip() + 
  theme_bw(base_size=12)

ggsave("top_woerter.png", dpi=300, height=3, width=7)


# Dokumente auswerten
top_doc <- lda_topics %>%  
  group_by(topic) %>%
  top_n(3, gamma) %>%
  ungroup()


#
# Grid Search ---- 
#

# Grid Search: Optimale Parameter für die Anzahl der Themen finden (k)
# - FindTopicsNumber() berechnet die unterschiedlichen Modelle 
# - topics: Anzahl der Themen von 1 bis 7 festlegen, je in 1er-Schritten (by)
gridsearch_k <- FindTopicsNumber(
  dtm,
  topics = seq(from = 1, to = 7, by = 1),
  metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
  control = list(seed = 77),
  mc.cores = 2L,
  verbose = TRUE
)

# Plotten: 
# - minimieren von Arun2010, CaoJuan2009
# - maximieren von Deveaud2014, Griffith2004
FindTopicsNumber_plot(gridsearch_k)


