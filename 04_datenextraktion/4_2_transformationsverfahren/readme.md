# Datentransformation
Eine Tabelle kann unterschiedlich aufgebaut sein: Eigenschaften von Objekten können entweder in Spalten nebeneinander oder in Zeilen untereinander stehen. Außerdem können Datensätze ineinander verschachtelt sein, wenn eine Zelle nicht nur einen einzelnen Wert, sondern eine Liste mit Werten enthält. Mitunter sind Daten auch auf mehrere Tabellen aufgeteilt. Für Datenanalysen ist es häufig notwendig, die Daten mittels Transformationsverfahren in ihrer Form zu verändern (Kapitel 4.2). Dabei können Datensätze beispielsweise vom Wide- ins Long-Format umgeschichtet oder einzelne Inhalte aus Tabellenzellen entschachtelt werden (Kapitel 4.2.1) sowie aus verschiedenen Datensätzen zusammengeführt werden (Kapitel 4.2.2).

## Dateien in diesem Ordner
Um die Beispiele praktisch nachzuvollziehen, installieren Sie RStudio, öffnen Sie dann das R-Projekt und anschließend die einzelnen R-Skripte. Sie können in die R-Skripte aber auch ohne R-Studio eintauchen.

- **[transformation.Rproj](transformation.Rproj)**: Ein R-Projekt, um die Beispielskripte ausführen zu können
- **[1_wideandlong.R](transformation.Rproj)**: Beispielskript zum Umwandeln von Datensätzen zwischen dem Wide- und dem Long-Format
- **[2_unnesting.R](transformation.Rproj)**: Beispielskript zum Entschachteln von Datensätzen
- **[3_joins.R](transformation.Rproj)**: Beispielskript zum Zusammenführen von Datensätzen
- **[example-tweets.csv](example-tweets.csv)**: Beispieldatensatz mit Twitter-Daten für die Skripte unnesting.R und wideandlong.R
- **[example-urls.csv](example-tweets.csv)**: Beispieldatensatz mit URLs und ISSN-Nummern von Zeitschriften, für das Skript joins.R
- **[example-zeitschriften.csv](example-tweets.csv)**: Beispieldatensatz mit Namen und ISSN-Nummern von Zeitschriften, für das Skript joins.R
