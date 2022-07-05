# Zusammenführen von Datensätzen

# Pakete laden
library(tidyverse)

# Daten einlesen
zeitschriften <- read_csv2("example-zeitschriften.csv")
urls <- read_csv2("example-urls.csv")

# Inner join: nur übereinstimmende Datensätze bleiben erhalten
inner_join(zeitschriften,urls,by="issn")

# Left und right join: alle Zeilen link oder rechts werden ergänzt
left_join(zeitschriften,urls,by="issn")
right_join(zeitschriften,urls,by="issn")

# Full join: Auch nicht übereinstimmende Datensätze bleiben erhalten
full_join(zeitschriften,urls,by="issn")

# Semi und anti join: es werden keine Spalten angehängt
semi_join(zeitschriften,urls,by="issn")
anti_join(zeitschriften,urls,by="issn")

