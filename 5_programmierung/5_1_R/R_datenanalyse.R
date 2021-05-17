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
twitter <- read_csv2("example-twitter.csv")

# Erstellen und Abspeichern eines neuen Datensatzes 
tweets.jeautor <- twitter %>% 
  count(from)

write_csv(tweets.jeautor, "tweets.jeautor.csv")


#
# Basifunktionen in R für Datenanalyse----
#

# Auszählen vo Häufigkeiten: 
# Wie oft wurden Tweets ge-retweetet?
table(twitter$retweets)

# Ausgeben von Grafiken: 
# Anzahl der Favorites nach Tweet-ID
plot(twitter$favorites)

# Ausgeben von Boxplots: 
# Verteilung der Retweets
boxplot(twitter$retweets)

# Ausgeben der Fünf-Punkte-Zusammenfassung :
# Verteilung der Favorites
summary(twitter$favorites)


#
# Funktionen aus dem Tidyverse für Datenanalyse ----
#

# Auswahl durch Filter- und Select-Bedingung mit Pipe
# Filter= Auswählen von Zeilen
# Select= Auswählen von Spalten
auswahl <- twitter %>% 
  filter(from == "exogol") %>% 
  select(hashtags)

# Auswahl durch Filter- und Select-Bedingung ohne Pipe
auswahl <- filter(twitter, from =="exogol")
auswahl <- select(auswahl, hashtags)

# Sortieren der Reihenfolge der Zeilen 
# mithilfe von arrange
# Über das "-" vor der Variable 
# kann absteigend sortiert werden
twitter %>% 
  arrange(-favorites)

# Erstellen und Überschreiben von Spalten mit mutate
# Zunächst: Überschreibend der Spalte retweets, indem 
# alle NAs mit 0ern ersetzt werdeän 
# Anschließend: Erstellen der Spalte "engagement", 
# in der die Werte aus favorites, replies und retweets
# zusammengefasst werden.
twitter <- twitter %>%  
  mutate(retweets = replace_na(retweets, 0)) %>% 
  mutate(engagement = favorites + replies + retweets)

# Split-Apply-Combine:
# Je Autor:in die duchschnittliche Anzahl 
# der Favorites übre alle Tweets hinweg bestimmen.
favorites <- twitter %>% 
  group_by(from) %>%  
  summarize(durchschnitt=mean(favorites)) %>% 
  ungroup()

# Zusammenzählen von Werten eines Datensatzes
twitter %>%
  count()

# Zusammenzählen von Werten für Gruppen 
# durch Angabe einer Spalte
# hier: wie viele Tweets je Autor:in verfasst wurden
twitter %>%  
  count(from)
aes
