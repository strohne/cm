#
# Zusammenführen von Datensätzen
#

# Pakete laden
library(tidyverse)

# Daten einlesen
zeitschriften <- read_csv2("example-zeitschriften.csv")
urls <- read_csv2("example-urls.csv")

# Inner join: Nur übereinstimmende Datensätze bleiben erhalten
inner_join(zeitschriften,urls,by="issn")

# Left und right join: Alle Zeilen links oder rechts werden ergänzt
left_join(zeitschriften,urls,by="issn")
right_join(zeitschriften,urls,by="issn")

# Full join: Auch nicht übereinstimmende Datensätze bleiben erhalten
full_join(zeitschriften,urls,by="issn")

# Semi und anti join: Es wird nur abgeglichen, aber es werden keine Spalten angehängt
semi_join(zeitschriften,urls,by="issn")
anti_join(zeitschriften,urls,by="issn")

