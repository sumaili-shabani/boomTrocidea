<?php 

require_once("db.php");
if (isset($_POST['btn_login'])) {
	extract($_POST);
	$nom = $user_name;
	$password = md5($pass);

	$query = $db->prepare("SELECT * FROM users WHERE(first_name=:user OR email=:user) AND passwords=:passwords");
	$query->execute([
		':user'			=>	$nom,
		':passwords'	=>	$password
	]);

	$result = $query->fetchAll();
	$count = $query->rowCount();
	if ($count <= 0) {
		$msg = "Information incorecte";
	}
	else{

		foreach ($result as $key) {
			$neme_connected = $key['first_name'];
			$id_connected = $key['id'];
			$img_connected = $key['image'];

			session_start();


			if ($key['idrole'] == 1) {
				$_SESSION['admin_connected'] = $id_connected;
				header("Location:admin.php");
			}
			elseif ($key['idrole'] == 0) {
				$_SESSION['user_connected'] = $id_connected;
				header("Location:profile.php");
			}
			else{
				header("Location:login.php");
			}

			echo($neme_connected." id:".$id_connected);
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
						<span>Connexion et authentification au système</span>
					</div>
					<div class="card-body">

						<form method="POST" class="col-md-12">
							<div class="row">


								<?php include("alert.php") ?>


								<div class="form-group col-md-12">
									<label for="user_name"><i class="fa fa-user"></i>&nbsp;Entrez le nom d'utilisateur ou adresse mail</label>

									<input type="text" name="user_name" id="user_name" class="form-control">

								</div>

								<div class="form-group col-md-12">
									<label for="pass"><i class="fa fa-lock"></i>&nbsp;Entrez votre mot de passe</label>

									<input type="password" name="pass" id="pass" class="form-control">

								</div>

								<div class="form-group col-md-12">
									<label for="oublier"><input type="checkbox" name="oublier" id="oublier"> &nbsp;<span class="text-info">Mot de passe oublié?</span></label>

								</div>


								<div class="form-group col-md-12">
									<button type="submit" name="btn_login" class="btn btn-primary btn-block"><i class="fa fa-globe"></i>&nbsp; Se connecter</button>

								</div>


								<div class="form-group col-md-12">
									<label for="oublier">Vous n'avez pas de compte? <a href="register.php" class="text-info"> Inscrivez-vous ici</a></label>

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