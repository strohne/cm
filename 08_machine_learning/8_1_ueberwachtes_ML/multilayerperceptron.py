#%%

# Dieses Skript trainiert ein Multilayerperceptron (MLP)
# zur Klassifizierung von Bildern

#%% Bibliotheken

import os

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from PIL import Image

from sklearn.neural_network import MLPClassifier
from sklearn.metrics import confusion_matrix,\
                            classification_report
from sklearn.model_selection import\
                             train_test_split

#%% Funktionen

# Funktion, um Bilder einzulesen und
# die Pixel der Bilder als Liste auszulesen
def load_images(folder):
    images = []
    files = sorted(os.listdir(folder))
    for filename in files:
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

X_train, X_val, y_train, y_val = train_test_split(X ,y, test_size=0.2, stratify=y, random_state=180)

#%% Modell trainieren

# - Parameter im MLPClassifier() festlegen
# - weitere mögliche Parameter sind beispielsweise
#       - der Solver (z.B. solver="adam")
#       - die Aktivierungsfunktion (z.b. activation="relu")
#       - die Lernrate, (z.B. learning_rate='adaptive')
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


#%% Loss curve auf allen Daten: y=Loss, x=Epoch. Sollte gegen 0 gehen.

# - Grafik erstellen durch plot()
# - Achsenbeschriftung hinzufügen durch .xlavel sowie .ylabel

plt.plot(mlp.loss_curve_)
plt.xlabel("epoch")
plt.ylabel("loss")
plt.savefig("8_1_losscurve.png", dpi=300)
plt.show()




#%% Validierung des trainierten Modells

# - Vorhersagen von Labels durch predict()
# - Confusion Matrix berechnen durch confusion_matrix()
# - Werte wie Recall oder F1 durch classification_report() ausgeben
#- Falls Sie Beispielbilder visualisieren wollen, siehe unten die Funktion vizualize_pred()

# y vorhersagen
y_pred = mlp.predict(X_train)

# Print confusion matrix
conf = confusion_matrix(y_train, y_pred)
print(pd.DataFrame(conf))

# Precision, recall und F1-Wert
report = classification_report(y_train, y_pred)
print(report)

#%% Validierung des Modells nach abgeschlossenem Training

# siehe vorherigen Codeblock: X_train durch X_val ausgetauscht
# um zu sehen, ob das Modell auch für neue Daten geeignet ist

# y vorhersagen
y_pred = mlp.predict(X_val)

# Print confusion matrix
conf = confusion_matrix(y_val, y_pred)
print(pd.DataFrame(conf))

# Precision, recall und F1-Wert
report = classification_report(y_val, y_pred)
print(report)


#%% # Weitere Bilder klassifizieren

# - Ordner "eigenes_foto" erstellen und dort ein eigenes Bild ablegen
# - rows und cols gegebenfalls anpassen: Nur so viele Kacheln angeben, wie eigene Bilder vorhanden

workingdir = os.getcwd()
X_new = load_images(workingdir + '/eigenes_foto/')
X_new = np.asarray(X_new)

y_new = mlp.predict(X_new)
print(y_new)



#%%  Modell abspeichern und neu laden

# zusätzlich benötigte Bibliothek einlesen
from joblib import dump, load

# Modell abspeichern
dump(mlp,'mlp.joblib')

# Modell laden
mlp = load('mlp.joblib')

#%% Visualisierung von Einzelfällen

# Die folgende Funktion wählt zufällig Bilder aus dem Trainingsdatensatz (Parameter X) aus,
# stellt sie dar und beschriftet die Bilder mit der vorhergesagten Kategorie (Parameter y)
def visualize_pred(X, y, ncol=5, nrow=5):
    selected = random.sample(range(len(X)), ncol * nrow)

    plt.figure(figsize=(10,10))

    for i, num in enumerate(selected):
        some_pixels = X[num]
        some_image = some_pixels.reshape(48,48)

        some_label = y[num]

        plt.subplot(ncol, nrow ,i+1)
        plt.xticks([])
        plt.yticks([])
        plt.grid(False)

        plt.imshow(some_image, cmap="gray")
        plt.xlabel(some_label)

    plt.show()

# Beispielaufruf der Funktion
visualize_pred(X_train, y_pred)
