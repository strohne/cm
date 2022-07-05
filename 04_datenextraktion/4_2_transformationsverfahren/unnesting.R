# Entschachteln von Datensätzen

# Pakete laden
library(tidyverse)

# Daten einlesen ----
tweets <- read_csv2("example-tweets.csv")
print(tweets)


# Daten aufbereiten ----
# Hashtags vertikal entschachteln (separate_rows)
hashtags_unnested <- tweets %>% 
  separate_rows(hashtags,sep=";")

print(hashtags_unnested)


# Hashtags vertikal verschachteln (summarize mit paste0)
hashtags_nested <- hashtags_unnested %>% 
  filter(!is.na(hashtags)) %>% 
  group_by(id) %>% 
  summarize(hashtags = paste0(hashtags,collapse=";")) %>% 
  ungroup()

print(hashtags_nested)


# Auszählen ----

#... mit summarize
hashtags_unnested %>% 
  group_by(hashtags) %>% 
  summarise(n = n()) %>% 
  ungroup()

#...count leistet das gleiche
hashtags_unnested %>% 
  count(hashtags, sort=T)

