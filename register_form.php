<?php 

require_once("db.php");
if (isset($_POST['btn_register'])) {
	extract($_POST);
	$nom = $first_name;
	$email = $email;
	$password = md5($pass);
	$image ='icone-user.png';

	if ($nom =='' || $email =='' || $password=='') {

		$msg = "Veillez remplir tous les champs";
	}
	else{


			try {

				$query = $db->prepare("INSERT INTO users(first_name,email,passwords,image) VALUES(:first_name,:email,:passwords,:image)");
				$query->execute([
					':first_name'	=>	$nom,
					':email'		=>	$email,
					':passwords'	=>	$password,
					':image'		=>	$image
				]);

				if (!empty($query)) {
					header('Location:login.php');
				}
				
			} catch (PDOException $e) {
				die("impossible de faire l'enregistrement: ".$e->getMessage());
			}
			
			

	}

	


	
}


?>

<div class="col-md-12">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">

			<div class="col-md-12">
				<div class="card">
					<div class="card-header text-center">
						<span>Devenir à présent membre au système boom social idea</span>
					</div>
					<div class="card-body">

						<form method="POST" class="col-md-12">
							<div class="row">


								<?php include("alert.php") ?>


								<div class="form-group col-md-12">
									<label for="first_name"><i class="fa fa-user"></i>&nbsp;Entrez le nom d'utilisateur</label>

									<input type="text" name="first_name" id="first_name" class="form-control" required>

								</div>

								<div class="form-group col-md-12">
									<label for="first_name"><i class="fa fa-google"></i>&nbsp;Entrez votre adresse mail</label>

									<input type="email" name="email" id="email" class="form-control" required>

								</div>

								<div class="form-group col-md-12">
									<label for="pass"><i class="fa fa-lock"></i>&nbsp;Entrez votre mot de passe</label>

									<input type="password" name="pass" id="pass" class="form-control" required>

								</div>

								<div class="form-group col-md-12">
									<label for="oublier"><input type="checkbox" name="oublier" id="oublier" required> &nbsp;<span class="text-info">Condition et politique du site</span></label>

								</div>


								<div class="form-group col-md-12">
									<button type="submit" name="btn_register" class="btn btn-primary btn-block"><i class="fa fa-globe"></i>&nbsp; S'enregistrer</button>

								</div>


								<div class="form-group col-md-12">
									<label for="oublier">J'ai déjà un compte <a href="login.php" class="text-info"> Se connecter</a></label>

								</div>


							</div>
						</form>
						
					</div>
				</div>
			</div>
			
		</div>
		<div class="col-md-3"></div>
		
	</div>
</div>