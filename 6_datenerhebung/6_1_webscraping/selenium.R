#
# Webscraping mit Selenium
#


# RSelenium installieren (einmalig)
#    siehe https://github.com/ropensci/RSelenium
#    Vorher RStudio neu starten. 
#    Es sollte eine 64bit Version von R installiert sein (Tools -> Global Options)
#    Bei Nachfragen alle packages aktualisieren und "from source" installieren
install.packages("devtools")
devtools::install_github("ropensci/RSelenium",INSTALL_opts=c("--no-multiarch"))


# Libraries laden
library(tidyverse)
library(RSelenium)


# startet einen Selenium-Server und einen verbundenen Fiefox-Browser
# Beim ersten Aufruf werden alle benötigten Komponenten installiert (Geduld!)
# Fall der Port belegt ist, einen anderen Port verwenden. 
# Der Port sollte am Ende mit server$stop() wieder freigegeben werden
selenium <- rsDriver(browser="firefox",port=4566L)
server <- selenium$server
browser <- selenium$client

# Seite aufrufen
# siehe die Hilfe zu remoteDriver-Class und webElement-class (im package RSelenium)

browser$navigate("http://www.google.com")

# Suchbegriff eingeben
suchschlitz <-  browser$findElement(using = 'name', 'q')
suchschlitz$sendKeysToElement(list("Wie macht ein "))
suchschlitz$sendKeysToElement(list(key='down_arrow'))
suchschlitz$submitElement()


# Anzahl der Suchergebnisse aus HTML-Element auslesen
ergebnisse <-  browser$findElement(using='id','resultStats')
ergebnisse <- ergebnisse$getElementText()

# Zahl mit regulären Ausdrücken extrahieren
ergebnisse <- str_extract(ergebnisse, "([^ ]+) Ergebnisse")
ergebnisse <- str_remove_all(ergebnisse, "[^0-9]")
ergebnisse


# Browser wieder schließen
browser$close()

# Kann wieder geöffnet werden mit:
# browser$open()


# Selenium server stoppen und Status ausgeben
server$stop()
server$process
