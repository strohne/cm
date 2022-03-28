#
# 1. Programmbibliotheken laden
#

# Selenium zur Fernsteuerung des Browsers
from selenium.webdriver.firefox.service import Service
from webdriver_manager.firefox import GeckoDriverManager

driver = Service(GeckoDriverManager().install())

# By.Name und By.Id zum Extrahieren der Elemente
from selenium.webdriver.common.by import By


# Bibliothek für Reguläre Ausdrücke zum Verarbeiten von Zeichenketten laden
import re

# Pandas zum Abspeichern als CSV-Datei
import pandas as pd


#
# 2. Browser starten
#

browser = webdriver.Firefox(service=driver)
browser.get("https://www.google.de/")


#
# 3. Google-Suche durchführen
#

# Beim Zugriff auf Elemente der Seite (find_element) 
# bis zu 10 Sekunden warten, so dass die Seite laden kann.
browser.implicitly_wait(10)

# Suchschlitz finden
suchschlitz = browser.find_element(By.NAME,"q")

# In den Suchschlitz schreiben
suchschlitz.send_keys("Wie macht ein ")

# Abschicken
suchschlitz.submit()


#
# 4. Anzahl der Suchergebnisse extrahieren
#


# Anzahl der Ergebnisse auslesen
ergebnisse = browser.find_element(By.ID,'result-stats')
print(ergebnisse.text)

# Zahl mit regulärem Ausdruck extrahieren
anzahl = re.search('([0-9\.]+) Ergebnisse', ergebnisse.text).group(1)

# Punkt aus Zeichenkette entfernen 
anzahl = anzahl.replace('.','')

# In eine Ganzzahl (int) umwandeln
anzahl = int(anzahl)
print(anzahl)


#
# 5. Mehrere Suchabfragen durchführen 
#

# Neues Browser-Fenster öffnen
browser = webdriver.Firefox()
browser.implicitly_wait(10)

# URL und Liste von Suchbegriffen festlege
url = "https://www.google.de/"
keywords = ["Computational","Statistical","Interpretive"]

# Leere Liste für Suchergebnisse erstellen
results = []

# Für jedes Keyword die Google-Suche durchführen, 
# Anzahl der Ergebnisse auslesen und als Eintrag 
# in die results-Liste schreiben.
for keyword in keywords:
    print(keyword)    
    browser.get(url)
    
    suchschlitz = browser.find_element(By.NAME,"q")
    suchschlitz.send_keys(keyword)
    suchschlitz.submit()    
    
    anzahl = browser.find_element(By.ID, 'result-stats').text
    results.append({'keyword':keyword, 'count':anzahl })

results


#
# 6. Abspeichern der Ergebnisse als CSV-Datei
#

# Liste mit Dictionaries in DataFrame umwandeln
results = pd.DataFrame(results)

# DataFrame als CSV-Datei abpseichern
results.to_csv('results.csv',sep=";",index=False)


#
# 7. Crawlen und Abspeichern von Quelltext
#

# Variante 1: Kompletten Seitenquelltext auslesen
html = browser.page_source

# Variante 2: Quelltext von einem Element auslesen 
# (hier das body-Element)

body = browser.find_element(By.TAG_NAME, 'body')
html= str(body.get_attribute('innerHTML' ))

# Text in Datei abspeichern
with open("meineseite.html","w",encoding="utf-8") as file:
    file.write(html)
    
# Screenshot speichern 
browser.save_screenshot('meineseite.png')

# Screenshot der gesamten Seite speichern (nur Firefox)
body_element = browser.find_element(By.TAG_NAME, 'body')
body_png = body_element.screenshot_as_png

with open("meineseite.png", "wb") as file:
    file.write(body_png)
