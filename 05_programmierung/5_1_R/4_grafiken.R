#
# Dieses Skript erzeugt Grafiken mit ggplot2
#

# Pakete laden 
library(tidyverse)
library(ggplot2)


#
# Daten Einlesen und Aufbereiten ---- 
#

# Daten einlesen 
tweets <- read_csv2("example-tweets.csv")

# Aufbereiten der Daten: Leere Werte durch 0er ersetzen 
tweets <- tweets %>% 
  mutate(retweets = replace_na(retweets, 0))


#
# Grafiken erstellen ---- 
#

# Erstellen einer einfachen Punktewolke
ggplot(tweets, aes(x=favorites, y=retweets)) +
  geom_point()

ggsave("EinfachePunktewolke.png", dpi=300, width = 3, height = 3)
           

# Erstellen einer gestalteten Punktewolke
ggplot(tweets, aes(x=favorites, y=retweets, color=name)) +
  geom_point(position="jitter") +
  
  # Thema setzen
  theme_bw(base_size=12) + 
  
  # Beschriftungen hinzufügen 
  labs(y="Anzahl Retweets", x="Anzahl Favorites") + 
  ggtitle("Verhältnis von Favorites zu Retweets") 

ggsave("GestaltetePunktewolke.png", dpi=300, width = 5, height = 3)


# Erstellen eines Balkendiagramms zu den häufigsten Hashtags

tweets %>% 
  
  # Datensatz vorbereiten: Auszählen der häufigsten namen, durch:
  # - Häufigkeit auszählen (count)
  # nach Häufigkeit sortieren (arrange)
  count(name) %>%
  arrange(-n) %>% 

  # Erstellen der Grafik
  ggplot(aes(x=n, y=name)) + 
  geom_col(fill="white", color="black") +
  
  # Thema setzen
  theme_bw(base_size=12) + 
  
  # Beschriftungen hinzufügen, Legende entfernen
  labs(y="Hashtags", x="Anzahl") + 
  ggtitle("Häufigste Hashtags") +
  theme(legend.position="none")

ggsave("Balkendiagramm.png", dpi=300, width = 3, height = 3)


# Erstellen eines Boxplots

tweets %>% 
  
  # Datensatz vorbereiten: Alle Reaktionen in eine Spalte ("type") zusammenziehen,
  # die Anzahl der Reaktionen ist in der Spalte "value",
  # fehlende Werte durch "0" ersetzen
  pivot_longer(cols=c(favorites, replies, retweets), names_to="type") %>% 
  mutate(value = replace_na(value, 0)) %>% 
  
  # Grafik erstellen: Boxplot
  ggplot(aes(x=type, y=value)) +
  geom_boxplot() +
  
  # Skala logarithmieren (aufgrund unterschiedlicher Wertebereiche) 
  scale_y_log10() +
  
  # Theme setzen 
  theme_bw(base_size=12) +
  
  # Beschriftungen hinzufügen 
  labs(y="Anzahl", x="Reaktion") + 
  ggtitle("Verteilung der Reaktionen")
  
ggsave("Boxplot.png", dpi=300, width = 3, height = 3)


# Erstellen eines gestapelten Balkendiagramms mit Reaktionen 

tweets %>%
  
  # Datensatz vorbereiten: Alle Reaktionen in einer Spalte ("type") zusammenziehen
  # die Anzahl der Reaktionen ist in der Spalte "value"
  # fehlende Werte durch "0" ersetzen
  pivot_longer(cols=c(favorites, replies, retweets), names_to="type") %>% 
  mutate(value = replace_na(value, 0)) %>% 
  
  # Grafik erstellen: Gestapeltes Balkendiagramm
  ggplot(aes(x=name, y=value, fill=type)) +
  geom_col(position="stack") +
  
  # Thema setzen
  theme_bw(base_size=12) +
  
  # Beschriftungen hinzufügen und formattieren
  labs(y="Anzahl der Reaktionen") + 
  ggtitle("Reaktionen je Profil") + 
  theme(legend.position="bottom",
        axis.title.x=element_blank(),
        legend.title=element_blank()) +
  scale_x_discrete(guide=guide_axis(angle=90))

ggsave("GestapeltesBalkendiagramm.png", dpi=300, width = 3.2, height = 4)


# Erstellen von facettierten Boxplots

tweets %>% 
  
  # Datensatz vorbereiten: Alle Reaktionen in einer Spalte ("type") zusammenziehen
  # die Anzahl der Reaktionen ist in der Spalte "value"
  # fehlende Werte durch "0" ersetzen
  pivot_longer(cols=c(favorites, replies, retweets), names_to="type") %>% 
  mutate(value = replace_na(value, 0)) %>% 
  
  # Grafik erstellen: Boxplot
  ggplot(aes(x=type, y=value, color=name)) +
  geom_boxplot() +
  
  # Skala logarithmieren (Vergleich wird sichtbarer) 
  scale_y_log10() +
  
  facet_wrap( ~name) +
  
  # Theme setzen 
  theme_bw() +
  
  # Beschriftungen hinzufügen 
  labs(y="Anzahl", x="Reaktion") + 
  ggtitle("Verteilung der Reaktionen") +
  theme(legend.position="none")

ggsave("FacettierteBoxplots.png", dpi=300, width = 3.5, height = 3)







