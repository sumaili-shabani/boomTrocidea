<?php 

require_once("security2.php");
require_once("db.php");
$connected;


$first_name = '';
$last_name = '';
$email = '';
$created_at = '';
$image = '';
$sexe = '';
$bio = '';
$facebook = '';
$twitter = '';
$linkedin = '';
$adresse = '';
$tel = '';



if (isset($_SESSION['user_connected'])) {
	$connected = $_SESSION['user_connected'];

	// echo("la personne connectée:".$connected);

	$query =$db->prepare("SELECT * FROM users WHERE id=:id");
	$query->execute(array(
		'id'	=>	$connected
	));

	$result = $query->fetchAll();
	foreach ($result as $key) {

		$first_name = $key['first_name'];
		$last_name = $key['last_name'];
		$email = $key['email'];
		$created_at = $key['created_at'];
		$image = 'upload/'.$key['image'];
		$sexe = $key['sexe'];
		$bio = $key['bio'];
		$facebook = $key['facebook'];
		$twitter = $key['twitter'];
		$linkedin = $key['linkedin'];
		$adresse = $key['adresse'];
		$tel = $key['tel'];
	}



}
else{
	echo("pas de session");
}


if (isset($_POST['envoyer_message'])) {

	if (!empty($_POST['Message_text']) && !empty($_GET['id_recever'])) {

		$elements = array(

		':id_user'		=>	$connected,
		':id_recever'	=>	htmlspecialchars($_GET['id_recever']),
		':message'		=>	htmlspecialchars($_POST['Message_text'])
		);
		
		try {

			$query = $db->prepare(
				"INSERT INTO messagerie(id_user,id_recever,message) VALUES(:id_user,:id_recever,:message)
				"
			);
			$query->execute($elements);
			if (!empty($query)) {
				

				$query_ok = $db->prepare(
					"UPDATE messagerie SET etat_message=1 WHERE id_user=:id_user 
					AND id_recever=:id_recever

					"
				);
				$query_ok->execute(
					array(

						':id_user'		=>	$connected,
						':id_recever'	=>	$_GET['id_recever']
						
					)
				);
				if (!empty($query_ok)) {
					$msg22= 'Votre message  a été envoyer avec succès';
				}


			}
				
		} catch (PDOException $e) {
			die("impossible d'envoyer le message ".$e->getMessage());
		}	
	
	}
	else{
		$msg2="erreur veillez remplire tous les champs";
	}
	# code...
}


?>
<!DOCTYPE html>
<html>
<head>
	<title>Bienvenu chez nous!</title>
	<?php include("_meta.php") ?>
</head>
<body>

	<!-- insertion de navbar menu -->
	<?php include("_navBar.php") ?>
	<!-- fiin insertion -->


	<div class="container" style="margin-top: 80px;">
		<div class="container-fluid">
			<!-- mes scripts commencent -->

			<div class="col-md-12">
				<div class="row">
					<div class="col-md-8">
						<?php include("chat_form.php") ?>
					</div>
					<div class="col-md-4">
						<?php include("menu_user.php") ?>
					</div>
				</div>
			</div>

			
			
			<!-- fin de mes scripts -->
		</div>
	</div>


	


	<!-- bloc footer -->
    <div style="margin-top: 100px;"></div>

    <?php include("_footer.php") ?>

    <?php include("_script.php") ?>






    <!-- fin bloc footer -->


</body>
</html>