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

if (isset($_POST['btn_edit'])) {
	extract($_POST);
	$connected = $_SESSION['user_connected'];

	try {

		$elements = array(
			'first_name'	=>	$first_name,
			'last_name'		=>	$last_name,
			'email'			=>	$email,
			'tel'			=>	$tel,
			'adresse'		=>	$adresse,
			'facebook'		=>	$facebook,
			'twitter'		=>	$twitter,
			'linkedin'		=>	$linkedin,
			'sexe'			=>	$sexe,
			'bio'			=>	$bio,
			'id'			=>	$connected
		);

		$requete = "UPDATE users SET first_name=:first_name,last_name=:last_name,email=:email,tel=:tel,adresse=:adresse,facebook=:facebook,twitter=:twitter,linkedin=:linkedin,sexe=:sexe,bio=:bio WHERE id=:id ";

		$query = $db->prepare($requete);
		$result = $query->execute($elements);

		if (!empty($result)) {
			$msg_ok = "Modification avec succès👌";
		}
		
	} catch (PDOException $e) {
		die("impossible de faire la modification:".$e->getMessage());
	}
}


?>

<!DOCTYPE html>
<html>
<head>
	<title>Bienvenu chez nous!</title>
	<link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="assets/font-awesome/css/font-awesome.min.css">

	<link rel="shortcut Icon" type="text/css" href="assets/images/icones/address-icon.png">

	<meta name="viewport" content="widtd=device-widtd, initial-scale=1, shrink-to-fit=no">

	<meta name="robots" content="follow, all">
	<meta name="description" content="site web des echanges des idées et de trocs">
	<meta name="autdor" content="devtech">
	<meta name="keyword" content="réseau social">
	<meta charset="utf-8">
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
								
								<?php include("./component/basic_info.php") ?>

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