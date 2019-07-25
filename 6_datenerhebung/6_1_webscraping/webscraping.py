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
url = "http://www.fernsehserien.de/serien-a-z/n"
dateiname = directory+"/fernsehserien-g.html"    

# Herunterladen
response = requests.get(url)  
if response.status_code == 200:
    with open(dateiname, 'wb') as datei:
        datei.write(response.content)    

# Datei öffnen und Html mit Beautifulsoup parsen
soup = BeautifulSoup(open(dateiname,encoding="utf-8"),'lxml')

# Das ul-Element mit der ID a-z-liste finden,
# darin alle li-Elemente finden
soup_ul = soup.find('ul',{'id':'a-z-liste'})
soup_li = soup_ul.find_all('li')
 
# Alle li-Elemente abarbeiten,
# die Ergebnisse in der results-Liste
# ablegen
results = []

for li in soup_li:
    # Ein leeres dict anlegen, in dem die Werte 
    # gespeichert werden
    # Name der Serie aus span-Tag auslesen
    # Das dict zur Liste hinzufügen
    item = {}
    item ['name'] = li.find('span').text 
    results.append(item)
  

# Liste mit Dictionaries in DataFrame umwandeln
results = pd.DataFrame(results)
# Diese Liste im Notebook ausgeben 
# (erste und letzte Einträge)

pd.set_option('display.max_rows', 10)
display(results)

# DataFrame als CSV-Datei abpseichern
results.to_csv('results.csv',sep=";",index=False)
