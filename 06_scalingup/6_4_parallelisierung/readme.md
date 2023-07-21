# Beispiele für die Parallelisierung

## Ordner multicore: Beispiel für die Parallelisierung auf mehreren Prozessorkernen

- **multicore.R**: Beispiel für die Parallelisierung auf dem eigenen Computer.
- **usenews_small.rds**: Ein kleiner Auszug aus dem UseNews-Datensatz, nur zu Übungszwecken geeignet. Die Übungsdaten enthalten eine Zufallsauswahl von 10.000 bereinigten Texten aus dem Jahr 2020. Vollständiger Datensatz: https://osf.io/uzca3/

## Ordner hpc: Beispiel für die Arbeit auf einem High Performance Cluster

- **slurm.sh**: Beispiel für eine Session, um R auf einem HPC zu verwenden. Wenn Sie ein HPC zur Verfügung haben, folgen Sie den angegebenen Schritten.
- **slurm_rscript.R**: Das in der Beispielsession verwendete R-Skript
- **slurm_job.sh**: Der in der Beispielsession verwendete SLURM-Job
- **usenews_small.rds**: Auszug aus dem UseNews-Datensatz (siehe oben).


# Beispiel für ein Dashboard

- Öffnen Sie das R-Projekt shiny.RPproj mit RStudio
- Öffnen Sie dann das Skript app.R und klicken Sie auf "Run app"
- Datenquelle: https://doi.org/10.1177/0894439320979675

