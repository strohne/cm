# Datenselektion
Oftmals müssen Daten zunächst aus unstrukturierten Datenquellen gewonnen werden oder Daten für Analysen speziell zugeschnitten oder 
um irrelevante Informationen bereinigt werden. Für ebendiese Selektion von Daten gibt es je nach Datengrundlage unterschiedliche Strategien (Kapitel 4.1). 
In diesem Repositorium finden Sie Beispiele, um Daten aus Texten mithilfe von regulären Ausdrücken zu extrahieren (Kapitel 4.1.1), 
vorstrukturierte Daten in HTML-Quellcode durch CSS-Selektoren zu gewinnen (Kapitel 4.1.2), Daten im XML-Format über XPath herauszuziehen (Kapitel 4.1.3) und 
Datenbanken mit SQL-Befehlen abzufragen (Kapitel 4.1.4).


## Übersicht über Dateien
- **example_text.txt** enthält eine Textdatei, die Sie mit einem Texteditor öffnen können, um darin Suchmuster zu formulieren. Suchen Sie nach: Jahreszahlen, Prozentzahlen, geschützten Leerzeichen!
- **golem.har enthält** eine Liste aller Abfragen, die beim Aufruf von golem.de ausgeführt werden (aufgerufen am 26.11.2019).
- **example_table.html** enthält eine Tabelle mit den längsten Fernsehserien (Quelle: https://de.wikipedia.org/wiki/Liste_der_l%C3%A4ngsten_Fernsehserien; 2.2.2020) 
- **example_li.html** enthält eine Liste von Serien mit dem Anfangsbuchstaben N (Quelle: https://www.fernsehserien.de/serien-a-z/n; 2.2.2020)  
- **example_imdb.db** ist eine SQLite-Datenbank, sie enthält einen Auszug aus der IMDb mit in Deutschland nach dem Jahr 2000 erschienenen Titeln (Quelle: https://datasets.imdbws.com/; 8.2.2020; nur für den persönlichen akademischen Gebrauch; siehe http://www.imdb.com/interfaces/)  


## CSS- und XPath-Ausdrücke mit Facepager üben
- Installieren Sie Facepager: [https://github.com/strohne/Facepager](https://github.com/strohne/Facepager). Eine Einführung und Getting started-Tutorials finden Sie im [Wiki](https://github.com/strohne/Facepager/wiki).
- Legen Sie mit Facepager eine neue Datenbank an (Menüpunkt `New Database`).
- Fügen Sie die Adresse einer Webseite als Startknoten ein (Menüpunkt `Add Nodes`). Für das Beispiel sollte die Seite li-Elemente enthalten, zum Beispiel 'https://www.fernsehserien.de/serien-a-z/n' oder die Beispieldatei 'https://github.com/strohne/cm/raw/master/4_datenextraktion/4_1_selektionsverfahren/example_li.html'.
- Wechseln Sie unten links in das Generic-Modul und leeren Sie dort soweit möglich alle Einstellungen. Setzen Sie dann das Feld Base path auf `<Object ID>` und das Response-Format auf `text`. Setzen Sie das Feld Key to extract auf `text|css:li`. Damit werden aus dem Quelltext der Seite (der bei Facepager im text-Schlüssel landet) im nächsten Schritt alle li-Elemente extrahiert. 
- Mit der Schaltfläche `Fetch Data` wird die Seite heruntergeladen. Das Ergebnis landet in neuen Unterknoten. Klappen Sie den Startknoten auf und  wählen Sie einen neuen Unterknoten aus. Im rechten Bereich sehen Sie die Daten, der Inhalt des Knotens (in diesem Fall das li-Element) ist im Schlüssel `text` zu finden. Verweilen Sie kurz mit der MAus über dem text-Eintrag oder kopieren Sie ihn in einen Texteditor, um sich das Ergebnis anzusehen.
- Um Daten aus dem Quelltext der Seite zu extrahieren, passen Sie die Spalten der Datentabelle an. Geben Sie die gewünschten Ausdrücke in das Feld Custom Table Columns ein und klicken Sie `Apply Column Setup`.
- Wenn Sie das Präfix `text|css:` verwenden, können Sie dahinter *CSS-Ausdrücke* angeben, zum Beispiel `text|css:span.bold` um im Beispiel die Titel der Serien auszulesen. 
- Mit *XPath-Ausdrücken* können Sie außerdem bestimmen, dass nur der Text oder nur ein Attributwert angezeigt werden soll. Setzen Sie den XPath-Ausdruck hinter das Präfix `text|xpath:`. Zum Beispiel erhalten Sie mit dem Ausdruck `text|xpath://a/@href` die Links, genauer das href-Attribut aller a-Elemente. Der Ausdruck `text|xpath://a/text()` gibt den Linktext im a-Element zurück. Wenn weitere Elemente in das a-Element verschachtelt sind, hilft der Ausdruck `text|xpath:string(//a)` weiter.
- Um die richtigen Ausdrücke zu finden, können Sie sich die ursprüngliche Seite im Browser ansehen und mit der Entwicklerkonsole (F12) einzelne Elemente des Quelltextes untersuchen.

# SQL  mit DB Browser for SQLite üben
- Installieren Sie DB Browser for SQLite: https://sqlitebrowser.org/
- Öffnen Sie die Datenbank example_imdb.db
- Wechseln Sie in den Reiter "SQL ausführen"
- Geben Sie SQL-Befehle ein, zum Beispiel: `SELECT * FROM titles WHERE premiered > 2015 AND genres LIKE '%Western%'`
