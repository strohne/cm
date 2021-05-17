#
# Erzeugen von Grafiken mit ggplot 
#

# Pakete laden 
library(tidyverse)
library(ggplot2)

# Daten einlesen 
twitter <- read_csv2("example-twitter.csv")

# Erstellen einer einfachen Grafik 
ggplot(twitter, aes(x=favorites, y=retweets)) + 
  geom_point()
