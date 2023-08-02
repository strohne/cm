# Datenselektion
Daten liegen selten fertig aufpoliert vor, sie müssen zunächst aus unstrukturierten Datenquellen gewonnen, für Analysen speziell zugeschnitten oder 
um irrelevante Informationen bereinigt werden. Für die Aufbereitung von Daten gibt es je nach Datengrundlage verschiedene Extraktions- und Transformationsverfahren (Kapitel 4.1). 
In diesem Repositorium finden Sie Beispiele, um Daten aus Texten mithilfe von regulären Ausdrücken zu extrahieren (Kapitel 4.1.1), 
mit CSS-Selektoren vorstrukturierte Daten aus HTML-Quellcode zu gewinnen (Kapitel 4.1.2), über XPath Daten aus XML-Dateien herauszuziehen (Kapitel 4.1.3) und 
Datenbanken mit SQL-Befehlen abzufragen (Kapitel 4.1.4).


## Dateien in diesem Ordner
Die folgenden Dateien dienen als Beispielmaterial, um die in Kapitel 4.1.1 besprochenen regulären Ausdrücke einzuüben:

- **example_text.txt** enthält eine Textdatei, die Sie mit einem Texteditor öffnen können, um mit regulären Ausdrücken Suchmuster zu formulieren. Suchen Sie nach: Jahreszahlen, Prozentzahlen, geschützten Leerzeichen!
- **example_li.html** enthält HTML-Quelltext für eine Liste von Serien mit dem Anfangsbuchstaben N.  (Quelle: https://www.fernsehserien.de/serien-a-z/n; 2.2.2020)  
- **example_table.html** enthält eine HTML-Tabelle mit den längsten Fernsehserien. (Quelle: https://de.wikipedia.org/wiki/Liste_der_l%C3%A4ngsten_Fernsehserien; 2.2.2020).
- **golem.har enthält** eine Liste aller Abfragen, die beim Aufruf von golem.de ausgeführt werden (aufgerufen am 26.11.2019). Stellen Sie die unterschiedlichen Domains zusammen und finden Sie so heraus, mit welchen Drittanbietern die Seite verbunden ist! 

Um SQL-Ausdrücke zu üben, können Sie folgende Datei verwenden (Kapitel 4.1.4):
- **imdb.db** ist eine SQLite-Datenbank, sie enthält einen Auszug aus der IMDb mit in Deutschland nach dem Jahr 2000 erschienenen Titeln (Quelle: https://datasets.imdbws.com/; 8.2.2020; nur für den persönlichen akademischen Gebrauch; siehe http://www.imdb.com/interfaces/)  
- **imdb.db.sql** enthält den SQL-Dump der SQLite-Datenbank. Mit einem SQL-Dump lassen sich die Daten in andere Datenbanken übertragen.  

## CSS- und XPath-Ausdrücke mit Facepager üben
- Installieren Sie Facepager: [https://github.com/strohne/Facepager](https://github.com/strohne/Facepager). Eine Einführung und Getting-Started-Tutorials finden Sie im [Wiki](https://github.com/strohne/Facepager/wiki).
- Legen Sie mit Facepager eine neue Datenbank an (Menüpunkt `New Database`).
- Fügen Sie die Adresse einer Webseite als Startknoten ein (Menüpunkt `Add Nodes`). Für das Beispiel sollte die Seite li-Elemente enthalten, wie etwa 'https://www.fernsehserien.de/serien-a-z/n'. Alternativ können Sie auch die abgespeicherte Datei der Webseite einlesen, diese liegt im Repositorium unter 'https://github.com/strohne/cm/raw/master/4_datenextraktion/4_1_selektionsverfahren/example_li.html'. Dafür wählen Sie über den Menüpunkt `Add Nodes` und anschließend `Add Files` die heruntergeladene Datei aus. Nachdem Sie mit `Ok` bestätigt haben, sollte der Pfad der Datei in der Nodes-View erscheinen.  
- Wechseln Sie unten links in das Generic-Modul und leeren Sie dort soweit möglich alle Einstellungen. Setzen Sie dann das Feld Base path auf `<Object ID>` und das Response-Format auf `text`. Setzen Sie das Feld Key to extract auf `text|css:li`. Damit werden aus dem Quelltext der Seite (der bei Facepager im text-Schlüssel landet) im nächsten Schritt alle li-Elemente extrahiert. 
- Mit der Schaltfläche `Fetch Data` wird die Seite heruntergeladen bzw. die eingelesene Datei geparsed. Das Ergebnis landet in neuen Unterknoten. Klappen Sie den Startknoten auf und  wählen Sie einen neuen Unterknoten aus. Im rechten Bereich sehen Sie die Daten, der Inhalt des Knotens (in diesem Fall das li-Element) ist im Schlüssel `text` zu finden. Verweilen Sie kurz mit der Maus über dem text-Eintrag oder kopieren Sie ihn in einen Texteditor, um sich das Ergebnis anzusehen.
- Um Daten aus dem Quelltext der Seite zu extrahieren, passen Sie die Spalten der Datentabelle an. Geben Sie die gewünschten Ausdrücke in das Feld Custom Table Columns ein und klicken Sie `Apply Column Setup`:
  - Wenn Sie das Präfix `text|css:` verwenden, können Sie dahinter *CSS-Ausdrücke* angeben. Geben Sie zum Beispiel `text|css:span.bold` ein, um die Titel der Serien auszulesen. 
  - Mit *XPath-Ausdrücken* können Sie außerdem bestimmen, dass nur der Text oder nur ein Attributwert angezeigt werden soll. Setzen Sie den XPath-Ausdruck hinter das Präfix `text|xpath:`. Zum Beispiel erhalten Sie mit dem Ausdruck `text|xpath://a/@href` die Links, genauer das href-Attribut aller a-Elemente. Der Ausdruck `text|xpath://a/text()` gibt den Linktext im a-Element zurück. Wenn weitere Elemente in das a-Element verschachtelt sind, hilft der Ausdruck `text|xpath:string(//a)` weiter.
- Um die richtigen Ausdrücke zu finden, können Sie sich die ursprüngliche Seite im Browser ansehen und mit der Entwicklerkonsole (F12) einzelne Elemente des Quelltextes untersuchen.

## SQL mit DB Browser for SQLite üben
- Installieren Sie DB Browser for SQLite: https://sqlitebrowser.org/
- Öffnen Sie die Datenbank example_imdb.db
- Wechseln Sie in den Reiter "SQL ausführen"
- Geben Sie SQL-Befehle ein, zum Beispiel: 

  ```
  SELECT * FROM titles WHERE premiered > 2015 AND genres LIKE '%Western%'
  ```
