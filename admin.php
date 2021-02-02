<?php 

require_once("security.php");
if (isset($_SESSION['admin_connected'])) {
	$connected = $_SESSION['admin_connected'];

	echo($connected);
}
else{
	echo("pas de session");
}



 ?>