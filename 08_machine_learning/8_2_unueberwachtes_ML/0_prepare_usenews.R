#
# Aufbereitung des UseNews-Datensatzes für ein Topic-Modeling-Beispiel
#
# - Relative Pruning (seltene und häufige Wörter entfernen)
# - Eingrenzung auf deutsche Medien (Spiegel und Bild)

#
# Packages laden ----
#

library(tidyverse)
library(quanteda)
library(writexl)

#
# Texte einlesen ----
#

# Download from https://osf.io/uzca3/
dfm <- read_rds('data/usenews.mediacloud.wm.2020.rds')

# Liste der Document-Feature-Matrizen zu einer DFM verbinden
# (braucht sehr lange)
dfm <- do.call(rbind, dfm)

# Nur deutsche Medien behalten
dfm_german <- lapply(dfm, function(x) {dfm_subset(x, str_detect(docvars(x, "media_url"), "\\.de$"))})
dfm_german = dfm_german[sapply(dfm_german, nrow) > 0]
dfm_german <- do.call(rbind, dfm_german)
dfm_german

#write_rds(dfm_german,"data/usenews.mediacloud.wm.2020.german.rds",compress="gz")
#dfm_german <- read_rds("data/usenews.mediacloud.wm.2020.german.rds")

#
# Texte aufbereiten ----
#


# Nur Wörter behalten, die in maximal 10% der Dokumente vorkommen und 
# die häufiger als das 80%-Quantil sind. Auf diese Weise werden 
# unter anderem Stoppwörter aussortiert.
dfm_german <- dfm_trim(
  dfm_german, 
  min_termfreq = 0.8, termfreq_type = "quantile", 
  max_docfreq = 0.1, docfreq_type = "prop"
)

dfm_german


#
# Sample ----
#

set.seed(1852)
dfm_small <- dfm_sample(dfm_german, size = 5000)
dfm_small <- dfm_trim(dfm_small, min_termfreq = 1, termfreq_type = "count")

#
# Abspeichern ----
#

write_rds(dfm_small, "data/usenews.mediacloud.wm.2020.german.pruned.small.rds", compress="gz")

