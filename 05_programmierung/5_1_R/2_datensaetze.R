#
# Dieses Skript beinhaltet Funktionen zum Einlesen und Exportieren 
# von Datensätzen 
#

# Pakete laden ----
library(tidyverse)
library(readxl)
library(writexl)


# Datensätze einlesen  ---- 

# CSV-Daten einlesen, mit read_csv2, 
# - da Daten mit Semikolon getrennt sind
# - Funktion read_csv für Komma als Seperator 
tweets <- read_csv2("example-tweets.csv")

# CSV-Datei über read_delim einlesen
# - über "delim" kann der Seperator angegeben werden
tweets <- read_delim("example-tweets.csv", delim=";")


# Datensätze abspeichern ----

# Erstellen eines neuen Datensatzes 
tweets_jeautor <- tweets %>%
  count(from)

# Abspeichern des neuen Datensatzes
write_csv(tweets_jeautor, "tweets_jeautor.csv")


# Kopieren in Zwischenablagen ---- 

# Datensatz mit Tabulator getrennt kopieren
write_tsv(tweets_jeautor, "clipboard")

# Datensatz für Excel kopieren
write_excel_csv2(tweets_jeautor, "clipboard")


# Einlesen und Abspeichern für Excel ----

# Datensätze für Excel abspeichern und 
# aus Excel einlesen 
write_xlsx(tweets_jeautor, "tweets_jeautor.xlsx")
tweets_jeautor <- read_xlsx("tweets_jeautor.xlsx")


# Einlesen und Abspeichern aus Unterverzeichnissen ----

# Abspeichern in das Unterverzeichnis "daten" 
# - Unterverzeichnis muss zuvor erstellt sein 
# - der Pfad bezieht sich immer auf das aktuelle Arbeits- bzw. Projektverzeichnis
write_xlsx(tweets, "daten/example-tweets.xlsx")

# Einlesen aus Unterverzeichnis "daten"
tweets <- read_xlsx("daten/example-tweets.xlsx")


