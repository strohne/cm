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
           

# Erstellen eines einfachen Balkendiagramms
tweets %>% 
  
  # Datensatz vorbereiten: Auszählen der häufigsten namen, durch:
  # - Häufigkeit auszählen (count)
  count(name) %>%
  
  # Erstellen des Balkendiagramms
  ggplot(aes(x=n, y=name)) + 
  geom_col() 

ggsave("EinfachesBalkendiagramm.png", dpi=300, width = 3, height = 3)


# Erstellen eines Boxplots
ggplot(tweets, aes(x=name, y=favorites)) +
  geom_boxplot()

ggsave("EinfacherBoxplot.png", dpi=300, width = 3, height = 3)


# Erstellen einer gestalteten Punktewolke
ggplot(tweets, aes(x=favorites + 1, y=retweets + 1, color=name)) +
  geom_point(position="jitter") +
  
  # Logarithmieren 
  scale_x_log10() +
  scale_y_log10() +
  
  # Beschriftungen hinzufügen 
  labs(y="Anzahl Retweets + 1", 
       x="Anzahl Favorites + 1") + 
  ggtitle("Verhältnis von Favorites zu Retweets") + 
  
  # Thema setzen, Legende formatieren
  theme_bw(base_size=12) 


ggsave("GestaltetePunktewolke.png", dpi=300, width = 5, height=3)



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
  
  # Beschriftungen hinzufügen
  ggtitle("Reaktionen je Profil") + 
  labs(y="Anzahl der Reaktionen") + 
  
  # Beschriftung auf x-Achse hochkant drehen
  scale_x_discrete(guide=guide_axis(angle=90)) +
  
  # Thema setzen, Legendenposition verändern
  theme_bw(base_size=12) +
  theme(legend.position="bottom",
        axis.title.x=element_blank(),
        legend.title=element_blank()) 

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
  
  # Beschriftungen hinzufügen 
  labs(y="Anzahl", x="Reaktion") + 
  ggtitle("Verteilung der Reaktionen") +
  
  # Theme setzen und Legende entfernen
  theme_bw() +
  theme(legend.position="none")

ggsave("FacettierteBoxplots.png", dpi=300, width = 3.5, height = 3)







