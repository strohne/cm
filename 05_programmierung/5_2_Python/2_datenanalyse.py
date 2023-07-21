#
# Datenanalyse mit Pandas ----
#

# Pandas importieren
import pandas as pd

#
# Datensätze einlesen, erstellen und speichern ----
#

# Datensatz laden
df = pd.read_csv("example-tweets.csv", sep=';')

# In Jupyter Notebooks kann die Hilfe zu einzelnen Funktionen
# mit ? aufgerufen werden (entfernen Sie vorher die Raute):
# pd.read_csv?

# Datensatz anzeigen
display(df)


# Leeren Datensatz erstellen
df_small = pd.DataFrame()

# Liste mit Dictionaries definieren, 
# um sie dem Datensatz hinzuzufügen
data = [
    {'id': 1, 'name': 'rey'}, 
    {'id': 2, 'name': 'han'}
]

# Die Liste in einen DataFrame umwandeln
data = pd.DataFrame(data)

# Den neuen Datensatz anhängen
df_small = pd.concat([data, df_small], ignore_index=True, sort=False)

# Datensatz als CSV-Datei speichern
df_small.to_csv("example.csv", index=False)

# Datensatz als Excel-Datei speichern
df_small.to_excel("example.xlsx", index=False)

# Objekt löschen 
del df_small

#
# Funktionen zum Auswählen von Spalten ----
#

# Auswählen der Spalte "replies" aus "df"
df.loc[:, 'replies']

# Auswählen mehrerer Spalten (einer Liste von Spalten)
df.loc[:, ['replies', 'favorites']]

# Auswahl von Spalten nach Bereich
df.loc[:, 'favorites':'retweets']

# Überprüfen des Typs, der von loc zurückgegeben wird (Series oder DataFrame?)
x = df.loc[:, 'replies']
type(x)

x = df.loc[:, ['replies']]
type(x)

x = df['favorites']
type(x)

x = df[['favorites']]
type(x)

x = df.favorites
type(x)

#
# Funktionen zum Auswählen von Zeilen ----
#

# Zeilenindex setzen (statt Zeilennummern)
df = df.set_index(['from'])

# Auswählen aller Zeilen mit dem Wert "theeduni" aus der indexierten Spalte "from"
df.loc['theeduni']

# Einschränken des Datensatzes auf Zeilen und Spalten
df_subset = df.loc[['theeduni', 'unialdera'], ['favorites']]

# Zurücksetzen des Zeilenindex
df = df.reset_index()

# Zeilen und Spalten mittels Positionen auswählen
df.iloc[:5, 2:]

#
# Auswählen von Zeilen mit Bedingungen ----
#

# Filtern mit einer Bedingung
df[df.favorites > 10]

# Die folgende Anweisung würde den ursprünglichen df überschreiben
# df = df[df.favorites > 10]

# Kombinieren von Bedingungen beim Filtern von Werten 
df[(df.favorites > 10) & (df.retweets > 5)]

# Bedingung mithilfe eines regulären Ausdrucks 
# (=Formuliereung eines Suchmusters, das im entsprechenden Wert vorhanden sein muss).
df.hashtags.str.contains("tierwelt|sumpfschnecke|reptilien", case=False, regex=True, na=False)

# Teildatensatz mit der Filterbedingung auswählen
df[df.hashtags.str.contains("tierwelt|sumpfschnecke|reptilien", case=False, regex=True, na=False)] 

# Aneinanderketten von Funktionen 
df_subset = df[df.favorites > 10].loc[:,['replies','favorites']]

#
# Neue Spalten erzeugen ----
#

# Erstellen der neuen Spalte "reactions"
# durch Addieren der "retweets" und "replies"
df['reactions'] = df['retweets'] + df['replies']

# Ersetzen von fehlenden Werten (nan) durch Nullen
df['retweets'] = df['retweets'].fillna(0)
      
# Erstellen der neuen Spalte "tierwelt"
# Die Spalte enthält anschließend true- und false-Werte, je nachdem, 
# ob eines der im regulären Ausdruck definierten Hashtags auftritt.
df['tierwelt'] = df['hashtags'].str.contains("tierwelt|sumpfschnecke|reptilien", case = False, regex = True)

#
# Funktionen zum Aggregieren und Auszählen ----
#

# Auszählen, wie oft die Autor:innen in der Spalte 
# "from" vorkommen. 
df['from'].value_counts()   

# Erstellen einer Kreuztabelle
pd.crosstab(df['from'], df['tierwelt'])      

# Ermitteln von Mittelwerten von einer oder mehreren Spalten
df['favorites'].mean()
df[['retweets','replies']].mean()

# Ermitteln von Mittelwerten je Zeile 
df[['retweets','replies']].mean(axis=1)

# Übersicht über deskriptive Kennwerte der Spalten mit Zahlen
# (unter anderem Standardabweichung, Minimum, Maximum)
df.describe()

# Vergleiche von Gruppen
df.groupby('from').size()
df.groupby('from')[['retweets','replies']].mean() 
df.groupby('from')['favorites'].describe()

# Abspeichern von Auswertungen in einem neuen Datensatz
# Durch die Gruppierung entsteht ein Index.
# Der Index wird wieder zurückgesetzt, um die Werte der indizierten Variable
# in einer eigenen Spalte (statt als Zeilennamen) anzuzeigen
df_fav = df.groupby('from')['favorites'].mean()
df_fav = df_fav.reset_index()

df_fav.to_csv("favorites_mean.csv", index = False)
