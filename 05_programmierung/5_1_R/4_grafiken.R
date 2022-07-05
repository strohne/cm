#
# Dieses Skript erzeugt Grafiken mit ggplot2
#

#
# Pakete laden  ----
#

library(tidyverse)
library(ggplot2)
theme_set(theme_bw())

#
# Daten einlesen und aufbereiten ----
#

# Daten einlesen
tweets <- read_csv2("example-tweets.csv")


# Aufbereiten der Daten: Leere Werte durch 0 ersetzen
tweets <- tweets %>%
  mutate(retweets = replace_na(retweets, 0))


#
# Grafiken erstellen ----
#

# Erstellen eines Streudiagramms (Punktewolke)
# (geeignet für zwei metrische Variablen)
ggplot(tweets, aes(x = retweets, y = favorites)) +
  geom_point()

ggsave("streudiagramm.png", dpi = 300, width = 3, height = 3)


# Erstellen eines einfachen Balkendiagramms
# (geeignet für den Gruppenvergleich von Anzahlen)
tweets %>%
  # Datensatz vorbereiten: Auszählen der häufigsten namen, durch:
  # - Häufigkeit auszählen (count)
  count(name) %>%
  # Erstellen des Balkendiagramms
  ggplot(aes(y = n, x = name)) +
  geom_col()


ggsave("saeulendiagramm.png", dpi = 300, width = 4, height = 4)


# Erstellen eines Boxplots
# (geeignet für den Gruppenvergleich eines metrischen Merkmals)
ggplot(tweets, aes(x = name, y = favorites)) +
  geom_boxplot()

ggsave("boxplot.png", dpi = 300, width = 3, height = 3)


# Mosaic-Plot
library(ggmosaic)
tweets %>%
  ggplot() +
  geom_mosaic(aes(product(media, name)))

ggsave("mosaicplot.png", dpi = 300, width = 4, height = 4)


#
# Erstellen eines Streudiagramms mit Farben und Legende ----
#

ggplot(tweets, aes(x = retweets + 1, y = favorites + 1, color = name)) +
  geom_point(position = "jitter") +

  # Logarithmieren
  scale_x_log10() +
  scale_y_log10() +

  # Beschriftungen hinzufügen
  labs(
    y = "Anzahl Favorites + 1",
    x = "Anzahl Retweets + 1"
  ) +
  ggtitle("Verhältnis von Favorites zu Retweets") +

  # Thema setzen, Legende formatieren
  theme_bw(base_size = 12)


ggsave("streudiagramm_farbig.png", dpi = 300, width = 5, height = 4)


#
# Erstellen eines gestapelten Säulendiagramms ----
#

tweets %>%
  
  # Datensatz vorbereiten:
  # - alle Reaktionen in einer Spalte ("type") zusammenziehen
  # - die Anzahl der Reaktionen ist anschließend in der Spalte "value" enthalten
  # - fehlende Werte durch "0" ersetzen
  
  pivot_longer(
    cols = c(favorites, replies, retweets),
    names_to = "type",
    values_to = "value"
  ) %>%
  
  mutate(value = replace_na(value, 0)) %>%
  
  # Grafik erstellen: Gestapeltes Balkendiagramm
  ggplot(aes(x = name, y = value, fill = type)) +
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

ggsave("saeulendiagramm_gestapelt.png", dpi = 300, width = 3.2, height = 4)

#
# Erstellen von facettierten Boxplots ----
#

tweets %>%
  # Datensatz vorbereiten
  # - Alle Reaktionen in einer Spalte ("type") zusammenziehen
  # - die Anzahl der Reaktionen ist anschließend in der Spalte "value" enthalten
  # - fehlende Werte durch "0" ersetzen
  pivot_longer(
    cols = c(favorites, replies, retweets), 
    names_to = "type",
    values_to = "value"
  ) %>%
  mutate(value = replace_na(value, 0)) %>%
  
  # Grafik erstellen: Boxplot
  ggplot(aes(x = type, y = value + 1, color = name)) +
  geom_boxplot() +

  # Skala logarithmieren (Vergleich wird sichtbarer)
  scale_y_log10() +
  facet_wrap(~name) +

  # Beschriftungen hinzufügen
  labs(y = "Anzahl + 1", x = "Reaktion") +
  ggtitle("Verteilung der Reaktionen") +

  # Theme setzen und Legende entfernen
  theme_bw() +
  theme(legend.position = "none")

ggsave("boxplot_facettiert.png", dpi = 300, width = 3.5, height = 3)
