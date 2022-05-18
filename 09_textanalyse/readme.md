# Textanalyse

Die automatisierte Textanalyse hilft dabei, Sprache formal zu analysieren. Dabei gibt es unterschiedliche Techniken:
- Wortfrequenzanalysen betrachten einzelne Wörter, deren Häufigkeiten, Kontexte und Kookkurrenzen (Kapitel 9.1), 
- Diktionärsbasierte Inhaltsanalysen ziehen Wörterbücher für die Analyse heran, um die Wörter um Bedeutungen (beispielsweise eine Bewertung, wie positiv oder negativ ein Wort ist) zu ergänzen (Kapitel 9.2),
- und wenn Texte geparsed werden, kann man deren Syntax und Semantik analysieren, etwa durch Part-Of-Speech-Tagging, Dependenzbäume oder Word-Embeddings (Kapitel 9.3). 
Eine Einführung in die verschiedenen Techniken der automatisierten Textanalyse bietet Kapitel 9 im Lehrbuch. Damit Sie die einzelnen Schriterte bessern nachvollziehen können, finden Sie entsprechende Skripte und Dateien in diesem Ordner. 

## Übersicht über Ordner, Skripte und Dateien
- **1_textanalyse.R**: R-Skript mit Befehlen zur Analyse von Korpora aus dem Package Tidyverse (Kapitel 9.1)
- **2_quanteda.R**: R-Skript mit Befehlen aus dem Package quanteda (Kapitel 9.1)
- **3_sentimentanalyse.R**: R-Skript mit Befehlen zur Sentimentanalyse mit SentiWS (Kapitel 9.2) 
- **4_spacy.R**: R-Skript mit Befehlen aus dem Package spacy (Kapitel 9.3)
- **textanalyse.Rproj**: Projektverzeichnis
- **beispielkorpus.zip**: Beispielkorpus, als Zip-Datei komprimiert. Damit die R-Skripte durchlaufen, entzippen Sie den Ordner mit dem Beispielkorpus in den Unterordner "korpus".
- **docs**: Unterordner mit den Dokumentationen dre POS-Tags
- **sentiws**: Unterordner mit SentiWS Diktionär


Das Beispielkorpus enthält 77 kurze Reflexionstexte von Studierenden im ersten Semester zu der Frage:
> Bei der Nutzung von Google, YouTube, WhatsApp oder anderen Internetdiensten fallen Daten an. Einige dieser Daten werden auch an Dritte weitergegeben. Was denken Sie, was mit Ihren Daten alles passiert? Wie würden Sie die Weitergabe von Daten bewerten? Was sollte aus Ihrer Sicht erlaubt sein und was nicht?
