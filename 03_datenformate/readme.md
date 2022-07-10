<img src="chapter_03_zentangle.png" width="150" alt="Abbildung für Kapitel 3" align="right">

# Datenformate

Daten können in verschiedenen Formatierungen vorliegen (Kapitel 3). Je nachdem, ob es sich um Zahlen, Zeichenketten oder Wahrheitswerte handelt, 
können die Daten durch unterschiedliche *Datentypen* repräsentiert werden (Kapitel 3.1). 
Dabei können die Daten in spezifischen *Datenformaten* erfasst sein - dazu zählen Textformate (Kapitel 3.2), Tabellenformate (Kapitel 3.3), Auszeichnungssprachen (Kapitel 3.4), 
Objektdatenformate (Kapitel 3.5) oder Datenbanken (Kapitel 3.6). Letztendlich wird über das *Datenmodell* festgelegt, welche Bedeutung die Daten haben (Kapitel 3.7). 


## Übersicht über Ordner und Dateien 

- **3_3_tabellenformate**: CSV-Dateien in unterschiedlichen Dialekten.
- **3_7_datenmodelle**: Daten zu einem Film, in verschiedenen Formaten repräsentiert. 


## Datenformate im Vergleich 

**Tabelle**
<table style="width:100%">
<tr>
	<th>id</th>
	<th>name</th> 
	<th>from</th> 
	<th>favorites</th>
	<th>replies</th>
	<th>retweets</th>
	<th>hashtags</th>
</tr>
<tr>
	<th>6</th>
	<th>eaduenergy</th>
	<th>Forschungslabor Eadu</th>
	<th>64</th>
	<th>0</th>
	<th>1</th>
	<th>sternzerstörer,werft</th>
</tr>
<tr>
	<th>7</th>
	<th>eaduenergy</th>
	<th>Forschungslabor Eadu</th>
	<th>3</th>
	<th>0</th>
	<th></th>
	<th>todesstern</th>
</tr>
<tr>
	<th>8</th>
	<th>eaduenergy</th>
	<th>Forschungslabor Eadu</th>
	<th>30</th>
	<th>0</th>
	<th>6</th>
	<th>kyber</th>
</tr>
</table>


**CSV**  
<br>id,name,from,favorites,replies,retweets,hashtags
<br>6,eaduenergy,Forschungslabor Eadu,64,0,1,"sternzerstörer,werft"
<br>7,eaduenergy,Forschungslabor Eadu,3,0,,todesstern
<br>8,eaduenergy,Forschungslabor Eadu,30,0,6,kyber
  



**HTML**
```
<!DOCTYPE html>
<html> 
  <head> 
     <title>Tabelleninhalte</title> 
  </head>  
  <body> 
	<table style="width:100%">
		<tr>
			<th>id</th>
			<th>name</th> 
			<th>from</th> 
			<th>favorites</th>
			<th>replies</th>
			<th>retweets</th>
			<th>hashtags</th>
		</tr>
		<tr>
			<th>6</th>
			<th>eaduenergy</th>
			<th>Forschungslabor Eadu</th>
			<th>64</th>
			<th>0</th>
			<th>1</th>
			<th>sternzerstörer,werft</th>
		</tr>
		<tr>
			<th>7</th>
			<th>eaduenergy</th>
			<th>Forschungslabor Eadu</th>
			<th>3</th>
			<th>0</th>
			<th></th>
			<th>todesstern</th>
		</tr>
		<tr>
			<th>8</th>
			<th>eaduenergy</th>
			<th>Forschungslabor Eadu</th>
			<th>30</th>
			<th>0</th>
			<th>6</th>
			<th>kyber</th>
		</tr>
	</table>
   </body>
</html>
```


**JSON**  
```
[   
    {    
      "id": 6, 
	  "name": "eaduenergy", 
	  "from": "Forschungslabor Eadu",
	  "favorites" : 64,   
	  "replies" : 0,    
	  "retweets": 1,   
	  "hashtags": "sternzerstörer,werft"  
    },  
    {    
      "id": 7, 
	  "name": "eaduenergy", 
	  "from": "Forschungslabor Eadu",
	  "favorites" : 3,   
	  "replies" : 0,    
	  "retweets": 0,   
	  "hashtags": "todesstern"  
    },  
    {    
      "id": 8, 
	  "name": "eaduenergy", 
	  "from": "Forschungslabor Eadu",
	  "favorites" : 30,   
	  "replies" : 0,    
	  "retweets": 6,   
	  "hashtags": "kyber"  
    }
]  
```
