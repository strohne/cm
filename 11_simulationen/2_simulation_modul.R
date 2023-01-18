#
# Modularisiertes Skript zur Simulation künstlicher Welten
#

#
# Packages ----
#

library(tidyverse)
library(gifski)
library(gganimate)
theme_set(theme_bw())


#
# 1. Simulationsfunktionen ----
#

# Datensatz mit Agenten erstellen 
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


# Agenten bewegen 
agentsMove <- function(agents) {
  
  # Zufällig zwischen -25 und +25 Grad rotieren
  rotate <- sample(c(-25:25),nrow(agents), replace=T)
  
  agents$dir <- agents$dir + rotate
  agents$dir <- agents$dir %% 360
  
  # Horizontal bewegen 
  dir_x = round(sin(deg2rad(agents$dir)))
  agents$x <-  agents$x - dir_x
  agents$x <- (agents$x - 1) %% world_width + 1
  
  # Vertikal bewegen 
  dir_y = round(cos(deg2rad(agents$dir)))
  agents$y <-  agents$y + dir_y
  agents$y <- (agents$y - 1) %% world_height + 1
  
  return (agents)
}

# Informationen verbreiten
agentsChat <- function(agents) {
  
  informants <- agents[agents$state == TRUE,]
  agents$state = (agents$x %in% informants$x) & (agents$y %in% informants$y)
  
  return (agents)
}


# Protokollieren des aktuellen Zustands
worldLog <- function(history, agents, epoch) {
  
  agents$epoch <- epoch
  history <- rbind(history,agents)
  
  return (history)
} 


# Diffusionsrate berechnen 
worldStats <- function(agents) {
  diffusion <- mean(agents$state)
  return (diffusion)
}

# Grafik erstellen 
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

# Traceplot für die Diffusionsrate erstellen 
historyTracePlot <- function(history) {
  
  trace <- history %>% 
    group_by(epoch) %>% 
    summarise(diffusion = mean(state)) %>% 
    ungroup()
  
  pl <- trace %>% 
    ggplot(aes(epoch,diffusion)) +
    geom_line(color="maroon")
  
  return (pl)
}

historyTraceAnimate <- function(history, secs) {

  trace <- history %>% 
    group_by(epoch) %>% 
    summarise(diffusion = mean(state)) %>% 
    ungroup()
  
  pl <- trace %>% 
    ggplot(aes(epoch,diffusion)) +
    geom_line(color="maroon") +
    geom_point() +
    transition_reveal(epoch)
  
  pl <- animate(pl,nframes=n_distinct(history$epoch),duration=secs)
  
  pl
}


# Animation der Welt erstellen 
historyWorldAnimate <- function(history, secs) {
  
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


# Hilfsfunktion zur Umrechnung von Grad in Bogenmaß
deg2rad <- function(deg) {
  return ((deg * pi) / 180)
}


#
# 2. Welt erstellen  ----
#

# Rahmenbedingungen festlegen 
world_width <- 50
world_height <- 50
world_epochs <- 100
world_agents <- 100

history <- data.frame()

# Agenten erzeugen 
set.seed(1852)
agents <- agentsSpawn(world_agents)
agents$state[1] <-  TRUE


# Startbedingungen ausgeben
worldStats(agents)
worldPlot(agents)


#
# 3. Welt ablaufen lassen ----
#

for (epoch in c(1:world_epochs)) {

  print(epoch)
  print(worldStats(agents))
  
  
  agents <- agentsMove(agents)
  agents <- agentsChat(agents)
  
  history <- worldLog(history, agents, epoch)

}

#
# 4. Welt analysieren ----
#

# Letzter Zustand
worldStats(agents)
worldPlot(agents)

# Traceplot
historyTracePlot(history)

historyTraceAnimate(history,10)
anim_save("trace.gif")


# Animation über die Epochen
historyWorldAnimate(history,10)
anim_save("diffusion.gif")
