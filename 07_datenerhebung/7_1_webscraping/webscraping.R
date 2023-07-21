#
# Klassisches Webscraping mit Rvest
#

# Pakete
library(tidyverse)
library(writexl)
library(rvest)

# Seite herunterladen und parsen
url <- "https://de.wikipedia.org/wiki/Liste_auflagenstärkster_Zeitschriften"
html <- read_html(url)
html


# Das geparste Dokument kann bei Bedarf mit der Bibliothek
# xml2 abgespeichert werden
#library(xml2)
#write_xml(html, file="zeitschriften.html")


# Alternative:
# - Webseite  mit GET-Funktion aus dem httr packager herunterladen
# - Inhalt in HTML-Datei abspeichern
# - Datei mit rvest einlesen
# library(httr)
# response <- GET(url)
# cat(content(response, "text"), file="zeitschriften.html")
# html <- read_html("zeitschriften.html")


# Mithilfe der Funktion html_nodes() alle table-Elemente finden
el_tables <- html_nodes(html, "table")

# Alternative Schreibweise in der tidyverse-Logik
el_tables <- html %>% 
  html_nodes("table")

# Auf das vierte Element in der Liste zugreifen
el_table <- el_tables[4]

# Einzelne Zeilen bekommen 
el_rows <- el_table %>% 
  html_nodes("tr") 

#
# Auslesen der Tabelleninhalte ---- 
#

# Leeres Tibble zum Sammeln der Ergebnisse
results <- tibble()

# Alle Zeilen abarbeiten
for (el_row in el_rows) {
  
  # Alle Spalten innerhalb einer Zeile finden
  el_cols <- el_row %>%
    html_nodes("td")
  
  # Text aus der zweiten Spalte auslesen
  titel = el_cols[2] %>%
    html_text()
  
  # URL aus dem Attribut 'href' auslesen
  link = el_cols[2] %>% 
    html_nodes("a") %>% 
    html_attr('href')
  
  # zusätzlich noch "www.wikipedia.org" ergänzen, um 
  # Link zu vervollständigen
  link = paste0("www.wikipedia.org", link)
  
  # In einem neuen Tibble ablegen...
  magazine <- tibble(
    'titel' = titel,
    'link' = link
  )
  
  # ... und zu den Ergebnissen hinzufügen
  results <-  bind_rows(results, magazine)
  
}


# Ergebnis als Excel-Datei abspeichern
write_xlsx(results, "zeitschriften.xlsx")
