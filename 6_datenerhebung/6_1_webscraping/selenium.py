#
# 1. Programmbibliotheken laden
#

# Selenium zur Fernsteuerung des Browsers
from selenium import webdriver 
# Bibliothek für Reguläre Ausdrücke zum Verarbeiten von Zeichenketten laden
import re
# Pandas zum Abspeichern als CSV-Datei
import pandas as pd


#
# 2. Browser starten
#

browser = webdriver.Firefox(executable_path="geckodriver.exe")
browser.get("https://www.google.de/")


#
# 3. Google-Suche durchführen
#

# Beim Zugriff auf Elemente der Seite (find_element_by_name) 
# bis zu 10 Sekunden warten, so dass die Seite laden kann.
browser.implicitly_wait(10)

# Suchschlitz finden
suchschlitz = browser.find_element_by_name("q")
# In den Suchschlitz schreiben
suchschlitz.send_keys("Wie macht ein ")
# Abschicken
suchschlitz.submit()



#
# 4. Anzahl der Suchergebnisse extrahieren
#


# Anzahl der Ergebnisse auslesen
ergebnisse = browser.find_element_by_id('resultStats')
print(ergebnisse.text)

# Zahl mit regulärem Ausdruck extrahieren
anzahl = re.search('([0-9\.]+) Ergebnisse',↩ ergebnisse.text).group(1)
# Punkt aus Zeichenkette entfernen 
anzahl = anzahl.replace('.','')
# In eine Ganzzahl (int) umwandeln
anzahl = int(anzahl)
print(anzahl)


#
# 5. Mehrere Suchabfragen durchführen 
#


url = "https://www.google.de/"
keywords = ["Computational","Statistical","Interpretive"]

results = []

for keyword in keywords:
    print(keyword)    
    browser.get(url)
    
    suchschlitz = browser.find_element_by_name("q")
    suchschlitz.send_keys(keyword)
    suchschlitz.submit()    
    
    anzahl = browser.find_element_by_id('resultStats').text
    results.append({'keyword':keyword, 'count':anzahl })

results


# Liste mit Dictionaries in DataFrame umwandeln
results = pd.DataFrame(results)

# DataFrame als CSV-Datei abpseichern
results.to_csv('results.csv',sep=";",index=False)


# Variante 1: Kompletten Seitenquelltext auslesen
html = browser.page_source

# Variante 2: Quelltext von einem Element auslesen 
# (hier das body-Element)

body = browser.find_element_by_tag_name('body')
html= str(body.get_attribute('innerHTML' ))

# Text in Datei abspeichern
with open("meineseite.html","w",encoding="utf-8") as file:
    file.write(html))


# Screenshot speichern 
browser.save_screenshot('meineseite.png')

# Screenshot der gesamten Seite speichern (nur Firefox)
body_element = browser.find_element_by_tag_name('body')
body_png = body_element.screenshot_as_png

with open("meineseite.png", "wb") as file:
    file.write(body_png)
