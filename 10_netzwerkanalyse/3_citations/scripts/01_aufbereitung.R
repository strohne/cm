#
# Zitationsnetzwerk erstellen 
#

#
# Packages und Daten laden ---- 
#

# Bibliothek laden
library(tidyverse)

# Datensatz einlesen
citations <- read_csv2("data/citations_export.csv")


#
# Datenaufbereitung ---- 
#

# Vollständigkeit des Datensatzes überprüfen.
citations %>% 
  count(object_type, query_type, query_status, level)


# Einschränken der Daten 
# - Eingrenzen auf den query_status "fetched (200)" (= erfolgreich erhobene Daten).
# - Reduzieren der Spalten mittels select().

citations <- citations %>% 
  filter(query_status == "fetched (200)" ) %>%
  #filter(query_status %in% c("fetched (200)", "request error")) %>%
  select(
    id, parent_id, object_id, 
    citing, cited, 
    year, author, title, source_title
  )

# Kantenliste erstellen
# - Herausfiltern von Zitationen (= die Spalte "citing" is nicht leer).
# - Target (=zitierter Artikel) und Source (=zitierender Artikel) auswählen.
# - Duplikate entfernen über distinct().
edges <- citations %>%
  filter(!is.na(citing)) %>% 
  select(source = citing, target = cited) %>% 
  distinct()


# Knotenliste erstellen 
# - Eingrenzen auf Metadaten (die Spalte "citing" ist leer).
# - Auswählen von relevanten Spalten über select.
#   Gleichzeitig wird die Spalte object_id zu id umbenannt.
# - Entfernen von Duplikaten über distinct.
nodes <- citations %>%  
  filter(is.na(citing)) %>% 
  select(id=object_id, author, title, year, source_title) %>% 
  distinct(id, .keep_all = T)

#
# Knoten und Kantenliste abspeichern ----
#

write_csv2(nodes, "data/citations_nodes.csv", na = "")
write_csv2(edges, "data/citations_edges.csv", na = "")
