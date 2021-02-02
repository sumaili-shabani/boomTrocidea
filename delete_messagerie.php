<?php  
require_once("security2.php");
require_once("db.php");
require_once("function.php");

if (isset($_GET['idmessage'])) {
	$idmessage = $_GET['idmessage'];
	$id_recever = $_SESSION['user_connected'];

	$del = $db->prepare("DELETE FROM messagerie WHERE idmessage=:idmessage AND id_recever=:id_recever ");
	$res = $del->execute([
		'idmessage'		=>	$idmessage,
		'id_recever'	=>	$id_recever
	]);

	if (!empty($res)) {
		header("Location:message_user.php");
	}
	# code...
}


?>