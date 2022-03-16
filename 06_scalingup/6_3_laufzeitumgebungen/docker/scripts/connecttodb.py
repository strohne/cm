#
# Zugriff auf eine SQL-Datenbank mit Python
#

#
# Packages ----
#

from sqlalchemy import create_engine
import pymysql
import pandas as pd

#
# Daten abfragen ----
#

# Verbindung herstellen
# Der Verbindungsstring enthält
# - das Protokoll "mysql+pmysql"
# - den Nutzernamen "root" (vor dem Doppelpunkt)
# - das Passwort "root" (nach dem Doppelpunkt)
# - den Hostnamen "localhost"
# - den Datenbanknamen "devel"

db_connection_str = 'mysql+pymysql://root:root@localhost/devel'
db_connection = create_engine(db_connection_str)

# Tabelle abfragen
df = pd.read_sql('SELECT * FROM people', con=db_connection)
display(df)

#
# Auszählen ----
#

born_by_year = df.born.value_counts().sort_index()
born_by_year.plot(kind='bar')

#
# Alle Verbindungen schließen ----
#

db_connection.dispose()
