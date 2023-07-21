#
# Grafiken erstellen mit R
#

#
# Pakete laden ----
#

library(tidyverse)
library(ggplot2)
library(ggmosaic)

# Setzt das Theme für die ggplot-Grafiken
theme_set(theme_bw())


#
# Daten einlesen und aufbereiten ----
#

tweets <- read_csv2("example-tweets.csv")

# Leere Werte durch 0 ersetzen
tweets <- tweets %>%
  mutate(retweets = replace_na(retweets, 0))

#
# Grafiken mit R-Basisfunktionen ----
# 


# Boxplot, um die Verteilung einer Variable zu visualisieren
boxplot(tweets$retweets)


# Streudiagramm (Punktewolke),
# um den Zusammenhang von zwei Variablen zu zeigen
plot(tweets$favorites, tweets$retweets)



#
# Grafiken erstellen mit ggplot ----
#


# Streudiagramms (Punktewolke), 
# um den Zusammenhang von zwei metrischen Variablen zu zeigen
ggplot(tweets, aes(x = retweets, y = favorites)) +
  geom_point()

# Letzte Grafik abspeichern
ggsave("streudiagramm.png", dpi = 300, width = 3, height = 3)


# Boxplot, 
# um ein metrisches Merkmal zwischen Gruppen zu vergleichen
ggplot(tweets, aes(x = from, y = favorites)) +
  geom_boxplot()

# Letzte Grafik abspeichern
ggsave("boxplot.png", dpi = 300, width = 3, height = 3)


# Säulendiagram,
# um Anzahlen zwischen mehreren Gruppen zu vergleichen
# -  mit count() wird die Anzahl der Fälle je Gruppe ausgezählt
# - mit geom_col() wird daraus ein Säulendiagramm erstellt
tweets %>%
  count(from) %>%

  ggplot(aes(x = from, y = n)) +
  geom_col()

ggsave("balkendiagramm.png", dpi = 300, width = 3, height = 3)



# Mosaikplot,
# um mehrere Kategorien miteinander zu vergleichen
tweets %>%
  ggplot() +
  geom_mosaic(aes(product(media, from)))

ggsave("mosaicplot.png", dpi = 300, width = 3.5, height = 3)



#
# Grafiken gestalten ----
#

# Streudiagramms mit Farben und Legende
ggplot(tweets, aes(x = retweets + 1, y = favorites + 1, color = from)) +
  geom_point(position = "jitter") +

  # Logarithmieren
  scale_x_log10() +
  scale_y_log10() +

  # Beschriftungen hinzufügen
  labs(
    x = "Anzahl Favorites + 1",
    y = "Anzahl Retweets + 1"
  ) +
  ggtitle("Verhältnis von Favorites zu Retweets") +

  # Thema setzen, Legende formatieren
  theme_bw(base_size = 12)

# Letzte Grafik abspeichern
ggsave("streudiagramm_farbig.png", dpi = 300, width = 5, height = 4)


# Gestapeltes Säulendiagramms
tweets %>%
  
  # Datensatz vorbereiten:
  # - alle Reaktionen in einer Spalte "metric" zusammenziehen
  # - die Anzahl der Reaktionen ist anschließend in der Spalte "value" enthalten
  # - fehlende Werte durch "0" ersetzen
  
  pivot_longer(
    cols = c(favorites, replies, retweets),
    names_to = "metric",
    values_to = "value"
  ) %>%
  
  mutate(value = replace_na(value, 0)) %>%
  
  # Grafik erstellen: Gestapeltes Balkendiagramm
  ggplot(aes(x = from, y = value, fill = metric)) +
  geom_col(position = "stack") +

  # Beschriftungen hinzufügen
  ggtitle("Reaktionen je Profil") +
  labs(y = "Anzahl der Reaktionen") +

  # Beschriftung auf x-Achse hochkant drehen
  scale_x_discrete(guide = guide_axis(angle = 90)) +

  # Thema setzen, Legendenposition verändern
  theme_bw(base_size = 12) +
  theme(
    legend.position = "bottom",
    axis.title.x = element_blank(),
    legend.title = element_blank()
  )

# Letzte Grafik abspeichern
ggsave("saeulendiagramm_gestapelt.png", dpi = 300, width = 3.2, height = 4)


# Facettierter Boxplot
tweets %>%
  
  # Datensatz vorbereiten
  # - Alle Reaktionen in einer Spalte "metric" zusammenziehen
  # - die Anzahl der Reaktionen ist anschließend in der Spalte "value" enthalten
  # - fehlende Werte durch "0" ersetzen
  pivot_longer(
    cols = c(favorites, replies, retweets), 
    names_to = "metric",
    values_to = "value"
  ) %>%
  mutate(value = replace_na(value, 0)) %>%
  
  # Grafik erstellen: Boxplot
  ggplot(aes(x = metric, y = value + 1, color = from)) +
  geom_boxplot() +

  # Skala logarithmieren (Vergleich wird sichtbarer)
  scale_y_log10() +
  facet_wrap(~from) +

  # Beschriftungen hinzufügen
  labs(y = "Anzahl + 1", x = "Reaktion") +
  ggtitle("Verteilung der Reaktionen") +

  # Theme setzen und Legende entfernen
  theme_bw() +
  theme(legend.position = "none")

# Letzte Grafik abspeichern
ggsave("boxplot_facettiert.png", dpi = 300, width = 3.5, height = 3)

