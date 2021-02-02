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
$img = '';



if (isset($_SESSION['user_connected'])) {
	$connected = $_SESSION['user_connected'];

	// echo("la personne connectée:".$connected);

	$query =$db->prepare("SELECT * FROM users WHERE id=:id");
	$query->execute(array(
		'id'	=>	$connected
	));

	$result = $query->fetchAll();
	foreach ($result as $key) {
		$image = 'upload/'.$key['image'];
		
	}



}
else{
	echo("pas de session");
}


if (isset($_GET['id'])) {
	$user_tag = $_GET['id'];

	// echo("la personne connectée:".$connected);

	$query =$db->prepare("SELECT * FROM users WHERE id=:id");
	$query->execute(array(
		'id'	=>	$user_tag
	));

	$result = $query->fetchAll();
	foreach ($result as $key) {

		$first_name = $key['first_name'];
		$last_name = $key['last_name'];
		$email = $key['email'];
		$created_at = $key['created_at'];
		$img = 'upload/'.$key['image'];
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


?>

<!DOCTYPE html>
<html>
<head>
	<title>Profile de l'utilisateur <?= $first_name ?></title>
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
							<div class="row">
								<div class="col-4">
									<img src="<?php echo($img) ?>" class="img-responsive img-thumbnail">
								</div>

								<div class="col-8">

									<span class="text-muted form-group">
										<strong><i class="fa fa-user"></i>&nbsp;</i>Nom:</strong> <?php echo($first_name) ?>
									</span> <br>

									<span class="text-muted form-group">
										<strong><i class="fa fa-user"></i>&nbsp;Postnom:</strong> <?php echo($last_name) ?>
									</span><br>

									<span class="text-muted form-group">
										<strong><i class="fa fa-male">&nbsp;</i>Sexe:</strong> <?php echo($sexe) ?>
									</span><br>

									<span class="text-muted form-group">
										<strong><i class="fa fa-google"></i>&nbsp;Email:</strong> <?php echo($email) ?>
									</span><br>

									<span class="text-muted form-group">
										<strong><i class="fa fa-phone"></i>&nbsp;Téléphone:</strong> <?php echo($tel) ?>
									</span><br>

									<span class="text-muted form-group">
										<strong><i class="fa fa-map-marker"></i>&nbsp;Adresse:</strong> 
										<?php echo($adresse) ?>
									</span><br>

									<span class="text-muted form-inline">
										<a href="<?php echo($facebook) ?>" target="_blank" class="text-info mr-3"><i class="fa fa-facebook"></i></a>
										<a href="<?php echo($twitter) ?>" target="_blank" class="text-info mr-3"><i class="fa fa-twitter"></i></a>
										<a href="<?php echo($linkedin) ?>" target="_blank" class="text-info mr-3"><i class="fa fa-linkedin"></i></a>
									</span><br>
									
								</div>

								<div class="col-12">
									<span class="text-muted form-group">
										<strong><i class="fa fa-tag"></i>i&nbsp;Biographie:</strong> <?php echo($bio) ?>
										<br>

									</span><br>
								</div>

							</div>
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