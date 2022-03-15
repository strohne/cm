#
# Einführung in R
#

# - 1. Basisfunktionen und -operatoren [im Buch: Kapitel 5.1.1]
#       - Einzelwerte ausgeben
#       - Laden von Packages
#       - Aufrufen der Hilfe
# - 2. Funktionsaufrufe [im Buch Kapitel 5.1.2]
#       - Einzelwerte
#       - Bezeichnung von Elementen in Listen oder Vektoren
#       - Grundrechenarten/Rechenoperatoren 
#       - Funktionen 
# - 3. Datentypen [im Buch: Kapitel 5.1.3]
#       - Vektoren
#       - Bezeichnen von Elementen in Listen oder Vektoren
#       - Tabellen
#       - Adressieren von Werten
# - 4. Loops und Kontrollstrukturen [im Buch: Kapitel 5.1.3]
#       -  Loop mit for
#       -  Loop mit for ohne "item"
#       -  if-Bedingung
#       -  if-else-Bedingung
#       - Vektorisierte Funktionen [im Buch: Kapitel 5.1.3]

#
# 1. Basisfunktionen und -operatoren [Kapitel 5.1.1] ---- 
#

# Um einzelne Zeilen auszuführen, klicken Sie auf "Run" oder 
# setzen der Cursor auf die jeweilige Zeile und drücken die 
# Tasten Strg bzw. Ctrl und Enter

# Einzelwerte ausgeben
# - Zuweisung von Werten ("Leo") zu Objekten (ich) durch den 
# Zuweisungsoperator (<-). Der Wert erscheint rechts bei Ihren
# aktuellen Datenobjekten. 
# - Zusammenfügen von Werten durch paste0()
# - ausgeben von Werten unten in der Konsole durch print()
ich <- "Leo"
gruss <- paste0("Hallo ",ich)
print(gruss)

# Entfernen von Werten aus den Datenobjekten durch rm()
rm(ich)

# Laden von Packages
# - Packages stellen eine Sammlung von Funktionen bereit
# - die Packages müssen einmalig installiert werden (über 
# den Reiter "Packages")
# - in jedem Skript müssen die verwendeten Packages neu 
# über library() geladen werden
# - Packages werden zu Anfang eines R-Skripts geladen
library(tidyverse)

# Aufrufen der Hilfe durch ?
?paste0

# Aufrufen der Hilfe von nicht geladenen FUnktionen durch ??
??skim

#
# 2. Funktionsaufrufe [5.1.2] ----
#

# I. Einzelwerte
name <- "Bea"

# II. Bezeichnung von Elementen in Listen oder Vektoren (Normaler Funktionsaufruf)
name <- paste0("Inger","Engmann") 

# III. Grundrechenarten/Rechenoperatoren 

# Grundrechenarten in R, u.a. 
# - Addieren über +
# - Subtrahieren über - 
# - Multiplizieren über *
# - Dividieren über /
# - Quadrieren über ^2
alter <- 2017-1989
jahr <- 1989 + alter

# IV. Funktionen

# Funktion definieren über function()
# - in den Klammern werden die benötigten Parameter angegeben 
# - danach folgt eine geschweifte Klammer {} mit den Befehlen 
# - zum Schluss wird unter return() der Output angegeben
calculate_age <- function(year_now,year_birth) {
  alter <- year_now - year_birth
  return (alter)
}

# Aufrufen einer selbstdefinierten Funktion 
alter <- calculate_age(2017, 1989)

#
# 3.Datentyen [Kapitel 5.1.3] ---- 
#

# I. Vektoren
# Erstellen von Vektoren über die Funktion c()
personen <- c("Bea", "Leo")
personen <- c(personen, "Niska")
print(personen)

# II. Bezeichnen von Elementen in Listen oder Vektoren 
person <- list(vorname="Inger",nachname = "Engmann")

# III. Tabellen
# Erstellen eines dataframe über die Funktion (data.frame()),
# der dataframe besteht aus untereinandergehängte Vektoren.
personen <- data.frame (
  name  = c("Bea","Leo","Niska","Inger","Tobbe"),	
  alter = c(24,26,25,52,17),
  typ   = c("Bot","Bot","Bot", "Mensch","Mensch")
)

# IV. Adressieren von Werten

# Auswählen einer Zeile
personen[1,]

# Auswählen einer Spalte
personen[,1]

# Auswählen eines Werts
personen[1,1]

# Auswählen von mehreren Spalten über [] und c()
personen[,c("name","alter")]

# Auswählen von mehreren Zeilen oder Werten über []
# - der erste Parameter (hier die Liste c(1:3)) wählt die Zeilen aus
# - der zweite Parameter (hier 1) wählt die Spalten aus
personen[c(1:3),1]

# Auswahlen von mehreren Zeilen über eine Bedingung
personen[personen$alter > 30,]

# Weitere Varianten für die Auswahl von Spalten,
# bei denen teils andere Datentypen zurückgegeben werden:
personen[1]
personen[[1]]
personen[,1,drop=F]

# Auswählen von Spalten über $
personen$name

# Ändern des Wertes
personen$name <- "anonym"
personen$name <- c("Bea","Leo","Niska","Inger","Tobbe")

#Spalten ergänzen oder löschen
personen$nummer <- c(1,2,3,4,5)
personen$nummer <- NULL

# Umwandeln in weitere Datentypen: 
# - als Matrix (as.matrix)
# - als tidyverse-tibble (as_tibble)
# - zurückwandeln in einen Dataframe (as.data.frame)

as.matrix(personen)
as_tibble(personen)
as.data.frame(personen)

# Datentyp feststellen
str(personen)

#
# 4. Loops und Kontrollstrukturen [Kapitel 5.1.3] ----
#

# I. Loop mit for: 
# - für jeden Eintrag (name) in Liste (personen$name)
#   wird Funktion ausgeführt (print())
for (item in personen$name) {
  message <- paste0(item," is a bot")
  print(message)
}

# II. Loop mit for ohne "item"
for(name in personen$name) {
  message <- paste0(name, " is a bot")
  print(message)
}


# III. if-Bedingung
# - Bereich der Zeilennummern über 1:nrow() ermitteln 
# - einzelne Zeilen über [i,] adressieren 
# - Bedingung: typ == Bot in if-Schleife formulieren 
#   --> nur wenn die Bedingung erfüllt ist, 
#   wird der Print-Befehl ausgeführt
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$typ == "Bot") {
    print(paste0(row$name," is a bot"))
  }
}

# IV. if-else-Bedingung 
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$typ == "Bot") {
    message <- paste0(row$name," is a bot")
  } else {
    message <- paste0(row$name," is a human")
  }
  
  print(message)
}

# V. if-else-Bedingung 
# - Ergänzung der if-Bedingung um alternative else-Bedingung 
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$typ == "Bot") {
    message <- paste0(row$name," is a bot")
  } else {
    message <- paste0(row$name," is a human")
  }
  
  print(message)
  
}

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

# VI. Vektorisierte Funktionen
paste0(personen$name," is alive")

# lapply()-Funktion: wendet auf Liste (1. Parameter) eine Funktion (2. Parameter) an.
lapply(personen$name, paste0, " is a bot")