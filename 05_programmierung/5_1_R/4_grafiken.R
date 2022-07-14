#
# Einführung in R
#

# - 7. Grafiken erstellen  [im Buch: Kapitel 5.1.5]
#       - Vorab: Pakete zur Erstellung von Grafiken laden und Datensatz einlesen und aufbereiten
#       - Streudiagramm
#       - Boxplot
#       - Balkendiagramm
# - 8. Grafiken gestalten [im Buch: Kapitel 5.1.5]
#       - Erstellen eines Streudiagramms mit Farben und Legende
#       - Erstellen eines gestapelten Säulendiagramms (Nicht Bestandteil des Manuskripts)
#       - Erstellen von facettierten Boxplots (Nicht Bestandteil des Manusskripts)
# - 9. Grafiken speichern [im Buch: Kapitel 5.1.5]
#       - Streudiagramm als Bilddatei speichern


#
# Pakete laden ----
#

library(tidyverse)
library(ggplot2)
library(ggmosaic)
theme_set(theme_bw())


#
# Daten einlesen und aufbereiten ----
#

tweets <- read_csv2("example-tweets.csv")

# Aufbereiten der Daten: Leere Werte durch 0 ersetzen
tweets <- tweets %>%
  mutate(retweets = replace_na(retweets, 0))

#
# 7. Grafiken erstellen [5.1.4] ---- 
#

# I. Erstellen eines Streudiagramms (Punktewolke)
# (geeignet für zwei metrische Variablen)
ggplot(tweets, aes(x=favorites, y=retweets)) +
  geom_point()

ggsave("streudiagramm.png", dpi = 300, width = 3, height = 3)


# II. Erstellen eines Boxplots
# (geeignet für den Gruppenvergleich eines metrischen Merkmals)
ggplot(tweets, aes(x = name, y = favorites)) +
  geom_boxplot()

ggsave("boxplot.png", dpi = 300, width = 3, height = 3)


# III. Erstellen eines einfachen Balkendiagramms
# (geeignet für den Gruppenvergleich von Anzahlen)
tweets %>%
  # Datensatz vorbereiten: Auszählen der häufigsten namen, durch:
  # - Häufigkeit auszählen (count)
  count(name) %>%
  # Erstellen des Balkendiagramms
  ggplot(aes(y = n, x = name)) +
  geom_col()


# IV. Mosaic-Plot
tweets %>%
  ggplot() +
  geom_mosaic(aes(product(media, name)))

ggsave("mosaicplot.png", dpi = 300, width = 4, height = 4)


#
# 8. Grafiken gestalten ----
#

#I. Erstellen eines Streudiagramms mit Farben und Legende
ggplot(tweets, aes(x = retweets + 1, y = favorites + 1, color = name)) +
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


ggsave("streudiagramm_farbig.png", dpi = 300, width = 5, height = 4)


# II. Erstellen eines gestapelten Säulendiagramms (Nicht Bestandteil des Manuskripts)

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


# III. Erstellen von facettierten Boxplots (Nicht Bestandteil des Manusskripts)

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

#
# 9. Grafiken speichern ----
#

# Streudiagramm als Bilddatei speichern
ggsave("streudiagram.png", dpi=300, 
       width = 5, height = 3)
