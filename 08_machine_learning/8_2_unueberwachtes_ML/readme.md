# Topic Modeling in R 

Welche Themen in einem Textkorpus vorkommen, lässt sich mithilfe von Topic Models bestimmen. Topic Modeling zählt 
dabei zu den unüberwachten maschinellen Lernverfahren. Das bedeutet, die Daten (Dokumente) haben vorab kein Label (Thema), das sie zugewiesen bekommen. 
Stattdessen sucht der Lernalgorithmus selbst nach Strukturen in den Daten und gruppiert sie entsprechend. 

Mit den Dateien und Skripten im Repositorium können Sie ein LDA-Topic-Model in R trainieren. Detaillierte Hintergrundinformationen und 
weiterführende Konzepte können Sie im Kapitel 8.2 im Lehrbuch nachlesen. Eine Einführung in R finden Sie in Kapitel 5.1. 

# Übersicht über Skripte und Dateien: 
- korpus: Unterordner mit der Datei "artikel.csv". Die Datei beinhaltete Nachrichtenartikel, die als Datengrundlage zum Trainieren des Topic Models verwendet werden. (Quelle: Alle Artikel, die am 13.09.2021 auf der vollständigen Artikelliste von Wikinews im Portal "Politik" gelistet waren: https://de.wikinews.org/wiki/Portal:Politik/Vollst%C3%A4ndige_Artikelliste)
- topic_model.R: Skript zur Datenaufbereitung, Modellierung und Validierung des Topic Models (Kapitel 8.2.2)
- R.proj: Projektverzeichnis