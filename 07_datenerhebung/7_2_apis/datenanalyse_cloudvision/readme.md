# Google Cloud Vision API 
Über APIs können nicht nur Daten erhoben werden - auch Funktionen zur automatisierten Bilderkennung, Sentimentanalyse oder Geokodierung können über APIs aufgerufen werden. Eine kurze Einführung in die Arbeit mit der Google Cloud Vision API in R zur automatisierten Erkennung von Objekten in Bildern findet sich in Kapitel 7.2.6 im Lehrbuch. Ergänzende Beispieldateien und Skripte befinden sich in diesem Repositoriumsordner.

## Übersicht über Skripte und Dateien
- **cloudvision.Rproj**: Projektverzeichnis
- **cloudvision.R**: R-Skript zur Bilderkennung 
- **piano.jpg**: Beispielbild, Quelle: https://pixabay.com/de/photos/piano-klavier-musik-tasten-%C3%BCben-5353974/
- **schmetterling.jpg**: Beispielbild, Quelle: https://pixabay.com/de/photos/schmetterling-insekt-blatt-natur-4873368/

## Vorbereitung zur Nutzung der Google Cloud Vision API
Um die API nutzen zu können, müssen Sie sich zunächst registrieren:
1. In der Cloud Console registrieren: https://console.cloud.google.com/
2. Projekt erstellen: https://cloud.google.com/resource-manager/docs/creating-managing-projects
3. APIs und Dienste aktivieren ("Cloud Vision API"). Befassen Sie sich mit den Kosten: die ersten 1000 Abfragen sind aktuell (Anfang 2021) kostenlos.
4. Im API-Bereich Anmeldedaten für ein Dienstkonto erstellen. Erstellen Sie einen neuen Schlüssel und laden diesen als JSON-Datei auf Ihren Computer herunter. Den Schlüssel sollten Sie geheim halten, da er als Passwort fungiert. 

