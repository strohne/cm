#
# Webscraping mit Python 
#

# Bibliotheken einbinden
import os
import requests
import pandas as pd
from bs4 import BeautifulSoup

# Unterverzeichnis zum Herunterladen festlegen und
# anlegen, wenn es noch nicht existiert
directory = "html"
if not os.path.exists(directory):
    os.makedirs(directory)

# URL und Dateiname festlegen
url = "https://de.wikipedia.org/wiki/Liste_auflagenstärkster_Zeitschriften"
dateiname = directory + "/zeitschriften.html"  

# Herunterladen
response = requests.get(url)  
if response.status_code == 200:
    with open(dateiname, 'wb') as datei:
        datei.write(response.content)    

# Datei öffnen und HTML-Datei mit Beautifulsoup parsen
soup = BeautifulSoup(open(dateiname, encoding="utf-8"), 'lxml')

# Alle Tabellen auslesen und die vierte Tabelle rausziehen 
# (in Python beginnt die Zählung mit 0)
tables = soup.select('table')
table_de = tables[3]

# Alle Zeilen in der Tabelle finden
rows = table_de.select('tr')

# Die erste Zeile (mit den Spaltennamen) entfernen
rows = rows[1:]

# Die Ergebnisse werden in der results-Liste abgelegt
results = []

# Alle Zeilen abarbeiten
for row in rows:
    
    # Alle Spalten innerhalb einer Zeile finden 
    cols = row.select('td')
    
    # Ein leeres dict anlegen, in dem die Werte gespeichert werden
    item = {}
    
    # Einzelne Spalten auslesen
    item['rang'] = cols[0].text.strip()
    item['titel'] = cols[1].text.strip()
    item['auflage'] = cols[2].text.strip()
    item['gruppe'] = cols[3].text.strip()
        
    # Link auslesen
    link = cols[1].select_one('a')    
    if link:
        item['link'] = "www.wikipedia.org" + link.get('href')
    else:
        item['link'] = None
    
    # Das dict zur Liste hinzufügen
    results.append(item)
 
# Liste mit Dictionaries in Dataframe umwandeln
results = pd.DataFrame(results)

# Diese Liste im Notebook ausgeben (erste und letzte Einträge)
pd.set_option('display.max_rows', 10)
display(results)

# Diese Liste im Notebook ausgeben 
# (erste und letzte Einträge)
pd.set_option('display.max_rows', 10)
display(results)

# Dataframe als CSV-Datei abpseichern
results.to_csv('results.csv', sep=";", index=False)
