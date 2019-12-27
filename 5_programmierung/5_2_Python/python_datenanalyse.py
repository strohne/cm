#Datensatz laden
import pandas as pd
df = pd.read_csv("example-twitter.csv",sep=';')

# Datensatz anzeigen
display(df)

# Datensatz speichern
df.to_csv("example-twitter-neu.csv", index=False)

# Zeilenindex setzen (statt Zeilennummern)
df = df.set_index("from")

# Mittels Namen von Zeilen und Spalten auswählen
df.loc[['dagobah'], ['replies']]

# Mittels Positionen auswählen
df.iloc[:5,2:]