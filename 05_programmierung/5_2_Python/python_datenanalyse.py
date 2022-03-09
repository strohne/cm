# Pandas importieren
import pandas as pd


# Datensatz laden
df = pd.read_csv("example-twitter.csv", sep=';')

# Würde der Datensatz als Excel-Datei vorliegen, 
# ließe er sich mit folgendem Befehl einlesen:
# df = pd.read_csv("example-twitter.xlsx")


# Datensatz anzeigen
display(df)


# Datensatz speichern als CSV-Datei
df.to_csv("example-twitter-small.csv", index=False)


# Leeren Datensatz erstellen und mit Werten füllen 
# hier: Liste aus Dictionaries, die in "data" abgelegt wird
df_small = pd.DataFrame()

data = [{'id':1,'name':'rey'}, {'id':2,'name':'han'}]

df_small = df_small.append(data, sort=False, ignore_index=True)


# Objekt löschen 
del df_small


# Funktionen zum Auswählen von Spalten

# Auswählen der Spalte "replies" aus "df"
df.loc[:,'replies']


# Auswählen mehrerer Spalten (einer Liste von Spalten)
df.loc[:,['replies','favorites']]


# Auswahl von Spalten nach Bereich
df.loc[:,'replies':'retweets']

# Überprüfen des Typs, der von loc zurückgegeben wird (Series oder DataFrame?)
x = df.loc[:,'replies']
type(x)

x = df.loc[:,['replies']]
type(x)

x = df['favorites']
type(x)

x = df[['favorites']]
type(x)

x = df.favorites
type(x)


# Funktionen zum Auswählen von Zeilen

# Zeilenindex setzen (statt Zeilennummern)
# Zurücksetzen von Zeilenindizes über df = df.reset_index() möglich.
df = df.set_index(['from'])


# Auswählen aller Zeilen mit dem Wert "dagobah" aus der indexierten Spalte "from"
df.loc['dagobah']


# Einschränken des Datensatzes auf Zeilen und Spalten
df_subset = df.loc[['dagobah','exogol'], ['favorites']]


# Zeilen und Spalten mittels Positionen auswählen
df.iloc[:5,2:]


# Filtern von Werten
df[df.favorites > 10]


# Kombinieren von Bedingungen beim Filtern von Werten 
df[(df.favorites > 10) & (df.retweets > 5)]


# Aneinanderketten von Funktionen 
df = df[df.favorites > 10].loc[:,['replies','favorites']]


# Filter der Spalte "hashtag" durch regulären Ausdruck 
# (=Formuliereung von Suchmustern, die in der entsprechenden Zeile 
# vorhanden sein müssen).
df['hashtags'].str.contains("natur|klima|umwelt", case=False, regex=True)


# Erstellen der neuen Spalte "natur"
# Die Spalte enthält true- und false-Werte, je nachdem, 
# ob der Hashtag "natur" in einer Zeile auftaucht oder nicht.
df['natur'] = df['hashtags'].str.contains("natur|klima|umwelt", case = False, regex = True)


# Erstellen der neuen Spalte "engagement"
# durch addieren der "retweets" und "replies"
df['engagement '] = df['retweets'] + df['replies']


# Ersetzen von fehlenden Werten (nan) mit Nullen
df['retweets'] = df['retweets'].fillna(0)
      

# Funktionen zum Aggregieren und Auszählen

# Auszählen, wie oft die Autor:innen in der Spalte 
# "from" vorkommen. 
# Achtung: Diese Spalte darf nicht indexiert sein. 
# Gegebenenfalls muss die Indexierung entfernt werden.
df['from'].value_counts()   


# Erstellen einer Kreuztabelle
pd.crosstab(df['from'],df['natur'])      


# Ermitteln von Mittelwerten von einer oder mehreren Spalten
df['favorites'].mean()
df[['retweets','replies']].mean()

# Ermitteln von Mittelwerten je Zeile 
df[['retweets','replies']].mean(axis=1)


# Übersicht über Werte (u.a. Standardabweichung, Minimum, Maximum)
#aller zahlenbasierter Spalten
df.describe()


# Vergleiche von Gruppen: 
# - Größe
# - Mittelwerte
# - allgemeine Übersicht 
df.groupby('from').size()
df.groupby('from')[['retweets','replies']].mean() 
df.groupby('from')['favorites'].describe()


# Abspeichern von Auswertungen in neuem 
# Datensatz; Überführen des Indexes in eine eigene Spalte 
df_fav = df.groupby('from')['favorites'].mean()
df_fav = df_fav.reset_index()
df_fav.to_csv("favorites_mean.csv", index = False)
