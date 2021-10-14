#
# Klassisches Webscraping mit Rvest
#

# Pakete
library(tidyverse)
library(httr)
library(rvest)


# Seite herunterladen und parsen
url <- "http://www.fernsehserien.de/serien-a-z/n"
html <- read_html(url)
html


# Das geparste Dokument kann bei Bedarf abgespeichert werden
write_xml(html, file="serien_n.html")


# Alternative:
# - Webseite  mit GET-Funktion aus dem httr packager herunterladen
# - Inhalt in HTML-Datei abspeichern
# - Datei mit rvest einlesen
# response <- GET(url)
# cat(content(response, "text"), file="serien_n.html")
# html <- read_html("serien_n.html")


# Mithilfe von CSS das ul-Element 
# mit der ID "a-z-liste" und darin alle li-Elemente finden
html_nodes(html, "ul#a-z-liste li")


# Dieser Befehl kann alternativ mithilfe der Pipe geschrieben werden. 
# Über die Pipe können Befehle aneinandergehängt werden. 
# Als erster Parameter wird immer das Objekt aus der 
# Funktion vor der Pipe übergeben.
# Das Ergebnis wird im Objekt "lis" abgespeichert
lis <- html %>% 
  html_nodes("ul#a-z-liste li")

lis


# Auslesen der Seriennamen ---- 

# Über html_text() wird nur der Text, der von dem <li>-Tag
# eingerahmt ist, beibehalten.
serienname <- html %>% 
  html_nodes("ul#a-z-liste li") %>%   
  html_text()

serienname


#
# Auslesen von Seriennamen, Erscheinungsjahr und Link zur Webpage ---- 
#

# Leerer Vektor zum Sammeln der Daten anlegen
serien <- c()


# Alle li-Elemente abarbeiten
for (li in lis) {
  
  # - Daten aus dem li-Element auslesen
  
  li_name <- html_node(li,"div") %>% html_text()  
  li_name <- str_remove(li_name, "\\s+\\(.*") # Regulärer Ausdruck, um nur den Namen zu behalten.
  
  li_jahr <- html_attr(li,"data-jahr")
  
  li_link <- html_node(li,"a") %>% html_attr("href")
  li_link <- paste0("https://www.fernsehserien.de", li_link) #Hinzufügen der Domain vor den extrahierten Pfad. 
  
  li_html <- as.character(li)
  
  # - in einem neuen Tibble ablegen
  serie <- tibble('name'=li_name,
                  'jahr'=li_jahr,
                  'link'=li_link,
                  'html'=li_html)
  
  # - Tibble zum Vektor hinzufügen
  serien <-  c(serien,list(serie))
  
}


# Die Liste mit allen Tibbles zu einem 
# einzigen Tibble verbinden
serien <- bind_rows(serien)

# Ergebnis als Excel-Datei abspeichern
write_xlsx(serien,"serien_n.xlsx")
