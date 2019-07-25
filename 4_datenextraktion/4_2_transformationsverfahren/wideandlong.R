# Libraries
library(tidyverse)

# Read data and rename columns
tweets <- read_csv2("example-twitter.csv")
print(tweets)

# From wide to long (=gather)
tweets.long <- tweets %>% 
  gather(key="variable","value"="value",favorites,replies,retweets)

print(tweets.long)

# From long back to wide (=spread)
tweets.wide <- tweets.long %>% 
  spread(key="variable",value="value",sep="_")

print(tweets.wide)
