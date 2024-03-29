<img src="chapter_11_zentangle.png" width="150" alt="Abbildung für Kapitel 11" align="right">

# Computersimulationen

Mit Computersimulationen kann man künstliche Welten erzeugen. Dabei lassen sich gezielt einzelne Faktoren manipulieren,
um unterschiedliche Szenarien zu vergleichen. Die Skripte enthalten ein einfaches Diffusionsmodell, mit dem etwa
die Verbreitung von Desinformationen oder politischen Meinungen simuliert werden kann.

![The diffusion model](diffusion.gif) ![The trace plot](trace.gif)


## Übersicht über Daten und Skripte:
- **[simulation.Rproj](simulation.Rproj)**: R-Projektdatei für das Beispiel
- **[1_simulation_basic.R](1_simulation_basic.R)**: R-Skript mit den Befehlen aus dem Lehrbuch, um eine künstliche Welt aufzubauen
- **[2_simulation_modul.R](2_simulation_modul.R)**: Modularisierte Version des Skripts 1_simulation_basic.R mit zusätzlichen Funktionen - beispielsweise zur Animation der Simulation
- **[diffusion.gif](diffusion.gif)**: Animation von Agenten, die sich in einer künstlichen Welt bewegen
- **[trace.gif](trace.gif)**: Animation eines Traceplots der Diffusionsrate
