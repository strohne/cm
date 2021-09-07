#
# Netzwerk aus ähnlichen YouTube-Videos analysieren
#

# Bibliotheken laden
library(igraph)
library(tidygraph)

# Ggf. Knoten- und Kantenliste einlesen 
videos.nodes <- read_csv("videos.nodes.csv", na="None")
videos.edges <- read_csv("videos.edges.csv", na="None")

# Graph-Objekt erstellen
videos.graph <- tbl_graph(videos.nodes,videos.edges)


#
# Netzwerkmaße bestimmen ----
#

# Größe des Netzwerkes 
print(videos.graph)

# Anzahl der Komponenten
no.clusters(videos.graph)

# Dichte des Netzwerks 
graph.density(videos.graph)

# Durchschnittliche Pfadlänge zwischen allen Knoten
average.path.length(videos.graph)

# cliquen aus mindestens 5 Knoten 
cliques(videos.graph, min=5)

# Übersicht über Anzahl der Beziehungen 
# - asymetric: einseitig
# - mutual: wechselseitig
# - null: nicht realisiert
dyad_census((videos.graph))

# Übersicht über Anzahl der Triaden
triad.census(videos.graph)

# Degree der Knoten
degree_distribution(videos.graph)


#
# Zentrale Knoten bestimmen ----
#

# Zentralität berechnen für: Degree, Betweenness, Closeness
videos.graph <- videos.graph %>% 
  mutate(degree = centrality_degree()) %>% 
  mutate(betweenness = centrality_betweenness()) %>% 
  mutate(closeness = centrality_closeness())

# Zentralitätsmaße an Nodes hinzufügen 
# - activate(): Nodes aus dem Graphobjekt addressieren
# - as_tibble(): Nodes aus Graphobjekt wieder in Datenstruktur 
# tibble überführen.
videos.nodes <- videos.graph %>%
  activate("nodes") %>%
  as_tibble() 

# Sortieren der Knoten nach Zentralität
videos.nodes %>% 
  arrange(-degree)

videos.nodes %>% 
  arrange(-betweenness)

videos.nodes %>% 
  arrange(-closeness)

