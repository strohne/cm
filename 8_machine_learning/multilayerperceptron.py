#%%

import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import random

from PIL import Image

from sklearn.neural_network import MLPClassifier
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.model_selection import train_test_split, learning_curve

#%%

# Funktion, um Bilder einzulesen und
# die Pixel als Liste auszulesen
def load_images(folder):
    images = []
    for filename in os.listdir(folder):

        img = Image.open(os.path.join(folder,filename))
        img = list(img.getdata())
        images.append(img)

    return images


# Funktion zur Visualisierung der Vorhersagen
# - Zufällig Bilder auswählen (nach Anzahl der Reihen und Spalten)
# - Pixelliste in Array umformen und Array anzeigen: some_image
# - Label anzeigen: some_label
def visualize_pred(X, y, cols=3, rows=3):
    selected = random.sample(range(len(X)), cols * rows)

    plt.figure(figsize=(10,10))

    for i, num in enumerate(selected):
        some_pixels = X[num]
        some_image = some_pixels.reshape(48,48)

        some_label = y[num]

        plt.subplot(cols, rows ,i+1)
        plt.xticks([])
        plt.yticks([])
        plt.grid(False)

        plt.imshow(some_image, cmap="gray")
        plt.xlabel(some_label)

    plt.show()


#%%  Bilder X und Label y einlesen
# - In folders die Unterordner angeben, in denen die Bilder liegen
# - Durch for-Schleife nacheinander Bilder einlesen
# - Konvertieren der Bilder in Numpy-Arrays

X = []
y = []

workingdir = os.getcwd()
folders = ['happy', 'neutral']


for folder in folders:
    images = load_images(workingdir+'/fer2013/train/'+folder+'/')

    X.extend(images)
    y.extend([folder] * len(images))

# In Arrays umwandeln
X = np.asarray(X)
y = np.asarray(y)

#%% Trainings- und Validierungssets
# - test_size legt den Anteil der Validierungsdaten fest
# - stratify, um Verteilung der Kategorien beizubehalten

X_train, X_val, y_train, y_val = train_test_split(X ,y, test_size=0.2, stratify=y)


#%% Modell trainieren
# - Parameter im MLPClassifier() festlegen
# - Trainieren des Modells durch fit()

mlp = MLPClassifier(
    hidden_layer_sizes = (1000, 100),
    max_iter= 1000,
    batch_size=200,
    n_iter_no_change=10,
    verbose=True,
    random_state= 180
)

mlp.fit(X_train, y_train)


#%% Loss curve auf allen Daten: y=Loss, x=Epoch. Sollte gegen 0 gehen.
# - Grafik erstellen durch plot()
# - Achsenbeschriftung hinzufügen durch .xlavel sowie .ylabel

plt.plot(mlp.loss_curve_)
plt.xlabel("epoch")
plt.ylabel("loss")
plt.show()

#%% Validierung des trainierten Modells
# - Vorhersagen von Labels durch predict()
# - visualize_pred() am Anfang vom Skript definiert, gibt Bilder und vorhergesagte Label zurück
# - Confusion Matrix berechnen durch confusion_matrix()
# - Werte wie Recall oder F1 durch classification_report() ausgeben

# y vorhersagen
y_pred = mlp.predict(X_train)

# Vorhersage visualisieren
visualize_pred(X_train, y_pred)

# Print confusion matrix
conf = confusion_matrix(y_train,y_pred)
print(pd.DataFrame(conf))

# Precision, recall und F1-Wert
report = classification_report(y_train,y_pred)
print(report)

#%% Validierung des Modells nach abgeschlossenem Training
# - siehe vorherigen Codeblock: X_train durch X_val ausgetauscht
# um zu sehen, ob das Modell auch für neue Daten geeignet ist

# y vorhersagen
y_pred = mlp.predict(X_val)

# Vorhersage visualisieren
visualize_pred(X_val, y_pred)

# Print confusion matrix
conf = confusion_matrix(y_val,y_pred)
print(pd.DataFrame(conf))

# Precision, recall und F1-Wert
report = classification_report(y_val,y_pred)
print(report)


#%% Lernkurven visualisieren
# - Werte für Lernkurve durch learning_curve() berechnen
# - cv = 5 bedeutet, 5-fache-Kreuzvalidierung
# - scoring gibt das Maß an, das geplottet wrden soll. Hier: Loss = Fehlerterm
# andere mögliche scoring-Maße, siehe: https://scikit-learn.org/stable/modules/model_evaluation.html

# Scores für Lernkurven berechnen
train_sizes, train_scores, val_scores = learning_curve(
    mlp, X, y,
    cv=5,
    shuffle=True,
    train_sizes=np.linspace(0.1,1.0,10),
    scoring="neg_log_loss",
    n_jobs=6
)

train_scores_mean = np.mean(train_scores, axis=1)
val_scores_mean = np.mean(val_scores, axis=1)

# Lernkurven visualisieren
plt.plot(train_sizes, train_scores_mean, 'o-', color="r", label="Training score")
plt.plot(train_sizes, val_scores_mean, 'o-', color="g", label="Cross-validation score")

plt.xlabel("train size")
plt.ylabel("score")
plt.savefig("learningcurve.png", dpi=300)
plt.show()

#%% # Weitere Bilder klassifizieren
# - Ordner "eigenes_foto" erstellen und dort ein eigenes Bild ablegen
# - rows und cols gegebenfalls anpassen: Nur so viele Kacheln angeben, wie eigene Bilder vorhanden

X_new = load_images(workingdir+'/eigenes_foto/')
X_new = np.asarray(X_new)

y_new = mlp.predict(X_new)

visualize_pred(X_new, y_new,cols=1,rows=1)



#%%

# Weitere Möglichkeit: Grid Search zur Parametersuche

# zusätzlich benötigte Bibliotheken einlesen
from itertools import product
from sklearn.model_selection import GridSearchCV

# Parameter festlegen
parameters = [
   {
        'hidden_layer_sizes' : [x for x in product(range(10,210,20), range(10,210,20))]
    }
 ]

# Grid search durchführen
gridsearch = GridSearchCV(
    mlp,
    parameters,
    scoring='f1_micro',
    n_jobs=6,
    verbose=10
)

gridsearch.fit(X_train, y_train)

#%% Beste Kombination der Grid Search ausgeben

print(f"Die Kombination ist:\n"
      f"{gridsearch.best_params_['hidden_layer_sizes'][0]} Schichten in Layer 1 und\n"
      f"{gridsearch.best_params_['hidden_layer_sizes'][1]} Schichten in Layer 2")

#%% Evaluieren der Gridsearch

# zusätzlich benötigte Bibliothek laden
import seaborn as sns

# Ergebnisse der Parametersuche ablegen,
# Parameter der ersten beiden Schichten als Heatmap visualisieren
# und die beste Kombination herausfinden

result = pd.DataFrame({
    'f1' : gridsearch.cv_results_['mean_test_score'],
    'layer1' :  [x['hidden_layer_sizes'][0]  for x in gridsearch.cv_results_['params']],
    'layer2' :  [x['hidden_layer_sizes'][1]  for x in gridsearch.cv_results_['params']]
})
result_wide = pd.pivot_table(result, values='f1',
                     index=['layer1'],
                     columns='layer2')

# Abspeichern
result.to_csv("Gridsearch.csv")

# Visualisieren
sns.heatmap(result_wide)

# Beste Kombination ausgeben
print(f"Die Kombination ist:\n"
      f"{gridsearch.best_params_['hidden_layer_sizes'][0]} Schichten in Layer 1 und\n"
      f"{gridsearch.best_params_['hidden_layer_sizes'][1]} Schichten in Layer 2")


#%%  Modell abspeichern und neu laden

# zusätzlich benötigte Bibliothek einlesen
from joblib import dump, load

# Modell abspeichern
dump(mlp,'models/mlp.joblib')

# Modell laden
mlp = load('models/mlp.joblib')
