#
# Simulation einer künstlichen Welt 
#

#
# Packages laden ----
#
library(tidyverse)

#
# 1. Welt errichten ----
#

# Rahmenbedingungen der Welt festlegen 
world_width <- 50
world_height <- 50
world_epochs <- 100
world_agents <- 100


# Tibble erstellen und Agenten in der Welt verteilen
agents <- tibble(    
  no  = c(1:world_agents),    
  x   = sample(world_width, world_agents, replace = T),
  y   = sample(world_height, world_agents, replace = T),
  dir = sample(360, world_agents, replace = T) - 1,
  state = FALSE
)

# Status des ersten Agenten auf TRUE setzen 
agents$state[1] <- TRUE

# Datframe für das Loggen der Epochen erstellen
history <- data.frame()

#
# 2. Funktionen für die Aktionen in jeder Epoche ----
#

# Agenten bewegen 
agentsMove <- function(agents) {
  
  # Zufällig zwischen -25 und +25 Grad rotieren
  rotate <- sample(c(-25 : 25), world_agents, replace = T)
  
  agents$dir <- agents$dir + rotate
  agents$dir <- agents$dir %% 360
  
  # Horizontal bewegen 
  dir_x = round(sin((agents$dir * pi) / 180))
  agents$x <- agents$x - dir_x
  agents$x <- (agents$x - 1) %% world_width + 1
  
  # Vertikal bewegen 
  dir_y = round(cos((agents$dir * pi) / 180))
  agents$y <- agents$y + dir_y
  agents$y <- (agents$y - 1) %% world_height + 1
  
  return (agents)
}

# Agenten kommunizieren lassen
agentsChat <- function(agents) {
  
  informants <- agents[agents$state == TRUE,]
  
  agents$state = 
    (agents$x %in% informants$x) & 
    (agents$y %in% informants$y)
  
  return (agents)
}


#
# Simulation starten: über die Epochen iterieren ----
#

history <- data.frame()

for (epoch in c(1 : world_epochs)) {
  
  print(epoch)  
  
  # Aktionen ausführen
  agents <- agentsMove(agents)
  agents <- agentsChat(agents)
  
  
  # Protokollieren
  agents$epoch <- epoch
  history <- rbind(history, agents)
  
}


#
# Ergebnisse analysieren ---- 
#

# Diffusion pro Epoche
trace <- history %>% 
  group_by(epoch) %>% 
  summarise(diffusion = mean(state)) %>% 
  ungroup()

# Traceplot 
trace %>% 
  ggplot(aes(epoch, diffusion)) +
  geom_line(color = "maroon")


