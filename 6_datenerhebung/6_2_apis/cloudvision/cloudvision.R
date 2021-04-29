#
# Bilderkennung über die Google Cloud Vision API
#


#  
# Packages ----
#

# Package für die Anmeldung bei der Google Cloud Console
library(googleAuthR)

# Package für die Bilderkennung über die API
library(googleCloudVisionR)


#
# Login ----
#

# Um die API nutzen zu können, müssen Sie sich zunächst registrieren:
#
# 1. In der Cloud Console registrieren: https://console.cloud.google.com/

# 2. Projekt erstellen: https://cloud.google.com/resource-manager/docs/creating-managing-projects

# 3. APIs und Dienste aktivieren ("Cloud Vision API"). Befassen Sie sich mit den Kosten:
#    die ersten 1000 Abfragen sind aktuell (Anfang 2021) kostenlos.

# 4. Im API-Bereich Anmeldedaten für ein Dienstkonto erstellen. 
#    Erstellen Sie einen neuen SChlüssel und laden diesen als 
#    JSON-Datei auf Ihren Computer herunter


# Geben Sie den Pfad zu Ihrem Schlüssel an und führen Sie die
# folgende Zeile aus, um sich anzumelden. Der Schlüssel sollte
# geheim gehalten werden, er ist wie ein Passwort.
gar_auth_service(json_file="E:/Credentials/googleservicekey.json")


#
# Bilderkennung durchführen ----
#

# Quellen der Beispielbilder im Projektordner:
# https://pixabay.com/de/photos/frog-schmetterling-teich-spiegelung-540812/
# https://pixabay.com/de/photos/piano-klavier-musik-tasten-%C3%BCben-5353974/

gcv_get_image_annotations(
  imagePaths = "piano.jpg",
  feature = "LABEL_DETECTION",
  maxNumResults = 7
)


gcv_get_image_annotations(
  imagePaths = "schmetterling.jpg",
  feature = "LABEL_DETECTION",
  maxNumResults = 7
)
