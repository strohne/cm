# Pandas importieren
import pandas as pd

#
# Datensätze einlesen, erstellen und speichern ----
#

# Datensatz laden
df = pd.read_csv("example-tweets.csv", sep=';')

# Die Hilfe aufrufen
pd.read_csv?

# Datensatz anzeigen
display(df)


# Leeren Datensatz erstellen und mit Werten füllen 
# hier: Liste aus Dictionaries, die in "data" abgelegt wird
df_small = pd.DataFrame()

data = [{'id':1,'name':'rey'}, {'id':2,'name':'han'}]

df_small = df_small.append(data, sort=False, ignore_index=True)

# Datensatz speichern als CSV-Datei
df_small.to_csv("example.csv", index=False)

# Datensatz speichern als Excel-Datei
df_small.to_excel("example.xlsx", index=False)


# Objekt löschen 
del df_small

#
# Funktionen zum Auswählen von Spalten ----
#

# Auswählen der Spalte "replies" aus "df"
df.loc[:,'replies']

# Auswählen mehrerer Spalten (einer Liste von Spalten)
df.loc[:,['replies','favorites']]

# Auswahl von Spalten nach Bereich
df.loc[:,'favorites':'retweets']

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

#
# Funktionen zum Auswählen von Zeilen ----
#

# Zeilenindex setzen (statt Zeilennummern)
df = df.set_index(['name'])

# Auswählen aller Zeilen mit dem Wert "dagobah" aus der indexierten Spalte "from"
df.loc['theeduni']

# Einschränken des Datensatzes auf Zeilen und Spalten
df_subset = df.loc[['theeduni','unialdera'], ['favorites']]

# Zurücksetzen von Zeilenindizes
df = df.reset_index()

# Zeilen und Spalten mittels Positionen auswählen
df.iloc[:5,2:]

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
# (=Formuliereung von Suchmustern, die in der entsprechenden Zeile vorhanden sein müssen).
df.hashtags.str.contains("tierwelt|sumpfschnecke|reptilien", case=False, regex=True, na=False)

# Teildatensatz mit der Filterbedingung auswählen
df[df.hashtags.str.contains("tierwelt|sumpfschnecke|reptilien", case=False, regex=True, na=False)] 

# Aneinanderketten von Funktionen 
df_subset = df[df.favorites > 10].loc[:,['replies','favorites']]

#
# Neue Spalten erzeugen ----
#

# Erstellen der neuen Spalte "reactions"
# durch addieren der "retweets" und "replies"
df['reactions'] = df['retweets'] + df['replies']

# Ersetzen von fehlenden Werten (nan) mit Nullen
df['retweets'] = df['retweets'].fillna(0)
      
# Erstellen der neuen Spalte "natur"
# Die Spalte enthält true- und false-Werte, je nachdem, 
# ob der Hashtag "natur" in einer Zeile auftaucht oder nicht.
df['natur'] = df['hashtags'].str.contains("tierwelt|sumpfschnecke|reptilien", case = False, regex = True)

#
# Funktionen zum Aggregieren und Auszählen ----
#

# Auszählen, wie oft die Autor:innen in der Spalte 
# "from" vorkommen. 
df['from'].value_counts()   

# Erstellen einer Kreuztabelle
pd.crosstab(df['from'],df['natur'])      

# Ermitteln von Mittelwerten von einer oder mehreren Spalten
df['favorites'].mean()
df[['retweets','replies']].mean()

# Ermitteln von Mittelwerten je Zeile 
df[['retweets','replies']].mean(axis=1)

# Übersicht über deksriptive Kennwerte
# (u.a. Standardabweichung, Minimum, Maximum)
# von allen zahlenbasierten Spalten
df.describe()

# Vergleiche von Gruppen: 
# - Größe
# - Mittelwerte
# - Deskriptive Kennwerte
df.groupby('from').size()
df.groupby('from')[['retweets','replies']].mean() 
df.groupby('from')['favorites'].describe()

# Abspeichern von Auswertungen in neuem 
# Datensatz; Überführen des Indexes in eine eigene Spalte 
df_fav = df.groupby('from')['favorites'].mean()
df_fav = df_fav.reset_index()
df_fav.to_csv("favorites_mean.csv", index = False)
