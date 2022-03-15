<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Example page</title>
  </head>
  <body> 
    

<h1>Datenbanken</h1>
  <?php
    //Connect to MySQL
    try {
      $pdo = new PDO('mysql:host=sql', 'root', 'root');
      
      $statement = $pdo->query("SHOW DATABASES");
      $databases = $statement->fetchAll(PDO::FETCH_COLUMN,0); 
      $errors = $pdo->errorInfo()[2];
    } catch (PDOException $e) {
        $errors =$e->getMessage();
        $rows = [];
    }  
  ?>
  
<p>  
  <?php if (!empty($errors)): ?>
  
    Es kann keine Verbindung zur Datenbank aufgebaut werden. 
    Bitte überprüfen Sie die Einstellungen:<br>    
    <?= $errors ?>
    
  <?php else: ?>
    Folgende Datenbanken sind auf dem Server vorhanden:<br>
    <?= implode(', ',$databases) ?>
  <?php endif; ?>
</p>


<?php if (in_array('devel',$databases)): ?>

<h1>Datenbank devel</h1>
<?php
  //Connect to MySQL
  try {
    $pdo = new PDO('mysql:host=sql;charset=utf8mb4;dbname=devel', 'root', 'root');
    
    $statement = $pdo->query("SELECT * FROM people LIMIT 10");
    $rows = $statement->fetchAll();
    $errors = $pdo->errorInfo()[2];
  } catch (PDOException $e) {
      $errors =$e->getMessage();
      $records = [];
  }  
?>

  <?php if (!empty($errors)): ?>
      Konnte keine Daten abfragen:<br>      
      <?= $errors ?><br>
      Bitte legen Sie die Tabelle "people" in der Datenbank "devel" an.
  <?php else: ?>  
    <table>
      <thead>
        <tr>
          <td>Name</td>
          <td>Born</td>
          <td>Died</td>
        </tr>
      </thead>
      
      <tbody>
      
      <?php foreach($rows as $row) :?>
      <tr>
        <td><?= $row['name'] ?? '' ?></td>
        <td><?= $row['born'] ?? '' ?></td>
        <td><?= $row['died'] ?? '' ?></td>
      </tr>
      <?php endforeach;?>
      </tbody>
    </table>

  <?php endif; ?>
<?php endif; ?>

  </body>
</html>
