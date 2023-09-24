# Ein Netzwerk ähnlicher Videos

*Hinweis:* der Endpunkt zur Abfrage ähnlicher Videos wurde von YouTube mittlerweile abgeschafft. Das Beispiel im Buch lässt sich anhand der Beispieldaten nachvollziehen. Alternativ findet sich im Repositorium ein Tutorial zur Erhebung und Aufbereitung von Zitationsnetzwerken mit Facepager und R.

## Dateien in diesem Ordner

- **[data/videos.export.csv](data/videos.export.csv)**: Die für das Beispiel verwendete, mit Facepager erstellte Datei (Kapitel 10.2).
- **[scripts/1_aufbereitung.R](scripts/1_aufbereitung.R)** Skript zur Aufbereitung der Facepager-Datei, um eine Knoten- und eine Kantenliste für die nächsten Analyseschritte zu erstellen.
- **[scripts/2_auswertung.R](scripts/2_auswertung.R)**: R-Skript mit Funktionen zur Analyse des Netzwerkes (Kapitel 10.3).
