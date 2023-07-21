#%%

# Dieses Skript stellt eine Erweiterung zum Multilayer-Perceptron-Skript dar.
# Es wird eine Kreuzvalidierung durchgeführt. Das Ergebnis wird mittels Lernkurven visualisiert.


#%% Bibliotheken laden
import os

import numpy as np
import matplotlib.pyplot as plt

from PIL import Image

from sklearn.neural_network import MLPClassifier

from sklearn.model_selection import train_test_split, learning_curve

#%%

# Funktion, um Bilder einzulesen und
# die Pixel der Bilder als Liste auszulesen
def load_images(folder):
    images = []
    for filename in os.listdir(folder):
        fullname = os.path.join(folder, filename)
        img = Image.open(fullname)
        img = list(img.getdata())
        images.append(img)

    return images

#%%  Bilder X und Label y einlesen

# - In folders die Unterordner angeben, in denen die Bilder liegen
# - Durch for-Schleife nacheinander Bilder einlesen
# - Konvertieren der Bilder in Numpy-Arrays

X = []
y = []

workingdir = os.getcwd() + '/fer2013/train/'
folders = ['happy', 'neutral']

for folder in folders:
    images = load_images(workingdir + folder + '/')

    X.extend(images)
    y.extend([folder] * len(images))

# In Arrays umwandeln
X = np.asarray(X)
y = np.asarray(y)

#%% Trainings- und Validierungssets

# - test_size legt den Anteil der Validierungsdaten fest
# - stratify, um Verteilung der Kategorien beizubehalten
# - random_state, damit die Funktion auch bei mehrmaligem Ausführen die gleiche Aufteilung vornimmt

X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2, stratify=y, random_state=180)

#%% Modell trainieren

# - Parameter im MLPClassifier() festlegen
# - Trainieren des Modells durch fit()

mlp = MLPClassifier(
    hidden_layer_sizes=(1000, 100),
    batch_size=200,
    max_iter=1000,
    n_iter_no_change=10,
    verbose=True,
    random_state=180
)

mlp.fit(X_train, y_train)

#%% Lernkurven visualisieren

# - Werte für Lernkurve durch learning_curve() berechnen. Die Berechnung kann einige Zeit in Anspruch nehmen. Auch bis Sie den ersten Fortschritt sehen, wird es einige Minuten dauern.
# - cv = 5 bedeutet, es wird eine 5-fache-Kreuzvalidierung durchgeführt
# - scoring gibt das Maß an, das geplottet werden soll. Hier: Loss = Fehlerterm
# - durch verbose wird der Fortschritt ausgegeben
# andere mögliche scoring-Maße, siehe: https://scikit-learn.org/stable/modules/model_evaluation.html

# Scores für Lernkurven berechnen
train_sizes, train_scores, val_scores = learning_curve(
    mlp, X, y,
    cv=5,
    shuffle=True,
    train_sizes=np.linspace(0.1, 1.0, 10),
    scoring="neg_log_loss",
    n_jobs=6,
    verbose=100
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
