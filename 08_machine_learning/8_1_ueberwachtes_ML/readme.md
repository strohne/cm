# Überwachtes Machine Learning: Ein künstliches neuronales Netz trainieren
Überwachte Machine-Learning-Verfahren zeichnen sich dadurch aus,
dass man einen Datensatz X hat und für einen Teil des Datensatzes
die Kategorien y kennt, anhand derer man die Daten klassifizieren kann.
Auf diesen Daten wird ein Modell trainiert, mit dem anschließend auch neue Fälle kategorisiert werden können.
Ein Machine-Learning-Verfahren, das diese Aufgabe bewerkstelligen kann, ist das künstliche neuronale Netz.

Eine Einführung in überwachtes Maschinelles Lernen und wie man mit künstlichen neuronalen Netzen
Emotionen in Bildern erkennen kann, findet sich in Kapitel 8.1 im Lehrbuch.
In diesem Unterordner liegen die Dateien und Python-Skripte, um das Beispiel im Buch nachzuvollziehen.

## Übersicht über Dateien und Skripte
- **[1_multilayerperceptron.py](1_multilayerperceptron.py)**: Python-Skript zum Trainieren eines künstlichen neuronalen Netzes in Form des Multilayer Perceptron
- **[2_advanced_learningcurve.py](2_advanced_learningcurve.py)**: Ergänzendes Verfahren zur Evaluierung des Modells
- **[3_advanced_gridsearch.py](3_advanced_gridsearch.py)**: Ergänzendes Verfahren zum Finden der optimalen Modellparameter
- **[fer2013.zip](fer2013.zip)**: Beispieldatensatz mit Bildern aus dem FER-2013-Datensatz. 
   Der Datensatz ist über die Plattform Kaggle frei zum Download verfügbar: https://www.kaggle.com/msambare/fer2013.
   Für das Beispiel wurden aus den ursprünglichen sieben Emotionen die Kategorien "neutral" und "happy" ausgewählt.  
