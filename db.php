<?php
$username = 'root';
$password = '';
try {
    $db = new PDO( 'mysql:host=localhost;dbname=devtop', $username, $password );

} catch (PDOException $e) {
    die("impossible de trouver la base des données:".$e->getMessage());
}
?>