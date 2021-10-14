#
# Netzwerk aus ähnlichen YouTube-Videos erstellen
#

# Bibliothek und Daten laden
library(tidyverse)
videos <- read_csv2("videos.export.csv",na = "None")


# Relevante Zeilen (filter) 
# und Spalten (select) behalten
# - wegfiltern von Informationen zur Erhebung 
# wie die Erhebungszeit
videos <- videos %>%
  filter(object_type == "data" | object_type =="seed") %>%
  select(id,parent_id,object_id,snippet.title)


# Die Kantenliste erstellen:
# - an jede Zeile die übergeordnete Zeile 
#   anhängen (left_join)
# - Spalten auswählen und umbenennen (select)
# - Duplikate entfernen (distinct)
# - Unvollständige Zeilen entfernen (na.omit)
videos.edges <- videos %>%
  left_join(videos,by= c("parent_id"="id")) %>%
  select(source=object_id.y,target=object_id.x) %>% 
  distinct()%>%
  na.omit()


# Die Knotenliste erstellen:
# - Spalten auswählen und umbenennen (select)
# - Duplikate entfernen
videos.nodes <- videos %>%
  select(id=object_id,label=snippet.title) %>% 
  distinct(id, .keep_all=T)


# Knoten- und Kantenliste abspeichern 
write_csv(videos.edges,"videos.edges.csv",na = "")
write_csv(videos.nodes,"videos.nodes.csv",na = "")


