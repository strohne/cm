#
# Topic Modeling 
#

library(tidyverse)
library(quanteda)

library(tidytext)
library(topicmodels)
library(ldatuning)


#
# Document-Feature-Matrix einlesen ----
#

dfm <- read_rds("data/usenews.mediacloud.wm.2020.sample.rds")
dfm


# Liste der Dokumente aus dem DFM auslesen
# (wird später für die Validierung benötigt)
docs <- tibble(
  document = docid(dfm),
  docvars(dfm, c("title", "media_name", "url"))
)

# Anzahl der Dokumente je Medium
docs %>% 
  count(media_name)

#
# Grid Search ---- 
#

#
# Optimale Parameter für die Anzahl der Themen finden (k),
# indem in 10-SChritten je ein Modell mit 5 bis 55 Topics berechnet wird.
gridsearch_k <- FindTopicsNumber(
  dfm,
  topics = seq(from = 5, to = 55, by = 10),
  metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
  control = list(seed = 77),
  mc.cores = 7L,
  verbose = TRUE
)

# Interpretation der Metriken: 
# - Arun2010 & CaoJuan2009 sollten minimal werden
# - Deveaud2014 & Griffith2004 sollten maximal werden
FindTopicsNumber_plot(gridsearch_k)


#
# Topic Modeling ----
#

# Modell mit 10 Topics erstellen
# - das dauert eine Weile
# - der Seed stellt sicher, dass trotz des 
#   zufallsbasierten Verfahrens immer das
#   gleiche Ergebnis entsteht
fit <- LDA(dfm, k = 10, control = list(seed = 48))


# Wahrscheinlichkeit, mit der ein Term zu einem Topic gehört
lda_woerter <- tidy(fit, matrix = "beta")

# Wahrscheinlichkeit, mit der ein Dokument ein Topic enthält
lda_docs <- tidy(fit, matrix = "gamma")


#
# Validierung ----
#

# Top-Wörter auswerten
top_woerter <- lda_woerter %>% 
  group_by(topic) %>%
  slice_max(beta, n = 15)%>%
  ungroup() 

# Top-Wörter visualisieren
top_woerter %>%
  mutate(
    thema = factor(topic),
    wort = reorder_within(term, beta, topic)
  ) %>%
  ggplot(aes(wort, beta, fill = thema)) +
  geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) +
  scale_x_reordered() +
  facet_wrap(facets = vars(thema), scales = "free", ncol = 2) +
  coord_flip() + 
  theme_bw(base_size = 10)


# Top-Dokumente zusammenstellen
top_docs <- lda_docs %>%  
  group_by(topic) %>%
  slice_max(gamma, n = 5) %>%
  ungroup()


# Liste der Dokumente aus dem DFM an die Top-Dokumente anfügen
top_docs <- left_join(top_docs, docs, by = "document")


