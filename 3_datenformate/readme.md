# Datenformate im Vergleich 
 
**Tabelle**
<table style="width:100%">
<tr>
	<th>id</th>
	<th>favorites</th> 
	<th>replies</th> 
	<th>retweets</th>
	<th>hashtags</th>
</tr>
<tr>
	<th>1</th>
	<th>0</th>
	<th>0</th>
	<th>0</th>
	<th>Lastenräder,UniGreifswald</th>
</tr>
<tr>
	<th>3</th>
	<th>6</th>
	<th>0</th>
	<th>0</th>	
	<th>citizenscience,Naturpark</th>
</tr>
<tr>
	<th>4</th>
	<th>5</th>
	<th>0</th>
	<th>0</th>	
	<th>Nachhaltigkeit,Thema,Ideen</th>	
</tr>
</table>


**CSV**  
id,favorites,replies,retweets,hashtags  
1,0,0,0,"Lastenräder,UniGreifswald"  
3,6,0,0,"citizenscience,Naturpark"  
4,5,0,0,"Nachhaltigkeit,Thema,Ideen"  



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
					<th>favorites</th> 
					<th>replies</th> 
					<th>retweets</th>
					<th>hashtags</th>
				</tr>
				<tr>
					<th>1</th>
					<th>0</th>
					<th>0</th>
					<th>0</th>
					<th>Lastenräder,UniGreifswald</th>
				</tr>
				<tr>
					<th>3</th>
					<th>6</th>
					<th>0</th>
					<th>0</th>	
					<th>citizenscience,Naturpark</th>
				</tr>
				<tr>
					<th>4</th>
					<th>5</th>
					<th>0</th>
					<th>0</th>	
					<th>Nachhaltigkeit,Thema,Ideen</th>	
				</tr>
			</table>
         </body>
       </html>
```


**JSON**  
```
[   
    {    
      "id": 1,   
      "favorites" : 0,   
      "replies" : 0,    
	  "retweets": 0,   
	  "hashtags": "Lastenräder,UniGreifswald"  
    },  
    {   
      "id": 3,  
      "favorites" : 6,  
      "replies" : 0,   
	  "retweets": 0,   
	  "hashtags": "citizenscience,Naturpark"  
    },  
	{   
      "id": 4,  
      "favorites" : 5,  
      "replies" : 0,   
	  "retweets": 0,   
	  "hashtags": "Nachhaltigkeit,Thema,Ideen"  
    }  
]  
```
