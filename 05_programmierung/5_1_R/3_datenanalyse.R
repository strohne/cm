#
# Dieses Skript beinhaltet R-Basisfunktionen 
# und tidyverse-Funktionen für die Datenanalyse in R
#

# Pakete laden ----
library(tidyverse)
library(skimr)

# Datensatz einlesen ----
tweets<- read_csv2("example-tweets.csv")

??skim

# Basifunktionen zur Datenanalyse ----

# Auszählen von Häufigkeiten: 
# Wie viel hat wer getweetet?
table(tweets$name)

# Verteilung von Häufigkeiten:
summary(tweets$retweets)


# Ausgeben von Grafiken: 
# Streudiagramm, in dem Favorites und Retweets abgetragen sind
plot(tweets$favorites,tweets$retweets)

# Ausgeben von Boxplots: 
# Verteilung der Retweets
boxplot(tweets$retweets)

# Ausgeben der Fünf-Punkte-Zusammenfassung :
# Verteilung der Favorites
summary(tweets$favorites)

# Lineares Modell (Regression) mit lm(): 
# - erster Parameter: abhängige Variable, 
#   gefolgt von einer Tilde ~ und den unabhängigen Variablen 
# - data-Parameter nimmt den Datensatz entgegen 
# - Ergebnisse in Objekt abspeichern (hier: fit)
# - über summary(fit) die Kennwerte der Regressionsanalyse anzeigen 
fit <- lm(favorites ~ retweets, data=tweets)
summary(fit)

# Datenanalyse mit Tidyverse ----

# Auswahl durch Filter- und Select-Bedingung mit Pipe
# Filter= Auswählen von Zeilen
# Select= Auswählen von Spalten
auswahl <- tweets %>% 
  filter(name == "unialdera") %>% 
  select(hashtags)

# Auswahl durch Filter- und Select-Bedingung ohne Pipe
auswahl <- filter(tweets, name =="unialdera")
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
  summarize(favs=mean(favorites)) %>% 
  ungroup()

# Skim
skim(tweets, favorites)

# Zählen der Zeilen eines Datensatzes
tweets %>%
  count()

# Zählen der Zeilen nach Gruppen 
# - die Gruppe wird in der Funktion count angegeben
# - hier: wie viele Tweets gibt es je Verfasser:in?
tweets %>%  
  count(from)

# Alternative zu Count
tweets %>%
  group_by(from) %>%
  summarize(n=n()) %>%
  ungroup()

# Umwandeln vom Wide- ins Long-Format
# - Alle Reaktionen in eine Spalte "metric" zusammenziehen,
# - die Anzahl der Reaktionen ist in der neu erstellen Spalte "value" enthalten
tweets_long <- tweets %>%  
  pivot_longer(
    c(favorites, replies, retweets),
    names_to="metric",
    values_to="value"
    ) 
