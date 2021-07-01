# Docker-Container starten

1. Installieren und starten Sie Docker
2. Klonen Sie das Repositorium des Buchs oder laden Sie sich den Docker-Ordner herunter.
3. Öffnen Sie eine Kommandozeile und gehen Sie in das Verzeichnis mit der Datei docker-compose.yml.
4. Mit dem folgenden Befehl starten Sie die Container:  
   `docker compose up`
5. Rufen Sie im Browser die Adresse der Container auf, so dass das Skript im Unterordner html gestartet wird:  
   http://localhost 
 6. Rufen Sie die Adresse von phpMyAdmin auf und loggen Sie sich mit dem Benutzernamen "root" und dem Passwort "root" ein, um Datenbanken zu verwalten und SQL-Befehle auszuführen:
   http://localhost:8080
6. Die Container können Sie mit folgendem Befehl wieder herunterfahren:
   `docker compose stop`
   