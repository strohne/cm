#
# Packages ----
#

library(tidyverse)

# Read data
tweets <- read_csv2("example-twitter.csv")

# Hashtags entschachteln
hashtags <- tweets %>% 
  separate_rows(hashtags,sep=";")


hashtags %>% 
  group_by()
