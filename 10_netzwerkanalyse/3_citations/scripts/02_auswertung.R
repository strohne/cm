#
# Zitationsnetzwerk auswerten 
#

#
# Packages und Daten laden ---- 
#

# Bibliotheken laden
library(tidyverse)
library(igraph)
library(tidygraph)
library(ggraph)

# Knoten- und Kantenliste einlesen 
nodes <- read_csv2("data/citations_nodes.csv", na="None")
edges <- read_csv2("data/citations_edges.csv", na="None")


#
# Netzwerk als Graph-Objekt erstellen ----
#

graph <- tbl_graph(
  nodes = nodes, edges = edges, 
  directed =  TRUE
)

#
# Netzwerkmaße bestimmen ----
#

# Übersicht und Größe des Netzwerkes 
print(graph)

# Anzahl der Komponenten
count_components(graph)

# Dichte des Netzwerks 
graph.density(graph)
transitivity(graph)

# Durchschnittliche Pfadlänge zwischen allen Knoten
average.path.length(graph)
mean_distance(graph)


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

# Zentralität berechnen (Degree, Betweenness, Closeness)
graph <- graph %>% 
  mutate(degree = centrality_degree()) %>% 
  mutate(betweenness = centrality_betweenness()) %>% 
  mutate(closeness = centrality_closeness())

# Zentralitätsmaße zu Nodes hinzufügen 
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


# Visualisierung ----

# Label auf 15 Zeichen kürzen
graph_vis <- graph %>% 
  mutate(title = str_trunc(title, 25))

# Plot 
# (Anmerkung: große Netzwerke sollten besser mit dafür geeigneter Software 
# wie Gephi visualiert werden)
graph_vis %>%
  ggraph(layout="kk") +
  geom_edge_link() +
  geom_node_point(size=1) +
  geom_node_text(aes(label=title), size=1, repel=T)+
  theme_void()

ggsave("network.png", width = 10, height=10, dpi=300, bg="white")
