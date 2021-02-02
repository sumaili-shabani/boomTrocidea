<?php  
require_once("security2.php");
require_once("db.php");
require_once("function.php");

if (isset($_GET['idnot'])) {
	$idnot = $_GET['idnot'];
	$id_recever = $_SESSION['user_connected'];

	$del = $db->prepare("DELETE FROM notification WHERE idnot=:idnot AND id_recever=:id_recever ");
	$res = $del->execute([
		'idnot'			=>	$idnot,
		'id_recever'	=>	$id_recever
	]);

	if (!empty($res)) {
		header("Location:notification_user.php");
	}
	# code...
}


?>