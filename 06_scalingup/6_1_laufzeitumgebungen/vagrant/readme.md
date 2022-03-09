# Eine Vagrant Box starten

1. Installieren Sie VirtualBox und Vagrant!
2. Klonen Sie das Repositorium des Buchs oder laden Sie sich das Vagrantfile und den Ordner public herunter.
3. Öffnen Sie eine Kommandozeile und gehen Sie in das Verzeichnis mit dem Vagrantfile.
4. Mit dem folgenden Befehl starten Sie die Box:  
   `vagrant up`
5. Rufen Sie im Browser die Adresse der Box auf, so dass das Skript im Unterordner public gestartet wird:  
   http://192.168.33.10
6. Ändern Sie etwas in der Datei `public/index.php` und aktualisieren Sie die Seite in Ihrem Browser (Taste F5).   
7. Die Box können Sie mit folgendem Befehl wieder herunterfahren:
   `vagrant halt`
   