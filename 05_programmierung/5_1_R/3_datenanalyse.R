#
# Datenanalyse mit R
#


#
# Pakete laden ----
#
library(tidyverse)
library(skimr)

#
# Datensatz einlesen und aufbereiten ----
#

tweets <- read_csv2("example-tweets.csv")


# Beispiel: Auswahl von Zeilen durch filter() 
# und Spalten durch select()
auswahl <- filter(tweets, from =="unialdera")
auswahl <- select(auswahl, hashtags)

# Beispiel: Aneinanderkettung von Funktionen mit der Pipe %>%
# - filter: Zeilen auswählen
# - mutate: Spalten erstellen
# - select: Spalten auswählen
# - arrange: Sortieren nach einer ausgewählten Spalte
reactions <- tweets %>% 
  filter(media == "image") %>% 
  mutate(react = favorites + replies + retweets) %>%
  select(from, react) %>%
  arrange(-react)

# Beispiel: Datensätze mit fehlenden Werten aussortieren
tweets %>% 
  filter(!is.na(retweets))

# Beispiel: Fehlende Werte (NA) durch einen Wert (0) ersetzen
tweets %>% 
  mutate(retweets = replace_na(retweets, 0))

# Beispiel: In das Long-Format umwandeln
tweets_long <- tweets %>%  
  pivot_longer(
    cols = c(favorites, replies, retweets),
    names_to = "metric",
    values_to = "value"
  ) 


#
# Deskriptive Datenenanalyse: Auszählen von Kategorien ----
#


# Zählen der Zeilen eines Datensatzes
tweets %>%
  count()

# Zählen der Zeilen je Gruppe
# - die Gruppe wird als Parameter in der count()-Funktion angegeben
# - hier: wie viele Tweets gibt es je Verfasser:in?
tweets %>%  
  count(from)


# Zählen der Zeilen je Gruppe
# ...mit dem gleichen Ergebnis wie count(from)
tweets %>% 
  group_by(from) %>%  
  summarize(n = n()) %>% 
  ungroup()

# Zählen der Zeilen je Gruppe
# ...mit dem gleichen Ergebnis wie count(from)
# table() ist eine R-Basisfunktion
# und eine Alternative zu count()
table(tweets$from)

# Mehrere Gruppierungsvariablen
tweets %>% 
  count(from, media)

# Mit pivot_wider eine Kreuztabelle erstellen
tweets %>% 
  count(from, media) %>%
  
  pivot_wider(
    names_from = media,
    values_from = n
  )



#
# Deskriptive Datenenanalyse: Metrische Variablen ----
#


# Mittelwert
mean(tweets$favorites)

# Bei fehlenden Werten wird NA ausgegeben...
mean(tweets$retweets)

# ...wenn diese nicht mit dem Parameter na.rm=T ausgefiltert werden
mean(tweets$retweets, na.rm=T)


# Mittelwert je Gruppe
tweets %>% 
  group_by(from) %>%
  summarize(favs = mean(favorites)) %>% 
  ungroup()


# Mittelwert je Gruppe für mehrere Variablen, 
# sofern sie vorher ins Long-Format umgeformt wurden
tweets_long %>% 
  group_by(metric) %>% 
  summarize(m = mean(value, na.rm = T)) %>% 
  ungroup()

# Alle Variablen auf einmal zusammenfassen
skim(tweets)


# Mittelwerte und weitere Verteilungsparameter je Gruppe
tweets %>%
  group_by(media) %>%
  skim(favorites, replies, retweets) %>%
  ungroup() 

# Verteilung von Kennwerten
# summary() ist eine R-Basisfunktion
# und eine Alternative zu skim()
summary(tweets$replies)


#
# Zusammenhänge zwischen metrischen Variablen ----
#


# Korrelation
cor(tweets$favorites, tweets$replies)

# Korrelation mit Signifikanztest
cor.test(tweets$favorites, tweets$replies)


# Regression: lineares Modell mit lm().
#
# Der erste Parameter enthält eine Modellformel mit 
# der abhängige Variable vor und unabhängigen Variablen nach der Tilde.
# Im data-Parameter wird der Datensatz angegeben.
# 
# Wenn das Ergebnis in einem Objekt abgelegt wird (hier: fit),
# können die wichtigsten Kennwerte mit summary() ausgegeben werden
fit <- lm(favorites ~ retweets, data = tweets)
summary(fit)


