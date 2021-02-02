<?php 
require_once("security2.php");
require_once("db.php");
require_once("function.php");


if (isset($_POST['btn_comment'])) {
	extract($_POST);
	$idt;
	$id_user = $_SESSION['user_connected'];
	$comments;

	if ($comments !='') {
		$insert = $db->prepare("INSERT INTO commentaire(idt,id_user,comments) VALUES(:idt,:id_user,:comments)");
		$res = $insert->execute([
			'idt'		=>	$idt,
			'id_user'	=>	$id_user,
			'comments'	=>	htmlspecialchars($comments)
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
						'id_recever'=>	$key['id'],
						'titre'		=>	"Nouveau commentaire",
						'message'	=>	$nom." a commenté une publication",
						'url'		=>	"notification.php?idt=".$idt,
						'icone'		=>	"fa fa-comment"
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

		
	}
	else{

		header("Location:news.php");
	}

	

	// echo("idt:".$idt." personne:".$id_user);
}

 ?>