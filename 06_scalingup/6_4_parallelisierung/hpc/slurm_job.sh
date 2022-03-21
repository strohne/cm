#!/bin/bash

#SBATCH --job-name=sim        # Name des Jobs
#SBATCH --array=0-99          # 100 Tasks
#SBATCH --cpus-per-task=1     # 1 Cores je Task
#SBATCH --mem-per-cpu 32G     # 32GB Ram je Task
#SBATCH --partition=normal    # Berechnung auf der Partition "normal" - an das Cluster anzupassen
#SBATCH --time 00:60:00       # Maximale Laufzeit (hh:mm:ss)
#SBATCH --oversubscribe       # Verteilt Array-Jobs auf die Knoten

#SBATCH --mail-type=ALL                 # Benachrichtigungen per E-Mail
#SBATCH --mail-user=mail@example.com    # Hier die eigene E-Mailadresse angeben

## Output inkl. Fehlermeldungen abspeichern - an das Cluster anzupassen
#SBATCH --output=/scratch/tmp/jjuenge2/stdout/slurm_%A_%a.out  # stdout file name (%j: job ID)


## Jobname ausgeben
echo "Job name: $SLURM_JOB_NAME \n"

## Singularity laden, um einen Container mit R zu starten.
## Der Container muss vorher auf dem Cluster eingerichtet werden.
module load Singularity 

## R-Skript innerhalb des Containers RockerSingularity aufrufen
# Im Beispiel wird über --bind ein Ordner des Clusters im Container
# verfügbar gemacht - an das Cluster anzupassen.
singularity exec --bind $WORK:/scratch:rw ~/RockerSingularity/tidyverse_latest.sif Rscript ~/scripts/slurm_rscript.R

