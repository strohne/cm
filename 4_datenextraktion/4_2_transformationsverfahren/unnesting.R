# Libraries
library(tidyverse)

# Read data
tweets <- read_csv2("example-twitter.csv")
print(tweets)

# Hashtags (vertikal) entschachteln (separate_rows)
hashtags.unnested <- tweets %>% 
  separate_rows(hashtags,sep=";")

print(hashtags.unnested)


# Hashtags (vertikal) verschachteln (summarize mit paste0)
hashtags.nested <- hashtags.unnested %>% 
  group_by(id) %>% 
  summarize(hashtags = paste0(hashtags,collapse=";")) %>% 
  ungroup()

print(hashtags.nested)
