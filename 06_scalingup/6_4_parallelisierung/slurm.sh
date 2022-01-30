#
# Beispiel für eine Session, um ein R-Skript auf
# einem HPC zu verteilen und die Ergebnisse einzusammeln.
#
# Selbst wenn Sie dieses Skript nicht selbst ausführen,
# können Sie sich durch das Lesen ein Grundverstäntnis erarbeiten.
# Ein wesentlicher Aspekt bei der Arbeit mit einem HPC sollte schnell 
# deutlich werden: Sie tauchen in immer tiefere Ebenen des Systems ein
# und auch immer wieder auf.
#
#
# Mit diesem Skript 
# - Loggen Sie sich auf dem Cluster ein,
# - richten einen Singularity-Container mit R ein,
# - übertragen die relevanten Daten,
# - submitten mit SLURM das Skript slurm_jobt.sh,
# - welches das R-Skript slurm_rscript.R aufruft,
# - und sammeln die Ergebnisse ein.
# 
# Um das Beispiel tatsächlich praktisch nachvollziehen zu können,
# müssen die Befehle an die Bedingungen auf dem Cluster
# angepasst werden. Der grundlegende Ablauf sollte aber
# auf vielen Systemen funktionieren.
#
# - Starten Sie R-Studio
# - Öffnen Sie dieses Skript
# - Öffnen Sie in RStudio das Terminal
# - Schicken Sie die Befehle Schritt für Schritt
#   mit der Tastenkombination Strg+Enter bzw. Command+Enter
#   zum Cluster.
#
# Achten Sie darauf, in den Befehlen folgende Angaben zu ersetzen:
# - "username" durch den eigenen Nutzer:innennamen
# - "hpc.meineuni.de" durch die Adresse des HPC
# - "id_rsa_hpc" durch den Namen Ihres SSH-Schlüssels
#    Der SSH-Schlüssel wird im Beispiel zum Login auf dem HPC verwendet.
#    Die Befehle müssen ggf. an das Authentifizierungsverfahren des konkreten
#    HPC angepasst werden.



#
# 1. Vorbereitung des Clusters ----
#

# Vorbereitungen:
# - SSH-Schlüssel id_rsa_hpc erzeugen und im IT-Portal hinterlegen
# - Erstmals auf Kommandozeile (geht nicht im R-Terminal) einloggen,
#   um den Fingerprint des Servers zur knownhosts hinzuzufügen.

# Login to the cluster
ssh -i ~/.ssh/id_rsa_hpc username@hpc.meineuni.de


# Singularity laden und einen R-Container holen.
# Unsere Skripte laufen innerhalb des Containers auf dem Cluster.
# Der Container landet vom Cluster aus gesehen unter ~/RockerSingularity
module load Singularity 
mkdir ~/RockerSingularity
mkdir ~/RockerRlibs

cd ~/RockerSingularity
singularity pull docker://rocker/tidyverse

# Eine Shell im Singularity Container starten
singularity shell ~/RockerSingularity/tidyverse_latest.sif

# ...darin R starten
R

# R-Packages im Nutzerverzeichnis installieren. 
# 
# Die Packages landen vom Cluster aus gesehen unter ~/RockerRlibs
# In unseren Skripten müssen wir mit libPaths angeben, dass Packages
# dort installiert und von dort geladen werden sollen.
.libPaths( c("~/RockerRlibs", .libPaths()) )

install.packages("tidyverse")
install.packages("Matrix")
install.packages("doFuture")
install.packages("progressr")
install.packages("readr")
install.packages("tictoc")
install.packages("quanteda")
install.packages("quanteda.textstats")

# R verlassen, jetzt sind wir wieder in der Singularity Shell
quit()

# Singularity verlassen, jetzt sind wir wieder auf der SSH Shell
exit

# SSH verlassen, jetzt sind wir wieder zu Hause
exit

#
# 2. Daten vorbereiten ----
#


# Login to the cluster
ssh -i ~/.ssh/id_rsa_hpc username@hpc.meineuni.de


# Singularity laden
module load Singularity


# Open interactive shell on compute node
srun --mem=32G  --pty bash
singularity shell --bind $WORK:/scratch:rw ~/RockerSingularity/tidyverse_latest.sif


# Datensatz herunterladen
cd /scratch/data
wget -O usenews.mediacloud.wm.2020.rds https://osf.io/u47k3/download
ls -l


# Go into R and prepare data
R
.libPaths( c("~/RockerRlibs", .libPaths()) )
library(tidyverse)
library(quanteda)
library(quanteda.textstats)

dfm <- read_rds('usenews.mediacloud.wm.2020.rds')
dfm <- do.call(rbind,dfm)

#~ 1,187,066 docs, 4,536,988 features
dfm

# Save data
write_rds(dfm,"usenews.mediacloud.wm.2020.full.rds",compress="gz")


# Exit R, singularity, compute node und Cluster.
# Anschließend sind Sie wieder zu Hause.
quit()
exit
exit
exit

#
# 3. Skripte übertragen ---- 
#

# Das Cluster muss dazu die Übertragung per SCP unterstützen
scp -i ~/.ssh/id_rsa_hpc slurm_rscript.R username@hpc.meineuni.de:~/scripts/slurm_rscript.R
scp -i ~/.ssh/id_rsa_hpc slurm_job.sh username@hpc.meineuni.de:~/scripts/slurm_job.sh



#
# 4. Job submitten ----
#

# Login to the cluster
ssh -i ~/.ssh/id_rsa_hpc username@hpc.meineuni.de


# In das Projektverzeichnis wechseln
cd ~/scripts/

# Singularity laden
module load Singularity

# Status abfragen...wie viele Knoten sind auf der normal-Partition frei?
sinfo -p normal

# Script submitten mit 594 Tasks submitten
sbatch --partition normal --array=0-593 ~/scripts/slurm_job.sh

# Status abfragen
squeue -u username


# Falls ein Job abgebrochen werden soll, 
# scancel mit der Jobnummer aufrufen
#scancel 189607

#
# 5. Daten einsammeln ----
#

# Zunächst muss die Berechnung abgeschlossen sein,
# das heißt die Warteschlange (squeue) ist leer


# Login to the cluster
ssh -i ~/.ssh/id_rsa_hpc username@hpc.meineuni.de


# Singularity laden
module load Singularity


# In Output und ggf. Fehler reinschauen
cd $WORK/stdout
ls
cat eindateinamemitderendung.out

cd $WORK/output
ls

# Open interactive shell on compute node
srun --mem=92G  --pty bash
singularity shell --bind $WORK:/scratch:rw ~/RockerSingularity/tidyverse_latest.sif

# Go into R and gather data
R
.libPaths( c("~/RockerRlibs", .libPaths()) )
library(tidyverse)
library(quanteda)
library(quanteda.textstats)

path <- "/scratch/output/"
files <- dir(path, pattern = "sim_.*\\.rds")
files

data <- map_dfr(files,~readRDS(file.path(path,.)), .id="file")
count(data, file)

# Ergebnis zwischendurch abspeichern
write_rds(data,file.path(path,"sim.rds"),compress="gz")


# Dokumentvariablen hinzufügen
sim <- read_rds("/scratch/output/sim.rds")
dfm <- read_rds("/scratch/data/usenews.mediacloud.wm.2020.full.rds")


# Get data frame with document variables
docs <- tibble(docname=docnames(dfm),docvars(dfm))

# Titel, URL und Datum an die Liste ähnlicher Dokumente joinen
sim_docs <- sim %>% 
  
  # Join variabls for document 1
  left_join(
    select(
      docs,
      document1=docname,
      doc1_title=title,
      doc1_url=url,
      doc1_date=publish_date
    ), by="document1"
  ) %>%
  
  # Join variabls for document 1
  left_join(
    select(
      docs,
      document2=docname,
      doc2_title=title,
      doc2_url=url,
      doc2_date=publish_date
    ), by="document2"
  )

# Ergebnis abspeichern
write_rds(sim_docs,file.path(path,"sim.rds"),compress="gz")


# Exit R
quit()


# Exit singularity
exit

# Delete chunks (remove # if the file list is ok)
cd $WORK/output
find . -name 'sim_*.rds' #-delete
ls

# Exit compute node
exit

# Exit cluster
exit

# Ergebnisdatei vom Cluster auf den eigenene Computer übertragen
scp -i ~/.ssh/id_rsa_hpc username@hpc.meineuni.de:/scratch/tmp/username/output/sim.rds data/sim_full.rds

