# Google Cloud Vision API

![piano](piano.jpg)

Über APIs können nicht nur Daten erhoben werden - auch Funktionen zur automatisierten Bilderkennung, Sentimentanalyse oder Geokodierung können über APIs aufgerufen werden. So kann man beispielsweise die Google Cloud Vision API nutzen, um automatisiert zu bestimmen, welche Objekte in dem angezeigten Bild abgelichtet sind. Eine kurze Einführung in die Arbeit mit der Google Cloud Vision API mit R findet sich in Kapitel 7.2.6 im Lehrbuch.

## Dateien in diesem Ordner
- **[cloudvision.Rproj](cloudvision.Rproj)**: Das R-Projekt für dieses Beispiel
- **[cloudvision.R](cloudvision.R)**: R-Skript zur Bilderkennung
- **[piano.jpg](piano.jpg)**: Beispielbild (Quelle: https://pixabay.com/de/photos/piano-klavier-musik-tasten-üben-5353974/)
- **[schmetterling.jpg](schmetterling.jpg)**: Beispielbild (Quelle: https://pixabay.com/de/photos/schmetterling-insekt-blatt-natur-4873368/)

## Vorbereitung zur Nutzung der Google Cloud Vision API
Um die API nutzen zu können, müssen Sie sich zunächst registrieren:
1. In der Cloud Console registrieren: https://console.cloud.google.com/
2. Projekt erstellen: https://cloud.google.com/resource-manager/docs/creating-managing-projects
3. APIs und Dienste aktivieren ("Cloud Vision API"). Befassen Sie sich mit den Kosten: die ersten 1000 Abfragen sind aktuell (Anfang 2021) kostenlos.
4. Im API-Bereich Anmeldedaten für ein Dienstkonto erstellen. Erstellen Sie einen neuen Schlüssel und laden Sie diesen als JSON-Datei auf Ihren Computer herunter. Den Schlüssel sollten Sie geheim halten, da er als Passwort fungiert.
