#
# Umgang mit Werten und Listen ----
#

# Text ausgeben
print ("Hello world!")

# Rechnen
23 + 1

# Objekte definieren
meinname = "Eliza"

# Objekte verwenden
print("Mein Name ist " + meinname)

# Listen erstellen
eigenschaften = ["schön", "reich", "intelligent"]

# Das erste Element einer Liste ausgeben
print(eigenschaften[0])

# Bibliothek für reguläre Ausdrücke einbinden 
# Alle Vokale ersetzen
import re 
eigenschaft = re.sub("[aoueiöäü]","_","schön")


#
# Kontrollstrukturen ----
#

# For-in-Schleife: Alle Elemente einer Liste abarbeiten
meinname = "Eliza"
for eigenschaft in eigenschaften:
    satz = meinname + " ist " + eigenschaft
    print (satz)

# List comprehension: neue Liste aus bestehender Liste erstellen
saetze = ["Eliza ist " + x for x in eigenschaften]

# If-Bedingungen
for x in eigenschaften:
    if x != "schön":
        print ("Eliza ist " + x)


# If-elif-else-Bedingungen
for x in eigenschaften:
    if x == "schön":
        print ("Eliza war " + x)
    elif x == "reich":
        print ("Eliza wird " + x + " sein")
    else:
        print ("Eliza ist " + x)


#
# Funktionen ----
#

# Funktion definieren
def superduper(eigenschaft):
    x = "sehr " + eigenschaft
    return (x)

# Funktion verwenden
for x in eigenschaften:
    print("Eliza ist " + superduper(x))

for x in eigenschaften:
    print("Eliza ist " + superduper(eigenschaft=x))

    
# Fehler abfangen über try-except-finally
eigenschaften = ["schön", "reich", 0, "intelligent"]
for x in eigenschaften:
    try:
        x = "Eliza ist " + x
    except:
        x = "Eliza ist irgendwie anders"        
    finally:
        print(x)

# Bestimmte Fehler abfangen
eigenschaften = ["schön", "reich", 0, "intelligent"]
for x in eigenschaften:
    try:
        x = "Eliza ist " + x
    except TypeError:
        x = "Eliza ist eine " + str(x)
    
    print(x)

#
# Dictionaries und Klassen
#
    
# Dictionary definieren
meinname = "Eliza"
ich = {'name': meinname, 'eigenschaft': 'verwirrt'}

# Dictionary verwenden
print(ich['name'] + " ist " + ich['eigenschaft'])

# Klasse definieren
class Jedi(object):
    name = None
    staerke = 0

    def __init__(self, name):
        self.name = name
        self.staerke = 10

    def talk(self):
        print (self.name + "mein Name ist.")
        
        if self.staerke < 5:
            print("Mich schwach ich fühle.")

# Klasse instanziieren
j1 = Jedi("Yoda")
j2 = Jedi("Rey")

# Klasseneigenschaft verändern
j1.staerke = 2

# Klassenmethoden nutzen
j1.talk()
j2.talk()

# Auch Zeichenketten sind Objekte mit Methoden
"Yoda".lower().replace("y","J").capitalize()