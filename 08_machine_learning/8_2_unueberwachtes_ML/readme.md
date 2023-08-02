# Topic Modeling in R
Welche Themen in einem Textkorpus vorkommen, lässt sich mithilfe von Topic Modeling bestimmen (Kapitel 8.2). Topic Modeling zählt zu den unüberwachten maschinellen Lernverfahren. Das bedeutet, die Daten (Dokumente) liegen vorab ohne Label (Thema) vor. Stattdessen sucht der Lernalgorithmus selbst nach Strukturen in den Daten und gruppiert sie entsprechend.

Mit den Dateien und Skripten im Repositorium können Sie ein LDA-Topic-Model in R trainieren, relevant ist vor allen das Skript 1_topicmodel_usenews.R.

## Dateien in diesem Ordner:
- **[topics.Rproj](topics.Rproj)**: Das R-Projekt für das Beispiel
- **[0_prepare_usenews.R](0_prepare_usenews.R)**: R-Skript, mit dem das Sample aus dem Usenews-Datensatz erstellt wurde
- **[1_topicmodel_usenews.R](1_topicmodel_usenews.R)**: Skript zur Durchführung von Topic Modeling
- **[usenews.mediacloud.wm.2020.sample.rds](usenews.mediacloud.wm.2020.sample.rds)**: Document-Feature-Matrix zum Ausprobieren von Topic Modeling. Datengrundlage ist der useNews-Datensatz (https://osf.io/uzca3/). Die Matrizen wurden bereinigt (relative pruning) und schließlich wurden daraus 5000 Dokumente deutschsprachiger Medien gezogen wurden.
