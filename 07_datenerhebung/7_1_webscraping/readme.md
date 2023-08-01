# Webscraping

Mithilfe von Webscraping könen Inhalte von Webseiten ausgelesen werden. Eine Einführung in Webscraping findet sich in Kapitel 7.1 im Lehrbuch. Den größten Lerneffekt erzielen Sie dabei, wenn Sie selbst direkt Daten über Webscraping miterheben. Zum Einstieg lohnt sich zunächst ein Blick in das Kapitel 5, in welchem in die Programmierung mit Python oder R eingeführt wird. Sie können sich für eine Programmiersprache entscheiden und nachfolgend die entsprechenden Skripte auswählen, um die Erhebungsschritte beim Webscraping bzw- Webcrawling mitgehen zu können.

## Dateien in diesem Ordner
- Für klassisches Webscraping (Kapitel 7.1.1) das Python-Skript **[webscraping.py](webscraping.py)**  sowie das Pendant für R **[webscraping.R](webscraping.R)**.
- Für Webscraping mittels Browserautomatisierung (Kapitel 7.1.2) das Python-Skript **[webcrawling_selenium.py](webcrawling_selenium.py)**  sowie das R-Skript **[webcrawling_selenium.R](webcrawling_selenium.R)**.

Wenn Sie Python über Jupyter Notebooks nutzen, können Sie für eine schrittweise Ausführung der Skripte die im Kapitel beschriebenen Codeblöcke nacheinander in die Zellen des Jupyter Notebooks kopieren. Alternativ können Sie diese Befehle aus den Python-Skripten kopieren.

*Hinweis:* Webseiten verändern sich von Zeit zu Zeit. Deswegen kann es sein,
dass die Beispiele in den Skripten nicht mehr im ersten Anlauf funktionieren und es zu Fehlermeldungen kommt, beispielsweise wenn Elemente nicht gefunden werden. Sollten Sie  irgendwo festhängen, versuchen Sie den jeweiligen Schritt nachzuvollziehen und selbst anzupassen.

## Techniken zum Boilerplate Removal

Beim Boilerplate Removal besteht das Ziel darin, die Inhalte vom Layout zu trennen. Dabei lassen sich grob drei Ansätze unterscheiden:

- Textbasiert: der Text wird aus allen Elementen ausgelesen, z.B. mit der Funktion `getText()` von BeautifulSoup.
- Elementbasiert: mit Heuristiken werden HTML-Elemente (wie z.B. `nav`) aussortiert und größere zusammenhängende Textblöcken innerhalb des Quelltextes identifiziert.
- Grafisch: die Webseite wird gerendered, um optisch zusammenhängede Bereiche zu identifizieren.

Die Techniken entwickeln sich stets weiter. Wenn Sie Boilerplate Removal benötigen, lohnt sich eine kurze Recherche nach Beiträgen, in denen verschiedene Verfahren verglichen werden (benchmarks). Beispiele für entsprechende Packages sind:

- Boilerpipe: https://github.com/misja/python-boilerpipe
- Trafilature: https://github.com/adbar/trafilatura
- Newspaper: https://github.com/codelucas/newspaper
- Apache Tika: https://tika.apache.org/
- jusText: https://corpus.tools/wiki/Justext

## Installieren des GeckoDriver für Webscraping mit Selenium

Als Schnittstelle zwischen Selenium und dem Browser wird der GeckoDriver verwendet. Gecko ist eine Software, auf die eine Reihe von Webbrowsern aufbauen, vor allem Firefox. Der GeckoDriver erlaubt den Zugriff auf Gecko-basierte Browser durch andere Programme. Laden Sie die neueste Version passend zu Ihrem Betriebssystem aus dem GitHub-Repositorium herunter: https://github.com/mozilla/geckodriver/releases. Die zip-Datei enthält nur eine einzige Datei, die Sie direkt in den Ordner legen, in dem Sie das Python-Skript entwickeln.

Unter Windows verwenden Sie die Datei mit der Endung ".exe". Unter MacOS können Sie den Treiber alternativ über die Konsole installieren. Dazu installieren Sie zunächst Homebrew (https://brew.sh/) und führen dann aus: `brew install geckodriver`.

Wichtig ist in jedem Fall, dass die Version des Browsers und des Treibers zusammenpassen. Auf den Downloadseiten des Webdrivers ist angegeben, zu welcher Browserversion der Treiber jeweils passt. Sollte die im Folgenden beschriebene Automatisierung nicht klappen – der Browser startet zum Beispiel nicht oder Befehle funktionieren nicht – dann prüfen Sie die Versionen und installieren Sie ggf. neuere oder auch ältere Browser und Webdriver.

Wenn Sie den Driver auf diese Weise manuell heruntergeladen haben, kann er in einem Python-Skript wie folgt verwendet werden:

```
from selenium import webdriver

browser = webdriver.Firefox(executable_path=r"geckodriver.exe")

browser.get("https://www.google.de/")
```
