# CSS- und XPath-Ausdrücke mit Facepager üben

- Installieren Sie Facepager: [https://github.com/strohne/Facepager](https://github.com/strohne/Facepager). Eine Einführung und Getting started-Tutorials finden Sie im [Wiki](https://github.com/strohne/Facepager/wiki).
- Legen Sie mit Facepager eine neue Datenbank an (Menüpunkt `New Database`).
- Fügen Sie die Adresse einer Webseite als Startknoten ein (Menüpunkt `Add Nodes`), zum Beispiel 'https://www.fernsehserien.de/serien-a-z/n'
- Wechseln Sie unten links in das Generic-Modul und leeren Sie dort soweit möglich alle Einstellungen. Setzen Sie dann das Feld Base path auf `<Object ID>` und das Response-Format auf `text`. 
- Setzen Sie das Feld Key to extract auf `text|css:li`. Damit werden aus dem Quelltext der Seite (der bei Facepager im text-Schlüssel landet) im nächsten Schritt alle li-Elemente extrahiert. 
- Mit der Schaltfläche `Fetch Data` wird die Seite heruntergeladen. Das Ergebnis landet in neuen Unterknoten. Klappen Sie den Startknoten auf und  wählen Sie einen neuen Unterknoten aus. Im rechten Bereich sehen Sie die Daten, der Inhalt des Knotens (in diesem Fall das li-Element) ist im Schlüssel `text` zu finden. Verweilen Sie mkurz mit der MAus über dem text-Eintrag oder kopieren Sie ihn in einen Texteditor, um sich das Ergebnis anzusehen.
- Um Daten aus dem Quelltext der Seite zu extrahieren, passen Sie die Spalten der Datentabelle an. Geben Sie die gewünschten Ausdrücke in das Feld Custom Table Columns ein und klicken Sie `Apply Column Setup`.
- Wenn Sie das Präfix `text|css:` verwenden, können Sie dahinter CSS-Ausdrücke angeben, zum Beispiel `text|css:span.bold` um den Titel der Serie auszulesen. 
- Mit XPath-Ausdrücken können Sie außerdem, bestimmen, dass nur der Text oder nur ein Attributwert angezeigt werden soll. Setzen Sie den XPath-Ausdruck hinter das Präfix `text|xpath:`. Zum Beispiel erhalten Sie mit dem Ausdruck `text|xpath://a/@href` die Links, genauer das href-Attribut aller a-Elemente. 
- Um die richtigen Ausdrücke zu finden, können Sie sich die ursprüngliche Seite im Browser ansehen und mit der Entwicklerkonsole (F12) einzelne Elemente des Quelltextes untersuchen.