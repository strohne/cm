# Datentransformation 
Eine Tabelle mit Daten kann unterschiedlich aufgebaut sein: So können beispielsweise Eigenschaften von Objekten in Spalten nebeneinander oder in Zeilen untereinander stehen. Außerdem können Datensätze ineinander verschachtelt sein, wenn etwa eine Zelle in einer Tabelle nicht nur einen Wert sondern eine Liste mit Werten enthält. Je nachdem, was für eine Datenanalyse-Operation man durchführen will, sind andere Datenformate notwendig. Deshalb ist es häufig hilfreich, die Daten mittels Transformationsverfahren in ihrer From zu verändern (Kapitel 4.2). Dabei können Datensätze beispielsweise vom Wide- ins Long-Format umgeschichtet oder einzelne Inhalte aus Tabellenzellen entschachtelt werden (Kapitel 4.2.1). Oder ein Datensatz kann um Inhalte aus einem weiteren Datensatz ergänzt werden (Kapitel 4.2.2). 

## Dateien in diesem Ordner
Um die Beispiele praktisch nachzuvollziehen, installieren Sie RStudio, öffnen Sie dann das R-Projekt und anschließend die einzelnen R-Skripte. Sie können in die R-Skripte aber auch ohne R-Studio eintauchen.

- **transformation.Rproj**: Ein R-Projekt, um die Beispielskripte ausführen zu können
- **1_wideandlong.R**: Beispielskript zum Umwandeln von Datensätzen zwischen dem Wide- und dem Long-Format
- **2_unnesting.R**: Beispielskript zum Entschachteln von Datensätzen
- **3_joins.R**: Beispielskript zum Zusammenführen von Datensätzen
- **example-tweets.csv**: Beispieldatensatz mit Twitter-Daten für die Skripte unnesting.R und wideandlong.R
- **example-urls.csv**: Beispieldatensatz mit URLs und ISSN-Nummern von Zeitschriften, für das Skript joins.R
- **example-zeitschriften.csv**: Beispieldatensatz mit Namen und ISSN-Nummern von Zeitschriften, für das Skript joins.R
