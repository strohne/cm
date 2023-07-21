#
# Grundlagen von R
#

#
# 1. Basisfunktionen ---- 
#

# Um einzelne Zeilen auszuführen, setzen Sie den Cursor auf 
# die jeweilige Zeile und klicken Sie auf "Run". Besser geht es 
# mit den Tasten Strg und Enter (Windows) bzw. Command und Enter (Mac)

# Objekte anlegen
# - Zuweisung von Werten ("Leo") zu Objekten (ich) durch den 
#   Zuweisungsoperator (<-). 
# - Zusammenfügen von Werten durch paste0()
# - Ausgeben von Werten in der Konsole durch print()

ich <- "Leo"
gruss <- paste0("Hallo ",ich)
print(gruss)

# Entfernen von Objekten aus der Environment mit rm()
rm(ich)


# Laden von Packages
#
# Packages stellen eine Sammlung von Funktionen bereit
# Die Packages müssen einmalig installiert werden (über 
# den Reiter "Packages"), aber immer wieder neu über
# library() geladen werden. Idealerweise werden Packages
# am Anfang eines R-Skripts geladen.
library(tidyverse)


# Aufrufen der Hilfe durch ?
?paste0

# Aufrufen der Hilfe von nicht geladenen FUnktionen durch ??
# Wenn Sie das Package "skimr" laden, können Sie die Hilfe auch mit 
# einem Fragezeichen oder mit der Taste F1 aufrufen.
??skim


#
# 2. Der Aufbau von Skripten ----
#

# Eine Zeichenkette in einem Objekt ablegen
name <- "Bea"

# Zeichenketten aneinanderketten
name <- paste0("Inger ", "Engmann") 


# Grundrechenarten in R
# - Addieren über +
# - Subtrahieren über - 
# - Multiplizieren über *
# - Dividieren über /
# - Quadrieren über ^2
alter <- 2017 - 1989
jahr <- 1989 + alter

# Funktionen definieren:
# - in den Klammern werden die benötigten Parameter angegeben 
# - danach folgt eine geschweifte Klammer {} mit den Befehlen 
# - zum Schluss wird der Output mit return() ausgegeben
calculate_age <- function(year_now, year_birth) {
  alter <- year_now - year_birth
  return (alter)
}

# Aufrufen einer selbstdefinierten Funktion 
alter <- calculate_age(2023, 1989)

#
# 3.Datentypen und Dataframes ---- 
#

# Erstellen von Vektoren über die Funktion c()
personen <- c("Bea", "Leo")
personen <- c(personen, "Niska")
print(personen)

# Elemente in Listen oder Vektoren können benannt werden
person <- list(vorname="Inger",nachname = "Engmann")

# Erstellen eines Dataframe über die Funktion data.frame()
personen <- data.frame (
  name  = c("Bea", "Leo", "Niska", "Inger", "Tobbe"),	
  alter = c(24, 26, 25, 52, 17),
  typ   = c("Bot", "Bot", "Bot", "Mensch", "Mensch")
)


# Auswählen einer Zeile
personen[1, ]

# Auswählen einer Spalte
personen[ ,1]

# Auswählen eines Werts
personen[1, 1]

# Auswählen von mehreren Spalten mit c()
personen[, c("name","alter")]

# Gleichzeitiges Auswählen von Zeilen und Spalten
# - der erste Parameter c(1:3) wählt die Zeilen aus
# - der zweite Parameter 1 wählt die Spalte aus
personen[c(1:3),1]

# Auswählen von Zeilen über eine Bedingung
personen[personen$alter > 25, ]

# Weitere Varianten für die Auswahl von Spalten,
# bei denen teils andere Datentypen zurückgegeben werden
personen[1]              # Datentyp data.frame
personen[[1]]            # Datentyp Vektor
personen[ , 1, drop=F]   # Datentyp data.frame

# Auswählen von Spalten über $
personen$name

# Ändern von Werten
personen$name <- "anonym"
personen$name <- c("Bea","Leo","Niska","Inger","Tobbe")

# Eine neue Spalte anlegen 
personen$nummer <- c(1, 2, 3, 4, 5)

# Eine Spalte löschen
personen$nummer <- NULL



# Datentyp eines Objekts feststellen
str(personen)

# Umwandeln in andere Datentypen: 
# - als Matrix (as.matrix)
# - als Tidyverse-Tibble (as_tibble)
# - in einen Dataframe (as.data.frame)

as.matrix(personen)
as_tibble(personen)
as.data.frame(personen)

# Umwandeln von Zeichenketten in Zahlen
as.numeric("1852")

#
# 4. Schleifen und Kontrollstrukturen ----
#

# For-Schleife 
# - für jeden Eintrag (name) in Liste (personen$name)
#   wird der Code zwischen den geschweiften Klammern ausgeführt
for (item in personen$name) {
  message <- paste0(item," is a bot")
  print(message)
}

# Der Bezeichner "item" ist selbstgewählt und 
# kann zum Beispiel durch "name" ersetzt werden
for (name in personen$name) {
  message <- paste0(name, " is a bot")
  print(message)
}

# If-Bedingungen
# - Bereich der Zeilennummern über 1:nrow() ermitteln 
# - Einzelne Zeilen über [i, ] auswählen
# - Bedingung typ == "Bot" prüfen und 
#   nur wenn die Bedingung erfüllt ist,
#   den print()-Befehl ausführen
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$typ == "Bot") {
    print(paste0(row$name," is a bot"))
  }
}

# If-else-Bedingung 
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$typ == "Bot") {
    message <- paste0(row$name," is a bot")
  } else {
    message <- paste0(row$name," is a human")
  }
  
  print(message)
}

# Kombination mehrerer Bedingungen
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$alter < 20) {
    print("A young person")
  } 
  else if (row$alter < 30) {
    print("A twen")
  }
  else {
    print("How old is old? ")
  }
}

# Vektorisierte Funktionen können auf Listen
# wie personen$name angewendet werden und 
# nicht nur auf Einzelwerte
paste0(personen$name, " is alive")

# Mit der lapply()-Funktion können beliebige Funktionen
# auf eine Liste wie personen$name angewendet werden.
# Da paste0 bereits vektorisiert ist, ist das Ergebnis
# inhaltlich gleich
lapply(personen$name, paste0, " is a bot")

