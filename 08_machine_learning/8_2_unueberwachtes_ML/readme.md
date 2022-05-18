# Topic Modeling in R 
Welche Themen in einem Textkorpus vorkommen, lässt sich mithilfe von Topic Modeling bestimmen (Kapitel 8.2). Topic Modeling zählt dabei zu den unüberwachten maschinellen Lernverfahren. Das bedeutet, die Daten (Dokumente) liegen vorab ohne Label (Thema) vor. Stattdessen sucht der Lernalgorithmus selbst nach Strukturen in den Daten und gruppiert sie entsprechend. 

Mit den Dateien und Skripten im Repositorium können Sie ein LDA-Topic-Model in R trainieren, relevant ist vor allen das Skript 1_topicmodel_usenews.R.

## Übersicht über Skripte und Dateien: 
- **usenews.mediacloud.wm.2020.sample.rds**: Document-Feature-Matrix zum Ausprobieren von Topic Modeling. Datengrundlage ist der useNews-Datensatz (https://osf.io/uzca3/). Die Matrizen wurden bereinigt (relative pruning) und schließlich wurden daraus 5000 Dokumente deutschsprachiger Medien gezogen wurden.
- **0_prepare_usenews.R**: R-Skript, mit dem das Sample erstellt wurde
- **1_topicmodel_usenews.R**: Skript zur Durchführung von Topic Modeling
- **topics.Rproj**: Projektverzeichnis