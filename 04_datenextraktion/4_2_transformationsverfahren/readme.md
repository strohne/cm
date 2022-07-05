# Datentransformation 
Möchte man beispielsweise die Eigenschaften von einzelnen Objekten auszählen, macht es einen Unterschied, ob diese Eigenschaften in einer Tabelle untereinander (in einer Spalte) oder nebeneinander (in mehreren Spalten) stehen. Um die Daten in die für die Analyse gewünschte Form zu bringen, helfen Transformationsverfahren (Kapitel 4.2). Dabei können Datensätze beispielsweise vom Wide- ins Long-Format umgeschichtet oder einzelne Inhalte aus Tabellenzellen entschachtelt werden (Kapite 4.2.1). Oder ein Datensatz kann um Inhalte aus einem weiteren Datensatz ergänzt werden (Kapitel 4.2.2). Beispielskripte und -dateien für diese Transformationsverfahren finden Sie in diesem Unterordner. 

## Übersicht über Skripte und Dateien
- **4_2_transformationsverfahren.Rproj**: R-Projekt
- **wideandlong.R**: Beispielskript zum Umwandeln von Datensätzen zwischen dem Wide- und Long-Format
- **unnesting.R**: Beispielskript zum Entschachteln von Datensätzen
- **joins.R**: Beispielskript zum Zusammenführen von Datensätzen
- **example-tweets.csv**: Beispieldatensatz mit Twitter-Daten für die Skripte unnesting.R und wideandlong.R
- **example-urls.csv**: Beispieldatensatz mit URLs und ISSN-Nummern von Zeitschriften, für das Skript joins.R
- **example-zeitschriften.csv**: Beispieldatensatz mit Namen und ISSN-Nummern von Zeitschriften, für das Skript joins.R
