#
# Packages ----
#

library(tidyverse)
library(gifski)
library(gganimate)
theme_set(theme_bw())


#
# 1. Simulation functions ----
#



# Create dataset with agents
agentsSpawn <- function(agents_count) {
  agents <- tibble(
    
    no =  c(1:agents_count),
    
    x =   sample(world_width, agents_count, replace=T),
    y =   sample(world_height, agents_count,replace=T),
    dir = sample(360,agents_count,replace=T) - 1,
    state = FALSE
  )
  
  return (agents)
}


# Move agents
agentsMove <- function(agents) {
  
  # Rotate between 1 and 15 degrees
  rotate <- sample(c(-25:25),nrow(agents), replace=T)
  
  agents$dir <- agents$dir + rotate
  agents$dir <- agents$dir %% 360
  
  # Move horizontally
  dir_x = round(sin(deg2rad(agents$dir)))
  agents$x <-  agents$x - dir_x
  agents$x <- (agents$x - 1) %% world_width + 1
  
  # Move vertically
  dir_y = round(cos(deg2rad(agents$dir)))
  agents$y <-  agents$y + dir_y
  agents$y <- (agents$y - 1) %% world_height + 1
  
  return (agents)
}

# Disseminate information
agentsChat <- function(agents) {
  
  informants <- agents[agents$state == TRUE,]
  agents$state = (agents$x %in% informants$x) & (agents$y %in% informants$y)
  
  return (agents)
}


# Log the current state
worldLog <- function(history, agents, epoch) {
  
  agents$epoch <- epoch
  history <- rbind(history,agents)
  
  return (history)
} 


# Calculate diffusion reate
worldStats <- function(agents) {
  diffusion <- mean(agents$state)
  return (diffusion)
}

# Plot agents
worldPlot <- function(agents) {
  
  pl <- agents %>% 
    ggplot(aes(x,y,angle=dir,color=state)) +
    
    
    geom_text(label="⮝",alpha=0.8, size=10,vjust=0.5,hjust=0.5)+
    geom_text(aes(label=no, angle = dir),color="black",size=2, hjust=0.5,vjust=0.7) +
    
    scale_color_manual(breaks=c(F,T),, values=c("grey","maroon")) +
    scale_x_continuous(limits = c(1,world_width), name = NULL) +
    scale_y_continuous(limits = c(1,world_height), name= NULL) +
    
    coord_fixed()

  return(pl)
}

# Plot the diffusion rate over time
historyTrace <- function(history) {
  
  trace <- history %>% 
    group_by(epoch) %>% 
    summarise(diffusion = mean(state)) %>% 
    ungroup()
  
  pl <- trace %>% 
    ggplot(aes(epoch,diffusion)) +
    geom_line(color="red")
  
  return (pl)
}

# Create an animation of the world
historyAnimate <- function(history, secs) {
  
  pl <- history %>% 
    ggplot(aes(x,y,angle=dir,color=state,group=no)) +
    
    
    geom_text(label="⮝",alpha=0.8, size=10,vjust=0.5,hjust=0.5)+
    geom_text(aes(label=no, angle = dir),color="black",size=2, hjust=0.5,vjust=0.7) +
    
    scale_color_manual(breaks=c(F,T),values=c("grey","maroon")) +
    scale_x_continuous(limits = c(1,world_width), name = NULL) +
    scale_y_continuous(limits = c(1,world_height), name= NULL) +
    
    coord_fixed() +
    
    transition_time(epoch) +  
    ggtitle('Epoch {frame} of {nframes}')
  
  pl <- animate(pl,nframes=n_distinct(history$epoch),duration=secs)
  return (pl)
  
}


# Helper function to convert degree to radians
deg2rad <- function(deg) {
  return ((deg * pi) / 180)
}



#
# 2. Create a world ----
#

# Initialize global variables
world_width <- 50
world_height <- 50
world_epochs <- 100
world_agents <- 100

history <- data.frame()

# Initialize agents 
set.seed(1852)
agents <- agentsSpawn(world_agents)
agents$state[1] <-  TRUE


# Starting conditions
worldStats(agents)
worldPlot(agents)


#
# 3. Move world ----
#

for (epoch in c(1:world_epochs)) {

  print(epoch)
  print(worldStats(agents))
  
  
  agents <- agentsMove(agents)
  agents <- agentsChat(agents)
  
  history <- worldLog(history, agents, epoch)

}

#
# 4. Analyze world ----
#

worldStats(agents)
worldPlot(agents)

historyTrace(history)
historyAnimate(history,10)

anim_save("diffusion.gif")

