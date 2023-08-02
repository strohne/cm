# Datenerhebung über die Telegram-API

*Erhebung von Accountbeschreibungen und Nachrichten aus öffentlichen Gruppen und Kanälen auf Telegram*

Die Telegram-API bietet eine Vielzahl an Möglichkeiten, um mit den Inhalten des Messengers Telegrams zu interagieren (https://core.telegram.org/). So könnten Sie einen eigenen Chat-Bot zum Managen von Gruppen entwerfen oder über eine eigens geschriebene Anwendungen Mitteilungen verschicken. Ebenso können darüber Daten erhoben werden, wie beispielsweise die Beschreibungen und Nachrichten von öffentlichen Telegram-Gruppen und -Kanälen.

Nachfolgend finden Sie einen kurzen Einstieg in die Datenerhebung mit der Telegram-API. Am Beispiel des offiziellen Corona-Infokanal des Bundesministeriums für Gesundheit ist beschrieben, wie Sie die Kanalbeschreibung sowie die letzten 100 Mitteilungen samt Medien erheben können.

Um direkt mit der Erhebung loslegen zu können, benötigen Sie:
- Ein Smartphone mit einer Sim-Karte sowie die Telegram-App,  
- eine Jupyter Lab-Installation, da die Datenerhebung nachfolgend mit Python über Jupyter Notebooks geschieht.
- Hilfreich sind erste Kenntnisse in Python.

Beachten Sie außerdem ganz grundsätzlich bei der Datenerhebung über APIS: APIs werden von den Betreibern der Plattformen bereitgestellt.
Das bedeutet zum einen, dass die Plattformen festlegen, wie viele und welche Daten abgefragt werden können und wie diese sortiert werden. Berücksichtigen Sie demnach bei der Erhebung mögliche Ratenbegrenzungen und bei der Interpretation Ihrer wissenschaftlichen Fragestellungen die Datenqualität. Zum anderen kann es sein, dass sich die Zugänge über die Zeit verändern und die nachfolgend beschriebene Vorgehensweise nicht mehr aktuell ist, sobald Sie das lesen.

In beiden Fällen lohnt es sich, in der offiziellen Dokumentation der API nachzusehen. Diese wird im Normalfall aktuell gehalten und liefert detaillierte Hinweise zu den Rahmenbedingungen, den verfügbaren Abfragen und Daten.

 Auch die Python-Packages entwickeln sich weiter, etwa das unten verwendete Pyrogram. Hier lohnt sich ebenfalls ein Blick in die Dokumentation.


## Schritt 1: Registrierung bei Telegram.
Um die Anfragen an die Telegram-API stellen zu können, müssen Sie sich zunächst bei Telegram registiereren.
Dafür loggen Sie sich auf https://my.telegram.org/apps mit Ihrer Telefonnummer ein. Telegram überprüft Ihre Identität, indem Sie in der App eine Mitteilung mit
einem Code zugeschickt bekommen. Geben Sie diesen Code, wenn gefordert, an den entsprechenden Stellen zur Authentifizierung ein. Legen Sie anschließend auf der Webseite eine Desktop-App an (siehe auch https://core.telegram.org/api/obtaining_api_id). Im Anschluss an die Registrierung finden Sie unter https://my.telegram.org/apps Ihre `api_id` sowie Ihren `api_hash`.
Dies sind Ihre persönliche ID sowie Ihr Passwort zur Interaktion mit der Telegram-API.


## Schritt 2: Einrichten von Pyrogram
Einen vereinfachten Zugriff auf die Telegram-API bietet das Framework Pyrogram. Pyrogram stellt Python-Funktionen bereit, über die automatisch Abfragen der Telegram-API zusammengebaut werden - ohne dass Sie sich im Detail mit der Telegram-API auseinandersetzen müssen. Stattdessen sollten Sie sich aber mit der Pyrogram-Dokumentation vertraut machen: https://docs.pyrogram.org/. Schlagen Sie die folgenden Befehle nach, um diese besser zu verstehen.

Starten Sie nun Jupyter-Lab. Für die Installation von Pyrogram führen Sie einmalig im Terminal oder in der Kommandozeile folgenden Befehl aus (je nach Python-Installation geht auch pip statt pip3):

```
pip3 install pyrogram
```

Aktuell ist die Version 1.2.9, aber vermutlich hat sich das bereits weiterentwickelt, wenn Sie diesen Text lesen. Um eine bestimmte Version zu installieren, können Sie folgendes Muster verwenden: `pip3 install pyrogram==1.2`.

Anschließend können Sie ein neues Jupyter Notebook erstellen. Zu Beginn des Skriptes importieren Sie die Pyrogram-Bibliothek und Pandas, beides wird im Verlauf der Datenerhebung benötigt. Die Bibliothek os wird später zum Feststellen des Arbeitsverzeichnisses verwendet.

```
from pyrogram import Client
import pandas as pd
import os
```


## Schritt 3: Zugriff auf die Telegram-API starten
Um nun von Ihrem Jupyter Notebook auf Telegram zugreifen zu können, müssen Sie zunächst einen Pyrogram-Client starten.
Der Pyrogram-Client funktioniert als Vermittler zwischen Ihrem Skript und Telegram. Damit Telegram auch weiß, dass Sie hinter dem Skript stecken, müssen
Sie den CLient mit Ihren Zugangsdaten für die Telegram-API verknüpfen.

Dafür vervollständigen Sie folgende Zeilen und führen diese in Ihrem Notebook aus. Damit laden Sie die `api_id` und den `api_hash` als Objekte in Ihre Jupyter-Umgebung.

```
api_id = GEBENSIEHIERIHREAPIIDEIN
api_hash = "GEBENSIEHIERIHRENAPIHASHEIN"
```

Beachten Sie dabei, dass Sie Ihre `api_id` ohne Anführungszeichen und Ihren `api_hash` mit Anführungszeichen angeben.

 Um  Pyrogram zu nutzen, erstellen Sie mit `Client()` ein Objekt zur Interaktion mit der API und nennen es `app`. Die Funktion benötigt als Input zunächst einen beliebigen Namen, etwa "mysession", unter diesem Namen wird auf Ihrem Computer die aktuelle Session von Pyrogram abgespeichert. So müssen Sie sich nicht jedes Mal neu registrieren, sobald Sie Jupyter Lab verlassen. Daneben geben Sie der Funktion Ihre
 zuvor bereits erstellten Authentifizierungsdaten mit. Führen Sie also folgende Zeile aus:

```
app = Client("mysession", api_id=api_id, api_hash=api_hash)
```

Nun können Sie Anfragen an die API schicken. Führen Sie die folgenden Befehle aus, um Ihre eigenen Profilinformationen abzufragen:

```
await app.start()

me = await app.get_me()
print(me)
```

Richten Sie Pyrogram zum ersten Mal ein, öffnet sich ein Dialogfenster und Sie müssen Ihre Telefonnummer eingeben und bestätigen. Anschließend bekommen Sie auf Ihr Smartphone einen Authentifizierungs-Code zugeschickt, den Sie nun wiederum im Dialog-Fenster eingeben.  Hat die Authentifizierung geklappt, startet nun die Session und alles ist  fertig für die Datenerhebung eingerichtet.

Der Befehl `await app.start()` startet eine neue Session. Am Ende jeder Session, also bevor Sie Jupyter Lab wieder verlassen, beenden Sie diese mit:

```
await app.stop()
```

Alle Befehle werden hier mit dem Schlüsselwort `await` ergänzt, da Pyrogram asynchron arbeitet. Das bedeutet, im Hintergrund läuft eine Schleife, die auf Befehle wartet. So wird im Beispiel der Befehl `app.get_me()` verwendet, um die eigenen Accountinformationen abzurufen. Dieser Befehl wird aber nicht sofort ausgeführt, sondern erst wenn man Ergebnis anfordert - und dazu dient `await`. Weitere Erläuterungen zum Umgang mit asynchronen Funktionen finden Sie in der [Python-Dokumentation](https://docs.python.org/3/library/asyncio-task.html).   

## Schritt 4: Testabfragen der Telegram-API
Sobald Ihre Session gestartet ist, können Sie mit der Telegram-API interagieren. Sie können zum Beispiel über die Funktion ```send_message()``` auch Nachrichten senden. Dafür geben Sie als ersten Parameter den Kontakt aus Ihrem Adressbuch ein, an den Sie eine Nachricht schicken wollen (verwenden Sie "me" für Ihren eigenen Account). Als zweiten Parameter können Sie eine Nachricht verfassen. Der fertig formulierte Befehl könnte demnach lauten:
  ```
  await app.send_message("me", "Hello from **Pyrogram**!")
  ```

Öffnen Sie anschließend die Telegram-App und schauen Sie nach, ob Ihre Nachricht angekommen ist.

Welche weiteren Funktionen zur Interaktion mit Telegram möglich sind, können Sie in der Dokumentation von Pyrogram nachlesen (https://docs.pyrogram.org/api/methods/).
Dort finden Sie auch weitere Details oder Alternativen für die nachfolgend beschriebenen Funktionen.


## Schritt 5: Abfragen von öffentlichen Kanal- bzw. Gruppenbeschreibungen
Kanäle und Gruppen werden auf Telegram als Chats bezeichnet. Informationen zu Chats - wie die Beschreibung, die angepinnte Mitteilung oder das Erstelldatum - erhalten Sie über die Funktion ```get_chat()``` Diese nimmt als Input-Parameter eine eindeutige Kennzeichnung des Chats entgegen - hier benötigen Sie die ID oder das Handle des Kanals.
Das Handle eines Kanals oder einer Gruppe können Sie ausfindig machen, indem Sie das entsprechende Angebot in Ihrer Telegram-App öffnen.
Klicken Sie anschießend auf die Beschreibung und suchen Sie den Link zu diesem Angebot. Der Teil hinter `t.me/` ist das
Handle des Chats. Das Handle für den offiziellen Corona-Infokanal des Bundesministeriums für Gesundheit lautet beispielsweise "corona_infokanal_bmg".

Führen Sie die Funktion aus und speichern Sie das Ergebnis im Objekt "chat" ab:

```
chat = await app.get_chat("corona_infokanal_bmg")
```

Über die Funktion `print()` können Sie sich den Inhalt von Objekten anzeigen lassen:

```
print(chat)
```

Bei Anfragen an die Telegram-API bekommen Sie Pyrogram-Objekte zurück (siehe https://docs.pyrogram.org/api/types/). Diese
beinhalten üblicherweise Eigenschaften, über die auf einzelne Werte zugegriffen werden kann. Auf einzelne Eigenschaften der Objekte können Sie mit einem `.`zugreifen. So erhalten Sie beispielsweise über `chat.title` den Titel des Kanals. Objekte können außerdem Listen mit weiteren Objekten enthalten sein oder weiter verschachtelt sein - indem eine Eigenschaft eines Objektes wiederum ein Objekt ist. Versuchen Sie, die Struktur des Outputs nachzuvollziehen, indem Sie in der Dokumentation nachsehen oder sich die Objekte anzeigen lassen.

Um nun einzelne Inhalte aus dem Objekt auslesen zu können, legen Sie zunächst ein leeres Dictionary `{}`an und füllen dieses anschließend mit den gewünschten Daten. Ein Dictionary ist ein Datenformat in Python, das aus Schlüssel-Wert-Paaren besteht.

Folgender Codeblock legt ein leeres Dictionary an und liest aus dem Chat-Objekt die Id, den Chat-Typ, den Titel, die Beschreibung sowie den
Text der angepinnten Mitteilung aus:

```
chat_dict = {}

chat_dict['id'] = chat.id
chat_dict['type'] = chat.type
chat_dict['title'] = chat.title
chat_dict['description'] = chat.description
chat_dict['pinned_message'] = chat.pinned_message.text
```

Dieses Dictionary kann anschließend über die Funktion `pd.DataFrame()` für die Datenanalyse in ein Tabellenformat überführt werden. Diese Funktion erwartet eine Liste mit Dictionaries. Deshalb wird das `chat_dict` nicht direkt übergeben, sondern in eckige Klammern eingefasst. Mit der Funktion `to_csv()` kann der Dataframe abgespeichert werden:

```
chat_results = pd.DataFrame([chat_dict])
chat_results.to_csv('chat_results.csv',sep=";",index=False)
```

Tatsächlich wird also nicht das Dictionary, sondern eine Liste von Dictionaries abgespeichert, sodass jedes Chat-Dictionary zu einer Zeile im Dataframe wird. Listen werden in Python mit eckigen Klammern `[]` erzeugt. Da im Beispiel lediglich ein Chat erhoben wurde, hat die Liste auch nur einen
Eintrag und der Dataframe nur eine Zeile. Wenn Sie mehrere Chats in dem gleichen Dataframe speichern wollen, können Sie analog zu den Mitteilungen (Schritt 6) verfahren.


## Schritt 6: Abfragen von Nachrichten
Die Nachrichten in einem Angebot können über die Funktion `get.history()` abgefragt werden. Voreingestellt werden dabei die letzten 100 Mitteilungen in dem Chat zurückgegeben:

```
messages = await app.get_history("corona_infokanal_bmg")
```

Das Ergebnis dieser Abfrage ist eine Liste mit Message-Objekten. Über den folgenden Codeblock werden für jedes Objekt in dieser Liste die Mitteilungs-Id, das Datum der Mitteilung, sowie der Inhalt der Mitteilung ausgelesen. Sie können das Ergebnis mit dem `print`-Befehl ansehen.

Die Funktion `get_history` liefert dabei standardmäßig nur den Text der Mitteilungen. Häufig werden jedoch eine Vielzahl diverser Mediendateien über Messenger versendet werden.
Um Bilder auslesen zu können, wird im Codeblock überprüft, ob die Eigenschaft `photo` vorhanden ist. Falls ja, werden ebenfalls die Bildunterschrift sowie die File-Id ausgelesen. Die File-Id wird benötigt, um in einem weiteren Erhebungsschritt die Mediendateien herunterzuladen (siehe Schritt 7).

Die ausgelesenen Inhalte werden anschließend in einen Dataframe umgewandelt und abgespeichert:

```
# Leere Liste, um die Mitteilungen einzusammeln
messages_list = []

# Auslesen der Daten der einzelnen Mitteilungen
for item in messages:

    message_dict = {}

    message_dict['chat_id'] = item['chat']['id']
    message_dict['message_id'] = item['message_id']
    message_dict['date'] = item['date']
    message_dict['text'] = item['text']

    if item['photo'] is not None:
        message_dict['caption'] = item['caption']
        message_dict['file_id'] = item['photo']['file_id']

    else:
        message_dict['caption'] = None
        message_dict['file_id'] = None

    messages_list.append(message_dict)

# Umwandeln in Dataframe
messages_results = pd.DataFrame(messages_list)

# Abspeichern
messages_results.to_csv('messages_results.csv', sep=";", index=False)

```

## Schritt 7: Abfragen von Mediendateien

Um abschließend die Bilder aus Ihren erhobenen Nachrichten herunterzuladen, müssen Sie zunächst ein Verzeichnis für den Download festlegen. Erstellen Sie dafür am besten einen Unterordner in Ihrem Arbeitsverzeichnis, in dem die Dateien landen können. Geben Sie nun den gesamten Pfad (wie im Explorer bzw. Finder) in einem Objekt  ```media_folder``` an. Im folgenden Befehl wird über `os.getcwd()` der Pfad des aktuellen Arbeitsverzeichnissen mit dem Unterordner kombiniert:  

```
media_folder = os.getcwd() + "/downloads/"
```

Achten Sie dabei darauf, die Trennstriche als Vorwärtsslashes ```/``` zu schreiben, da anderenfalls Kodierungsprobleme auftreten können (der Backslash wir in Strings zu Maskierung verwendet).

Über die Funktion ```download_media()``` können Sie nun für jede Mitteilung mit vorhandener Fotodatei das entsprechende Bild herunterladen. Dafür wird die `file_id` benötigt (siehe Schritt 6). Beachten Sie dabei, dass diese Angabe nach einiger Zeit ablaufen kann. Ist dies der Fall, müssen Sie die Mitteilungen im Zweifelsfall erneut herunterladen und erhalten eine neue, zeitlich begrenzt gültige File-Id.

Optional kann der Downloadfunktion ein selbst gewählter Dateiname mitgegeben werden, unter dem die Datei abgespeichert wird. Im nachfolgenden Codeblock wurde je Mitteilung ein eigener Dateiname erstellt, der die ID des Kanals und der Mitteilung enthält.
Dadurch kann auch im Nachheinein zugeordnet werden, welches Bild welcher Nachricht entstammt.

Führen Sie den Codeblock aus und beobachten Sie in Ihrem Downloadordner, wie nach und nach die Bilder heruntergeladen werden. Je nach Größe der Dateien und je nach Internetverbindung, kann dies eine Weile dauern.

```


for item in messages_list:

    if item['file_id'] is not None:
        filename =  "photo_" + str(item['chat_id']) +"_"+ str(item['message_id']) + ".jpg"
        print(f"Downloading {filename}")

        await app.download_media(item['file_id'], media_folder + filename)

```

Alternativ können Sie diesen Schritt - das Herunterladen der Bilder - direkt oben in die Schleife integrieren, mit der die Mitteilungen in Dictionaries abgelegt werden.

## Fehlerbehandlung

Wenn nicht nur einzelne Chats, Mitteilungen oder Bilder erhoben werden, treten früher oder später Fehler (=exceptions) auf - beispielsweise wenn Handles nicht mehr existieren oder die File-Id abläuft. Deshalb lohnt es sich, die verschiedenen Abfragen innerhalb der Schleifen in try-except-Blöcke zu kapseln. So wird das Skript nicht abgebrochen, stattdessen wird eine Fehlermeldung ausgegeben und das nächste Element in der for-Schleife bearbeitet. Am Beispiel der Downloads könnte das wie folgt aussehen:

```
try:
    filename =  "photo_" + str(item['chat_id']) +"_"+ str(item['message_id']) + ".jpg"
    print(f"Downloading {filename}")

    await app.download_media(item['file_id'], media_folder + filename)
except Exception as e:
  print("Fehler beim Download von "+filename+"\n")
  print(e)
```

Achten Sie darauf, nicht endlos Fehler zu produzieren. Denn Sie riskieren  eine Sperrung durch Telegram, wenn Sie zu schnell zu viele Abfragen senden, dazu zählen auch fehlerhafte Abfragen. Sie können gezielt bestimmte Typen von Fehlern abfangen, die verschiedenen Fehlerarten finden Sie in der Pyrogram- Dokumentation.

## Hilfe und Unterstützung im Lehrbuch
Das beschriebene Tutorial bietet einen Schnelleinstieg in die Datenerhebung über die Telegram-API. An der einen oder anderen Stelle kann es hilfreich sein, sich mit einigen Grundlagen zu beschäftigen. Dabei könnten Ihnen folgende Kapitel im Lehrbuch behilflich sein:
- **[Kapitel 2](/02_datenquellen)** gibt einen Überblick über APIs als **Datenquellen**.
- In **[Kapitel 3](/03_datenformate)** wird in unterschiedliche **Datenformate** eingeführt.
- **[Kapitel 5.2](/05_programmierung/5_2_Python)** gibt eine Einführung in **Python** mit Jupyter Notebooks. Sollten Sie Probleme mit dem Einrichten des Programms oder dem Ausführen der Codeschnipsel haben, lesen Sie dort nach.
- **[Kapitel 7.2](07_datenerhebung/7_2_apis)** beschreibt grundlegend die Vorgehensweise bei der **Datenerhebung über APIs**.
- **[Kapitel 8](/08_machine_learning)** bietet einen praktischen Einstieg in **Analyseverfahren**, wie beispielsweise der Textanalyse, um die erhobenen Daten auszuwerten.
