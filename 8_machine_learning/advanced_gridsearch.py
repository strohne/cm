#%%

# Dieses Skript stellt eine Erweiterung zum Multilayerperceptron-Skript dar.
# Um die optimalen Parameter für das Modell zu finden, wird eine
# Gridsearch durchgeführt und ausgewertet.

#%% Bibliotheken

import os

import numpy as np
import pandas as pd

from PIL import Image

from sklearn.neural_network import MLPClassifier

from sklearn.model_selection import\
                             train_test_split,\
                             GridSearchCV

from itertools import product
import seaborn as sns


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

X_train, X_val, y_train, y_val = train_test_split(X ,y, test_size=0.2, stratify=y, random_state=180)


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


#%% Parametersuche durch Gridsearch

# Parameter festlegen, die von der Gridsearch abgefragt werden sollen
# Hier: unterschiedliche Kombinationen für die Größe der verdeckten Schichten erstellt.
# Geben Sie sich zum besseren Verständnis über print(layers) die definierten Schichten aus.
layers = [x for x in
            product(
              range(10,211,50),
              range(10,211,50)
            )
          ]

params = [{'hidden_layer_sizes' : layers}]

# Gridsearch durchführen
gridsearch = GridSearchCV(
    mlp,
    params,
    scoring='f1_micro',
    n_jobs=6,
    verbose=10
)

gridsearch.fit(X_train, y_train)


#%% Evaluieren der Gridsearch

# Ergebnisse der Parametersuche in einem Dataframe ablegen,
# Parameter der ersten beiden Schichten als Heatmap visualisieren,
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


