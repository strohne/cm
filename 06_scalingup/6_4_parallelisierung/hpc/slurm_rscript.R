#
# Beispiel für die Parallelisierung auf einem Cluster.
# Im Beispiel wird die Kosinusähnlichkeit von Texten berechnet.
#
# Dieses Skript führt die Berechnung aus.
#


#
# Packages laden ----
#

# Falls die Packages auf dem Cluster nicht im Standardordner liegen,
# kann über folgenden Befehl der Package-Ordner angegeben werden
.libPaths( c("~/RockerRlibs", .libPaths()) )

library(tidyverse)
library(stringr)
library(quanteda)
library(quanteda.textstats)
library(tictoc)


#
# Texte einlesen ----
#

# Passen Sie den Pfad an die Bedingungen auf dem Cluster an
dfm <- read_rds("/scratch/data/usenews.mediacloud.wm.2020.full.rds")


#
# Chunk bestimmen ----
#


# Task-ID aus den Umgebungsvariablen auslesen
task_id <- as.numeric(Sys.getenv('SLURM_ARRAY_TASK_ID'))

if (is.na(task_id)) {  
  task_id <- 0 
  }
print(paste0("Task ID is ",task_id))

# Jedes Chunk umfasst 1000 Zeilen
chunk_start <- (task_id * 1000) + 1
chunk_end <- chunk_start + 1000 - 1
chunk_end <- min(chunk_end,nrow(dfm))

chunk <- c(chunk_start:chunk_end)

print(paste0("Processing rows ",chunk_start," to ",chunk_end," out of ",nrow(dfm)," rows."))


#
# Berechnung für das Chunk ausführen ----
#

tic()
sim <- textstat_simil(
  dfm, 
  dfm[chunk,],
  margin="documents",
  method="cosine", 
  min_simil = 0.9
) %>% as_tibble()

toc()

#
# Teilergebnis abspeichern ----
#

job_name <-Sys.getenv('SLURM_JOB_NAME')
job_id <- Sys.getenv('SLURM_JOB_ID')
filename <- paste0(job_name,"_",str_pad(task_id,8,pad="0"),"_",job_id,".rds")

# Passen Sie den Pfad an die Bedingungen auf dem Cluster an
write_rds(sim,paste0("/scratch/output/",filename))

