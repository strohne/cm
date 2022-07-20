#
# Umformen von Datensätzen zwischen dem Wide- und Long-Format
#

#
# Pakete laden und Daten einlesen ----
#

library(tidyverse)

# Datei einlesen
tweets <- read_csv2("example-tweets.csv")
print(tweets)

#
# Daten umformen ----
#


# Datensatz mit pivot_longer vom Wide- in das Long-Format umwandeln 
tweets.long <- tweets %>% 
  pivot_longer(
    c(favorites,replies,retweets),
    names_to="variable", values_to="value"
  )


print(tweets.long)

# Datensatz mit pivot_wider zurück vom Long- in das Wide-Format umwandeln
tweets.wide <- tweets.long %>% 
  pivot_wider(
    names_from="variable",values_from ="value"
  )

print(tweets.wide)
