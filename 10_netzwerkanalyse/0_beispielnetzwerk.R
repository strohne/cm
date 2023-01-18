#
# Beispielnetzwerk erstellen und visualisieren
#

# Bibliotheken laden
library(igraph)
library(tidygraph)
library(ggplot2)
library(ggraph)
library(tidyverse)
library(ggforce)


# Kantenliste 
edges <- data.frame(
  source = c("A", "A", "B", "B", "B", "C", "C", "G", "G", "H"), 
  target = c("B", "D", "C", "D", "F", "D", "E", "H", "I", "I")
)

#nodes <- data.frame( 
#  id = c("A", "B", "C", "D", "E", "F", "G", "H", "I"), 
#  label = c("Person A", "Person B", "Person C", 
#            "Person D", "Person E", "Person F",
#            "Person G", "Person H", "Person I")
#)


# Graph-Objekt erstellen
graph <- tbl_graph(edges = edges, directed = FALSE)

graph <- graph %>% 
  mutate(degree = centrality_degree()) %>% 
  mutate(type = case_when(
    degree <= 1 ~ "low", 
    degree == 2 ~ "medium", 
    TRUE ~ "high"))

print(graph)

#
# Visualisierung ----
#

# 1. Simulation physikalischer Kräfte
ggraph(graph, layout='stress') + 
  geom_edge_link() + 
  geom_node_point(aes(color = type), size = 8) +
  geom_node_text(aes(label = name)) + 
  coord_fixed(1.5) +
  theme_void()

ggsave("forcedirected.png", dpi=300)

# 2. Lineares Layout
ggraph(graph, layout = 'linear') + 
  geom_edge_arc() +
  geom_node_point(aes(color=type), size=8) +
  geom_node_text(aes(label=name)) +
  coord_fixed(3) +
  theme_void()

ggsave("systematic.png", dpi=300)


# 3. Heatmap 

ggplot(edges, aes(y=source, x=target))+
  geom_tile(color = "lightgray", fill="gray") +
  scale_x_discrete(limits =  c("A", "B", "C", "D", "E", "F", "G", "H", "I")) +
  scale_y_discrete(limits = c("A", "B", "C", "D", "E", "F", "G", "H", "I")) +
  theme_bw(base_size = 30) + 
  coord_fixed() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank())

ggsave("heatmap.png", dpi=300)

# 4. Hive-Plot
ggraph(graph, layout = 'hive', axis = type) + 
  geom_edge_hive() +
  geom_axis_hive(aes(colour = type), size = 2) +
  geom_node_text(aes(label = name), size = 5) + 
  coord_fixed(1) +
  theme_void()

ggsave("hive.png", dpi=300)

