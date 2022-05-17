# Umformen von Datensätzen zwischen dem Wide- und Long-Format

# Pakete laden
library(tidyverse)

# Datei einlesen
tweets <- read_csv2("example-tweets.csv")
print(tweets)

# Datensatz vom Wide- ins Long-Format umwandeln (=gather) 
tweets.long <- tweets %>% 
  gather(key="variable","value"="value",favorites,replies,retweets)

print(tweets.long)

# Datensatz vom Long- ins Wide-Format umwandeln (=spread) 
tweets.wide <- tweets.long %>% 
  spread(key="variable",value="value",sep="_")

print(tweets.wide)
