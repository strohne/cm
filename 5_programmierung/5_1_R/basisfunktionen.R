#
# Dieses Skript zeigt einige Basisfunktionen
#



# 1. Einzelwerte
me <- "Jakob"

greeting <- paste0("Hi ",me,"!")
print(greeting)

# 2. Vektoren
persons <- c("Inga","Bea","Leo")
paste0("Hi ",persons)

# 3. Tabellen
persons <- data.frame(
  firstname = c("Bea","Leo","Inga"),
  age = c(21,38,56),
  type = c("Bot","Human","Human")
)


# Zugriff auf einzelne Spalten und Werte:

persons$firstname

paste0("Hi ",persons$firstname)

persons[c(1:3),2]


#
# Aufgabe ----
#

# Berechnen Sie den Altersdurchschnitt von Bea, Leo und Inga!
# Benutzen Sie dazu die mean-Funktion.

