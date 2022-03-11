#
# Simulation of an artificial world
#

#
# Packages ----
#
library(tidyverse)

#
# 1. Setup world ----
#

# Initialize global variables
world_width <- 50
world_height <- 50
world_epochs <- 100
world_agents <- 100


# Create tibble and place agent into world
agents <- tibble(    
  no  = c(1:world_agents),    
  x   = sample(world_width, world_agents ,replace=T),
  y   = sample(world_height, world_agents, replace=T),
  dir = sample(360, world_agents,replace=T) - 1,
  state = FALSE
)

# Set state of first agent to true
agents$state[1] <-  TRUE

# Create tibble for history
history <- data.frame()


#
# 2. Functions for the actions in each epoch ----
#

# Move agent
agentsMove <- function(agents) {
  
  # Rotate between -25 and +25 degrees
  rotate <- sample(c(-25:25),world_agents,replace=T)
  
  agents$dir <- agents$dir + rotate
  agents$dir <- agents$dir %% 360
  
  # Move horizontally
  dir_x = round(sin((agents$dir * pi) / 180))
  agents$x <- agents$x - dir_x
  agents$x <- (agents$x - 1) %% world_width + 1
  
  # Move vertically
  dir_y = round(cos((agents$dir * pi) / 180))
  agents$y <- agents$y + dir_y
  agents$y <- (agents$y - 1) %% world_height + 1
  
  return (agents)
}

# Let agents chat
agentsChat <- function(agents) {
  
  informants <- agents[agents$state == TRUE,]
  
  agents$state = 
    (agents$x %in% informants$x) & 
    (agents$y %in% informants$y)
  
  return (agents)
}


#
# Start simulation: Iterate over epochs ---
#

history <- data.frame()

for (epoch in c(1:world_epochs)) {
  
  print(epoch)  
  
  # Aktionen ausführen
  agents <- agentsMove(agents)
  agents <- agentsChat(agents)
  
  
  # Protokollieren
  agents$epoch <- epoch
  history <- rbind(history, agents)
  
}


#
# Analyze results ---- 
#

# Diffusion per epoch
trace <- history %>% 
  group_by(epoch) %>% 
  summarise(diffusion = mean(state)) %>% 
  ungroup()

# Trace plot with diffusion 
trace %>% 
  ggplot(aes(epoch, diffusion)) +
  geom_line(color="maroon")



