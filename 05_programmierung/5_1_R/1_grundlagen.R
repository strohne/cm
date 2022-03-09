#
# Dieses Skript beinhaltet eine Einführung in
# - Basisfunktionen und -operatoren
# - Datentypen in R 
# - Auswählen von Werten 
# - Rechenoperationen
# - Funktionen
# - Kontrollstrukturen
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
library(tidyverse)


# Aufrufen der Hilfe durch ?
?paste0

# Aufrufen der Hilfe von nicht geladenen FUnktionen durch ??
??describe


# Datentyen ---- 

# 1. Einzelwerte
me <- "Leo"

# 2. Vektoren
# Erstellen von Vektoren über die Funktion c()
personen <- c("Bea", "Leo")
personen <- c(personen, "Niska")
print(personen)

# Bezeichnen von Elementen in Listen oder Vektoren 
person <- list(vorname="Inger",nachname = "Engmann")

# 3. Tabellen
# Erstellen eines dataframe über die Funktion (data.frame()),
# der dataframe besteht aus untereinandergehängte Vektoren.
personen <- data.frame (
  name  = c("Bea","Leo","Niska","Inger","Tobbe"),	
  alter = c(24,26,25,52,17),
  typ   = c("Bot","Bot","Bot", "Mensch","Mensch")
)


# Adressieren von Werten ----

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
personen$name <- NULL
personen$name <- c("Bea","Leo","Niska","Inger","Tobbe")



# Umwandeln in weitere Datentypen: 
# - als Matrix (as.matrix)
# - als tidyverse-tibble (as_tibble)
# - zurückwandeln in einen Dataframe (as.data.frame)

as.matrix(personen)
as_tibble(personen)
as.data.frame(personen)

# Datentyp feststellen
str(personen)


# Grundrechenarten ---- 
# Rechenoperationen in R, u.a. 
# - Addieren über +
# - Subtrahieren über - 
# - Multiplizieren über *
# - Dividieren über /
# - Quadrieren über ^2
alter <- 2017-1989
jahr <- 1989 + alter

# Funktionen ----

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



# Kontrollstrukturen ----

# Loop mit for: 
# - für jeden Eintrag (name) in Liste (personen$name)
#   wird Funktion ausgeführt (print())
for (item in personen$name) {
  message <- paste0(item," is a bot")
  print(message)
}


# if-Bedingung
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

# if-else-Bedingung 
for (i in 1:nrow(personen)) {
  row = personen[i,]
  
  if (row$typ == "Bot") {
    message <- paste0(row$name," is a bot")
  } else {
    message <- paste0(row$name," is a human")
  }

  print(message)
}


# if-else-Bedingung 
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


#
# Vektorisierung ----
#


# Vektorisierte Funktionen 
paste0(personen$name," is a bot")

# lapply()-Funktion: wendet auf Liste (1. Parameter) eine Funktion (2. Parameter) an.
lapply(personen$name, paste0, " is a bot")
