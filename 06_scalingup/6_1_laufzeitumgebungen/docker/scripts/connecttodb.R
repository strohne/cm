#
# Verbindung zu einer SQL-Datenbank herstellen
#


#
# Packages ----
#


library(tidyverse)
library(RMySQL)
library(dbplyr)


#
# Daten abfragen ----
#

# Verbindung zur Datenbank herstellen
con <- dbConnect(
  RMySQL::MySQL(),
  host =     "localhost",
  port=      3306,
  username= "root",
  password= "root",
  dbname=   "devel"
)


# Tabelle auswählen
people <- tbl(con,"people")

# Alle Datensätze holen
people <- collect(people)

# Zeitleiste visualisieren
people %>% 
  count(born) %>% 
  ggplot(aes(x=born,y=n)) +
  geom_col()


# Verbindung wieder trennen
dbDisconnect(con)
