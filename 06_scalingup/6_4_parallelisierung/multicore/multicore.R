#
# Beispiel für die Parallelisierung auf mehreren Kernen
# eines Computers. Im Beispiel wird die Kosinusähnlichkeit
# von Texten berechnet.
#


#
# Packages laden ----
#

library(tidyverse)
library(quanteda)
library(quanteda.textstats)
library(furrr)
library(tictoc)

#
# Document-Feature-Matrix einlesen ----
#

dfm <- read_rds("usenews_small.rds")
dfm


#
# Parallelisierung ----
#


# Chunks erstellen
chunks <- sample(30, nrow(dfm), replace=TRUE)
chunks <- split( c(1:nrow(dfm)) , chunks)

# Vier Worker initialisieren
plan(multicore,workers=4)

# Startzeit merken
tic()

# Berechnung starten
sim <- future_map_dfr(
  chunks,
  
  function (chunk) {
    textstat_simil(
      dfm, 
      dfm[chunk,],
      margin="documents",
      method="cosine", 
      min_simil = 0.8
    ) %>% as_tibble()
  },
  .progress = T
)

# Laufzeit ausgeben
toc()


#
# Ergebnis ----
#

# Titel, URL und Datum an die Liste Ã¤hnlicher Dokumente joinen
docs <- tibble(docname=docnames(dfm),docvars(dfm))
sim <- sim %>% 
  left_join(select(docs,document1=docname,doc1_title=title,doc1_url=url,doc1_date=publish_date), by="document1") %>%
  left_join(select(docs,document2=docname,doc2_title=title,doc2_url=url,doc2_date=publish_date), by="document2")


