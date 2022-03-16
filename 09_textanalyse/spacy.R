# Syntax und Semantik: Automatisierte Textanalyse mit Spacy

#
# Packages ----
#
library(tidyverse)
library(spacyr)
library(readtext)
library(tidygraph)
library(ggraph)
theme_set(theme_bw())


#
# Setup Spacy ----
#
# - Nur einmalig notwendig
# - Für mehr Infos siehe https://cran.r-project.org/web/packages/spacyr/readme/README.html

# Spacy Installieren
spacy_install()

# Deutsches Sprachmodell herunterladen 
spacy_download_langmodel("de")


#
# Modell initialisieren ----
#
spacy_initialize(model = "de_core_news_sm")


#
# Texte einlesen und parsen---- 
#
# Einlesen
texte <- readtext("korpus",encoding="UTF-8")

# Parsen
# - tokenisiert Texte und ermittelt POS-Tags
# - durch parameter dependency = TRUE werden gleichzeitig 
#   die Dependenzen ermittelt
txt_parsed <- spacy_parse(texte, dependency = TRUE)


#
# POS-Tagging ----
#
# Anzahl der Wortarten ermitteln
txt_parsed %>% 
  count(pos) %>%
  ggplot(aes(x=n, y=pos))+
  geom_col()

# Nur Nomen beibehalten
txt_noun <- txt_parsed %>% 
  filter(pos == "NOUN")


#
# Dependenzen: Satzstruktur ausgeben ----
#

# Das Ergebnis des Dependenz-Parsers ist ein Syntaxbaum
# Ein Syntaxbaum besteht aus Knoten und Kanten zwischen den Knoten. 
# Die Liste der Token kann als Kantenliste interpretiert werden,
# denn zu jedem Wort (tid / word) ist angegeben, 
# von welchem Wort es abhängt (source / word_source).
# Die Art der Abhängigkeit wird in der Spalte relation angegeben, 
# nach dem TIGER Treebank annotation scheme.

# Zur Bedeutung der Relationen siehe https://spacy.io/api/annotation#dependency-parsing
# Für Informationen zum TIGER Treebank annotation scheme siehe http://www.ims.uni-stuttgart.de/forschung/ressourcen/korpora/TIGERCorpus/annotation/index.html

# Tabelle mit Bedeutung der syntaktischen Relationen laden

#ttree <- read_tsv("docs/tiger_treebank_syntax.txt")

#
# 1. Beispielsatz auswählen
#

ex_sentence <- txt_parsed %>% 
  filter(doc_id=="RF29.txt",sentence_id==10)

#
# 2. Als Baum darstellen
#

# Kantenliste
g_edges <-   ex_sentence %>% 
  filter(dep_rel != "ROOT") %>% 
  select(from=head_token_id,to=token_id,label=dep_rel) 

# Knotenliste
g_nodes <- ex_sentence %>% 
  select(id=token_id,label=token,pos) %>% 
  distinct() 

# Graph
g_tree <- tbl_graph(g_nodes,g_edges,directed=T)

# ...um Hintergrund unten einzufärben
g_tree <- g_tree %>% 
  mutate(pos_main = pos %in% c("NOUN","VERB"))

# Plot als Baum
ggraph(g_tree,layout="tree") +
  geom_edge_diagonal(aes(label=label,color=label),show.legend=F) +
  geom_node_label(aes(label=label,color=pos,fill=pos_main)) +
  scale_fill_manual(values=c("white","black")) +
  guides(fill="none") +
  theme_void() +
  theme(plot.margin = unit(c(2,2,2,2), "cm"),legend.position = "bottom") +
  coord_cartesian(clip = "off")
  
# Grafik abspeichern
ggsave("parsing.png",width = 18,height=15,unit="cm")

# Plot als Line Graph
ggraph(g_tree,layout="linear") +
  geom_edge_arc(
    aes(label=label,color=label),
    position=position_nudge(y=0.05),fold=T,
    angle_calc = "along",label_dodge = unit(-0.5,"cm"),
    arrow=arrow(type="closed",length=unit(0.3,"cm"))
  ) +
  geom_node_label(aes(label=label,color=pos)) +
  theme_void() 

