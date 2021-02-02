<?php  
require_once("security2.php");
require_once("db.php");
require_once("function.php");

if (isset($_GET['idcomment']) && isset($_GET['idt'])) {
	$idcomment 	= $_GET['idcomment'];
	$id_user 	= $_SESSION['user_connected'];

	$del = $db->prepare("DELETE FROM commentaire WHERE idcomment=:idcomment AND id_user=:id_user ");
	$res = $del->execute([
		'idcomment'	=>	$idcomment,
		'id_user'	=>	$id_user
	]);

	if (!empty($res)) {
		header("Location:notification.php?idt=".$_GET['idt']);
	}
	# code...
}


?>