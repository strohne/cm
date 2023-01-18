#
# Bilderkennung über die Google Cloud Vision API
#


# Pakete laden  ----

# Package für die Anmeldung bei der Google Cloud Console
library(googleAuthR)

# Package für die Bilderkennung über die API
library(googleCloudVisionR)


#
# Login ----
#

# Geben Sie den Pfad zu Ihrem zuvor heruntergeladenen JSON-Schlüssel an und führen Sie die
# folgende Zeile aus, um sich anzumelden. Der Schlüssel sollte
# geheim gehalten werden, er ist wie ein Passwort.
gar_auth_service(json_file="E:/Credentials/googleservicekey.json")


#
# Bilderkennung durchführen ----
#

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
