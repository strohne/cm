#
# Netzwerk aus ähnlichen YouTube-Videos analysieren
#

# Bibliotheken laden
library(igraph)
library(tidygraph)

# Ggf. Knoten- und Kantenliste einlesen 
nodes <- read_csv("videos.nodes.csv", na="None")
edges <- read_csv("videos.edges.csv", na="None")

# Graph-Objekt erstellen
graph <- tbl_graph(nodes,edges)


#
# Netzwerkmaße bestimmen ----
#

# Größe des Netzwerkes 
print(graph)

# Anzahl der Komponenten
no.clusters(graph)

# Dichte des Netzwerks 
graph.density(graph)

# Durchschnittliche Pfadlänge zwischen allen Knoten
average.path.length(graph)

# cliquen aus mindestens 5 Knoten 
cliques(graph, min=5)

# Übersicht über Anzahl der Beziehungen 
# - asymetric: einseitig
# - mutual: wechselseitig
# - null: nicht realisiert
dyad_census((graph))

# Übersicht über Anzahl der Triaden
triad.census(graph)

# Degree der Knoten
degree_distribution(graph)


#
# Zentrale Knoten bestimmen ----
#

# Zentralität berechnen für: Degree, Betweenness, Closeness
graph <- graph %>% 
  mutate(degree = centrality_degree()) %>% 
  mutate(betweenness = centrality_betweenness()) %>% 
  mutate(closeness = centrality_closeness())

# Zentralitätsmaße an Nodes hinzufügen 
# - activate(): Nodes aus dem Graphobjekt addressieren
# - as_tibble(): Nodes aus Graphobjekt wieder in Datenstruktur 
# tibble überführen.
nodes <- graph %>%
  activate("nodes") %>%
  as_tibble() 

# Sortieren der Knoten nach Zentralität
nodes %>% 
  arrange(-degree)

nodes %>% 
  arrange(-betweenness)

nodes %>% 
  arrange(-closeness)

