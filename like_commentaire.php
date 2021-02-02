<?php 
require_once("security2.php");
require_once("db.php");
require_once("function.php");


if (isset($_GET['idcomment']) && isset($_GET['idt']) && isset($_GET['id_user'])) {
	$idcomment = $_GET['idcomment'];
	$id_user = $_SESSION['user_connected'];

	$query = $db->prepare("SELECT * FROM likes_comment WHERE idcomment=:idcomment AND id_user=:id_user");
	$query->execute([
		'idcomment'	=>	$idcomment,
		'id_user'	=>	$id_user
	]);
	$nombre_trouver = $query->rowCount();
	if ($nombre_trouver > 0) {

		$del = $db->prepare("DELETE FROM likes_comment WHERE idcomment=:idcomment AND id_user=:id_user ");
		$res = $del->execute([
			'idcomment'	=>	$idcomment,
			'id_user'	=>	$id_user
		]);

		if (!empty($res)) {
			header("Location:notification.php?idt=".$_GET['idt']);
		}
		// echo("delete");
	}
	else{

		$insert = $db->prepare("INSERT INTO likes_comment(idcomment,id_user) VALUES(:idcomment,:id_user)");
		$res = $insert->execute([
			'idcomment'		=>	$idcomment,
			'id_user'	=>	$id_user
		]);


		$select = $db->prepare("SELECT * FROM users WHERE id=".$_GET['id_user']." ");
		$select->execute();
		foreach ($select->fetchAll() as $key) {

			if ($key['id'] != $_SESSION['user_connected']) {
				# code...
			 	$nom = show_name_user($_SESSION['user_connected']);

			 	try {

			 		$insert2 = $db->prepare("INSERT INTO notification(id_recever,titre,message,icone,url) VALUES(:id_recever,:titre,:message,:icone,:url)");
					$requete = $insert2->execute([
						'id_recever'	=>	$key['id'],
						'titre'			=>	"Reagissement",
						'message'		=>	$nom." a reagi à votre commentaire à une publication",
						'url'		=>	"notification.php?idt=".$_GET['idt'],
						'icone'			=>	"fa fa-thumbs-up"
					]);

					if (!empty($requete)) {
						// echo("notification:".$key['id']).'<br>';
						header("Location:notification.php?idt=".$_GET['idt']);
					}
			 		
			 	} catch (PDOException $e) {
			 		die("erreur!! ".$e->getMessage());
			 	}

			}
			else{
				header("Location:notification.php?idt=".$_GET['idt']);
			}

			

		} 


		// if (!empty($res)) {
		// 	header("Location:news.php");
		// }


		// echo("insert");
	}


	// echo("idcomment:".$idcomment." personne:".$id_user);
}

 ?>