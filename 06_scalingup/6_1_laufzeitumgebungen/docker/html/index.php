<div class="center">
  <h1>Hello World!</h1>
</div>

<div class="center">
<table>
  <tbody>
    <tr class="h"><td><h1 class="p">SQL Connection</h1></td></tr>
  </tbody>
</table>

<?php
//Connect to MySQL
  try {
    $pdo = new PDO('mysql:host=mysql', 'root', 'root');
    $statement = $pdo->query("SHOW DATABASES");
    $records = $statement->fetchAll(PDO::FETCH_COLUMN,0); 
    $errors = $pdo->errorInfo()[2];
  } catch (PDOException $e) {
      $errors =$e->getMessage();
      $records = [];
  }  
?>

<table>
  <tbody>
    <tr>
      <td class="e">Connection </td>
      <td class="v"><?= empty($errors)?'ok':'Error: '.$errors ?></td>
    </tr>
    <tr>
      <td class="e">Databases </td>
      <td class="v"><?= implode('; ',$records) ?></td>
    </tr>
 
  </tbody>
</table>

</div>


<?php phpinfo(); ?>