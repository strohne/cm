#
# Dieses Skript beinhaltet einige grundlegende
# Funktionen für die Arbeit mit und Analyse von 
# Datensätzen
#

# Paket Tidyverse laden 
library(tidyverse)


#
# Daten einlesen und abspeichern ---- 
#

# CSV-Daten einlesen, mit read_csv2, 
# da Daten mit Semikolon getrennt sind.
tweets <- read_csv2("example-starwars.csv")

# Erstellen und Abspeichern eines neuen Datensatzes 
tweets.jeautor <- tweets %>% 
  count(from)

write_csv(tweets.jeautor, "tweets.jeautor.csv")


#
# Basifunktionen in R für Datenanalyse----
#

# Auszählen vo Häufigkeiten: 
# Wie oft wurden Tweets ge-retweetet?
table(tweets$retweets)

# Ausgeben von Grafiken: 
# Streudiagramm, in dem Favorites und Retweets abgetragen sind
plot(tweets$favorites,tweets$retweets)

# Ausgeben von Boxplots: 
# Verteilung der Retweets
boxplot(tweets$retweets)

# Ausgeben der Fünf-Punkte-Zusammenfassung :
# Verteilung der Favorites
summary(tweets$favorites)


#
# Funktionen aus dem Tidyverse für die Datenanalyse ----
#

# Auswahl durch Filter- und Select-Bedingung mit Pipe
# Filter= Auswählen von Zeilen
# Select= Auswählen von Spalten
auswahl <- tweets %>% 
  filter(from == "Universität von Exegol") %>% 
  select(hashtags)

# Auswahl durch Filter- und Select-Bedingung ohne Pipe
auswahl <- filter(tweets, from =="exogol")
auswahl <- select(auswahl, hashtags)

# Sortieren der Reihenfolge der Zeilen 
# mithilfe von arrange
# Über das "-" vor der Variable 
# kann absteigend sortiert werden
tweets %>% 
  arrange(-favorites)

# Erstellen und Überschreiben von Spalten mit mutate
# Zunächst: Überschreibend der Spalte retweets, indem 
# alle NAs mit 0en ersetzt werden 
# Anschließend: Erstellen der Spalte "reactions", 
# in der die Werte aus favorites, replies und retweets
# zusammengefasst werden.
tweets <- tweets %>%  
  mutate(retweets = replace_na(retweets, 0)) %>% 
  mutate(reactions = favorites + replies + retweets)

# Split-Apply-Combine:
# Je Autor:in die duchschnittliche Anzahl 
# der Favorites über alle Tweets hinweg bestimmen.
favorites <- tweets %>% 
  group_by(from) %>%  
  summarize(durchschnitt=mean(favorites)) %>% 
  ungroup()

# Zählen der Zeilen eines Datensatzes
tweets %>%
  count()

# Zählen der Zeilen, gruppiert nach den Werten in einer
# weiteren Spalte.
# Hier: wie viele Tweets ja ein:e Autor:in verfasst?
tweets %>%  
  count(from)

