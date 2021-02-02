<?php 
require_once("security2.php");
require_once("db.php");
require_once("function.php");


if (isset($_GET['idt'])) {
	$idt = $_GET['idt'];
	$id_user = $_SESSION['user_connected'];

	$query = $db->prepare("SELECT * FROM likes WHERE idt=:idt AND id_user=:id_user");
	$query->execute([
		'idt'		=>	$idt,
		'id_user'	=>	$id_user
	]);
	$nombre_trouver = $query->rowCount();
	if ($nombre_trouver > 0) {

		$del = $db->prepare("DELETE FROM likes WHERE idt=:idt AND id_user=:id_user ");
		$res = $del->execute([
			'idt'		=>	$idt,
			'id_user'	=>	$id_user
		]);

		if (!empty($res)) {
			header("Location:news.php");
		}
		// echo("delete");
	}
	else{

		$insert = $db->prepare("INSERT INTO likes(idt,id_user) VALUES(:idt,:id_user)");
		$res = $insert->execute([
			'idt'		=>	$idt,
			'id_user'	=>	$id_user
		]);


		$select = $db->prepare("SELECT * FROM users");
		$select->execute();
		foreach ($select->fetchAll() as $key) {

			if ($key['id'] != $_SESSION['user_connected']) {
				# code...
			 	$nom = show_name_user($_SESSION['user_connected']);

			 	try {

			 		$insert2 = $db->prepare("INSERT INTO notification(id_recever,titre,message,icone,url) VALUES(:id_recever,:titre,:message,:icone,:url)");
					$requete = $insert2->execute([
						'id_recever'	=>	$key['id'],
						'titre'			=>	"nouveau j'aime",
						'message'		=>	$nom." a aimé une publication",
						'url'		=>	"notification.php?idt=".$_GET['idt'],
						'icone'			=>	"fa fa-heart"
					]);

					if (!empty($requete)) {
						// echo("notification:".$key['id']).'<br>';
						header("Location:news.php");
					}
			 		
			 	} catch (PDOException $e) {
			 		die("erreur!! ".$e->getMessage());
			 	}

			}

			

		} 


		// if (!empty($res)) {
		// 	header("Location:news.php");
		// }


		// echo("insert");
	}


	// echo("idt:".$idt." personne:".$id_user);
}

 ?>