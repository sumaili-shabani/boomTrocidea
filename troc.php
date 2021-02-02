<?php 

require_once("security2.php");
require_once("db.php");
require_once("function.php");
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


if (isset($_POST['btn_add'])) {
	extract($_POST);
	$nom = $nom;
	$description = $description;
	$id_user = $connected;

	

	if ($nom =='' || $description =='' || $id_user=='') {

		$msg = "Veillez remplir tous les champs";
	}
	else{

		$photo = upload_product();


			try {

				$query = $db->prepare("INSERT INTO troc(nom,description,photo,id_user,prix) VALUES(:nom,:description,:photo,:id_user,:prix)");
				$query->execute([
					':nom'			=>	$nom,
					':description'	=>	$description,
					':photo'		=>	$photo,
					':id_user'		=>	$id_user,
					':prix'			=>	$prix
				]);

				if (!empty($query)) {
					// header('Location:profile.php');
					$msg_ok = "Votre produit a été ajouté avec succès👌";

				}
				
			} catch (PDOException $e) {
				die("impossible de faire l'enregistrement: ".$e->getMessage());
			}
			
			

	}

	


	
}






?>

<!DOCTYPE html>
<html>
<head>
	<title>Echange et  troc</title>
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
						<div class="col-md-12">
							<form method="POST" enctype="multipart/form-data" class="row">

								<?php include("alert.php") ?>
								
								<?php include("./component/basic_troc.php") ?>

							</form>
						</div>
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