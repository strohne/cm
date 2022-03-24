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

# Datei öffnen und Html mit Beautifulsoup parsen
soup = BeautifulSoup(open(dateiname,encoding="utf-8"),'lxml')


# Alle Tabellen auslesen und die vierte Tabelle rausziehen 
tables = soup.select('table')
table_de = tables[3]

# Alle Zeilen in der Tabelle finden
# Die erste Zeile (mit den Spaltennamen) entfernen
table_rows = table_de.select('tr')
table_rows = table_rows[1:]
 
# Alle Zeilen abarbeiten, 
# die Ergebnisse in der results-Liste 
# ablegen 
results = []

for row in table_rows:
    
    # Alle Spalten innerhalb einer Zeile finden 
    cols = row.select('td')
    
    # Ein leeres dict anlegen, in dem die Werte 
    # gespeichert werden
    # Einzelne Spalten auslesen
    item = {}
    item['rang'] = cols[0].text.strip()
    item['titel'] = cols[1].text.strip()
    item['auflage'] = cols[2].text.strip()
    item['gruppe'] = cols[3].text.strip()
    
    # Zusätzlich den Link zur Wikipedia-Seite 
    # des Titels auslesen
    # in try-except kapseln, da nicht immer ein Link 
    # vorhanden ist 
    try: 
        link = cols[1].select_one('a').get('href')
        item['link'] = "www.wikipedia.org" + link
    except AttributeError:
        pass
    
    # Das dict zur Liste hinzufügen 
    results.append(item)
  
# Liste mit Dictionaries in Dataframe umwandeln
results = pd.DataFrame(results)

# Diese Liste im Notebook ausgeben 
# (erste und letzte Einträge)
pd.set_option('display.max_rows', 10)
display(results)

# DataFrame als CSV-Datei abpseichern
results.to_csv('results.csv',sep=";",index=False)
