#
# Datensätze einlesen und abspeichern
#

#
# Pakete laden ----
#

library(tidyverse)
library(readxl)
library(writexl)


#
# Datensätze einlesen und abspeichern ----
#

# CSV-Datei einlesen. Die Funktion read_csv2()
# erwartet als Trennzeichen in der Datei das Semikolon
tweets <- read_csv2("example-tweets.csv")

# Der Funktion read_delim() kann das 
# Trennzeichen im delim-Parameter mitgegeben werden
tweets <- read_delim("example-tweets.csv", delim=";")


# Abspeichern eines Datensatzes
# Die Funktion write_csv verwendet ein Komma als Trennzeichen
write_csv(tweets, "tweets.csv")

# Auszählen der Datensätze. Das Ergebnis wird in einem neuen
# Objekt tweets_jeautor abgelegt
tweets_jeautor <- tweets %>%
  count(from)

# Abspeichern des neuen Datensatzes
write_csv(tweets_jeautor, "tweets_jeautor.csv")


#
# Datensätze mit Excel austauschen ----
#

# Die Funktion write_excel_csv2() hat günstige Voreinstellungen,
# wenn die CSV-Datei mit Excel geladen werden soll
write_excel_csv2(tweets_jeautor, "tweets_jeautor.csv")


# Mit write_xlsx() kann auch direkt eine Exceldatei erstellt werden...
write_xlsx(tweets_jeautor, "tweets_jeautor.xlsx")

# ...und mit read_xlsx() lassen sich Exceldateien einlesen
tweets_jeautor <- read_xlsx("tweets_jeautor.xlsx")

#
#  Einlesen und Abspeichern aus Unterverzeichnissen ----
#

# Der Dateipfad bezieht sich immer auf das aktuelle Arbeits- bzw. Projektverzeichnis.
# Wenn Sie ein Unterverzeichnis "daten" erstellen, können Sie Dateien
# anschließend darin abspeichern.
write_xlsx(tweets, "daten/example-tweets.xlsx")
tweets <- read_xlsx("daten/example-tweets.xlsx")

