# Topic Modeling in R 

Welche Themen in einem Textkorpus vorkommen, lässt sich mithilfe von Topic Modeling bestimmen. Topic Modeling zählt 
dabei zu den unüberwachten maschinellen Lernverfahren. Das bedeutet, die Daten (Dokumente) liegen vorab ohne Label (Thema) vor. 
Stattdessen sucht der Lernalgorithmus selbst nach Strukturen in den Daten und gruppiert sie entsprechend. 

Mit den Dateien und Skripten im Repositorium können Sie ein LDA-Topic-Model in R trainieren. 

# Übersicht über Skripte und Dateien: 
- usenews.mediacloud.wm.2020.sample.rds enthält eine Document-Feature-Matrix zum Ausprobieren von Topic Modeling. Datengrundlage ist der useNews-Datensatz (https://osf.io/uzca3/). Die Matrizen wurden bereinigt (relative pruning) und schließlich wurden daraus 5000 Dokumente deutschsprachiger Medien gezogen wurden.

- topic_model.R: Skript zur Datenaufbereitung, Modellierung und Validierung des Topic Models (Kapitel 8.2.2)
- R.proj: Projektverzeichnis