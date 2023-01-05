#
# Netzwerk aus ähnlichen YouTube-Videos analysieren
#

# Bibliotheken laden
library(tidyverse)
library(igraph)
library(tidygraph)
library(ggraph)

# Ggf. Knoten- und Kantenliste einlesen 
nodes <- read_csv2("videos.nodes.csv", na="None")
edges <- read_csv2("videos.edges.csv", na="None")

# Graph-Objekt erstellen
graph <- tbl_graph(nodes,edges)


#
# Netzwerkmaße bestimmen ----
#

# Größe des Netzwerkes 
print(graph)

# Anzahl der Komponenten
count_components(graph)

# Dichte des Netzwerks 
graph.density(graph)
transitivity(graph)

# Durchschnittliche Pfadlänge zwischen allen Knoten
average.path.length(graph)
mean_distance(graph)

# cliquen aus mindestens 5 Knoten 
cliques(graph, min=5)
max_cliques(graph, min=5)

# Übersicht über Anzahl der Beziehungen 
# - asymetric: einseitig
# - mutual: wechselseitig
# - null: nicht realisiert
dyad_census(graph)

# Übersicht über Anzahl der Triaden
triad_census(graph)

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

#
# Grafik erstellen ----
#

# Graph-Objekt auf Knoten mit Degree > 1 einschränken
# und die Label kürzen
graph_vis <- graph_vis %>% 
  filter(degree > 1) %>% 
  mutate(label = str_trunc(label, 15)) 


# Graph visualisieren
graph_vis %>% 
  ggraph(layout="stress") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_label(aes(
    label = label
    
  )) +
  theme_void()

