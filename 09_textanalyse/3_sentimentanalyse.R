
#
# Packages laden ----
#

library(tidyverse)
library(readtext)
library(tidytext)
library(stopwords)
library(SnowballC)

# Theme für ggplot auf black & white setzen
theme_set(theme_bw())


#
# Texte einlesen ----
#

# Dateien aus dem Ordner korpus laden
texte <- readtext("korpus", encoding = "UTF-8") 

#
# Texte aufbereiten ----
#

# Tokenisieren
woerter <- unnest_tokens(texte, wort, text,to_lower = F)

# In Kleinschreibung umwandeln
# Nur Wörter ohne Sonderzeichen behalten
# Stoppwörter aus dem Korpus entfernen
# Stemming mit dem Package SnowballC
woerter <- woerter %>% 
  mutate(wort =  str_to_lower(wort, locale = "de")) %>% 
  filter(str_detect(wort, "^[a-zäüöß]+$")) %>% 
  anti_join( tibble(wort = stopwords("de")), by = "wort") %>% 
  mutate(stem =  wordStem(wort, language = "de"))


#
# SentiWS ----
#


# Diktionär einlesen
# - lemma:       Lemmatisierte Form
# - pos:         Wortart
# - sentiment:   Bewertung der Wörter (von -1=negativ bis +1=positiv)
# - inflections: Flektierte Wortformen
# - stem:        Wortstamm (mit SnowballC aus dem Lemma abgeleitet)

sentiws <- read_csv("sentiws/SentiWS20.csv", na="")

# Mittleres Sentiment je Wort berechnen
# ...denn Wortstämme können mehrfach auftreten
sentiws_mean <- sentiws %>% 
  group_by(stem) %>% 
  summarise(sentiment = mean(sentiment)) %>% 
  ungroup()

# Umkodierung in TRUE/FALSE-Werte
sentiws_mean <- sentiws_mean %>%
  mutate(sent_pos = ifelse(sentiment > 0, T, F)) %>% 
  mutate(sent_neg = ifelse(sentiment < 0, T, F))


#
# Analyse ----
#

# Diktionär an die tokenisierten Wörter anbinden
woerter_sentiment <- woerter %>% 
  left_join (sentiws_mean, by = "stem")


# Für jeden Text berechnen:
# - Anzahl der Token im Text
# - Anzahl der Token, für die ein Sentimentwert vorliegt
# - Anzahl der positiv bewerteten Token
# - Anzahl der negativ bewerteten Token
# - Anteil der positiv bewerteten Token
# - Anteil der negativ bewerteten Token
texte_sentiment <- woerter_sentiment %>% 
  group_by(doc_id) %>% 
  summarize(
    n_token = n(),
    n_sent = sum(!is.na(sentiment)),
    n_sent_pos = sum(sent_pos, na.rm=T),
    n_sent_neg = sum(sent_neg, na.rm=T),
    p_sent_pos = n_sent_pos / n_token,
    p_sent_neg = n_sent_neg / n_token
    ) %>% 
  ungroup()


# Plot der negativen und positiven Werte:
# Dokumente können ambivalent sein.
texte_sentiment %>% 
  ggplot(aes(x = p_sent_pos, y = p_sent_neg, size = n_sent)) +

  geom_hline(yintercept = mean(texte_sentiment$p_sent_neg), color = "#ba471a") +
  geom_vline(xintercept = mean(texte_sentiment$p_sent_pos), color = "#ba471a") +

  geom_point(color = "#0a6dba", alpha = 0.5) +
  scale_size_continuous(name = "Erkannte Wörter") +

  coord_fixed() +
  
  xlim(0, 0.25) +
  xlab("Anteil positiver Wörter") +
  
  ylim(0, 0.20) +
  ylab("Anteil negativer Wörter") +
  theme_bw(base_size = 8)

ggsave("sentimentanalyse.png", width = 11.5, height = 10, units = "cm")

# Mittelwerte
mean(texte_sentiment$p_sent_neg)
mean(texte_sentiment$p_sent_pos)

#
# Zurordnung der Inhalte zu den positiv bis negativ verorteten Texten ----
#

# Mit tf-idf die spezifischen Wörter eines Textes bestimmen
topwords <- woerter %>% 
  count(wort, doc_id) %>%
  bind_tf_idf(wort, doc_id,n) %>% 
  group_by(doc_id) %>% 
  slice_max(tf_idf, n = 3) %>% 
  summarize(topwoerter = paste0(wort, collapse = " ")) %>% 
  ungroup()

# ...und an den Sentimentdatensatz anhängen
texte_sentiment <- texte_sentiment %>% 
  left_join(topwords)
