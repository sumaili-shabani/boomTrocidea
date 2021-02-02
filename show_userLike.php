<?php 
require_once("security2.php");
require_once("db.php");
require_once("function.php");
if (isset($_POST['idt'])) {
	$idt = $_POST['idt'];

	$query = $db->prepare("SELECT * FROM profile_like WHERE idt=:idt");
	$query->execute(array(
		'idt'	=>	$idt
	));
	$count = $query->rowCount();
	$result =$query->fetchAll();
	if ($count <= 0) {
		# code...
	}
	else{
		foreach ($result as $key) {
			?>

			<div class="col-md-12">
				<div class="row">
					<div class="col-4">
						<img src="./upload/<?php echo($key['image']); ?>" class="img img-responsive img-thumbnail avatar_user_pub">
					</div>
					<div class="col-8">
						<p>
							<strong><a href="detail_profil.php?id=<?php echo($key['id']); ?>" class="text-dark link_none"><?php echo($key['first_name']); ?>  <?php echo($key['last_name']); ?></a></strong> <br>

							<span class="text-muted"><i class="fa fa-clock-o"></i> 
								<?= nl2br(substr(date(DATE_RFC822, strtotime($key['created_at'])), 0, 23));?>
							</span>
						</p>
					
						<hr>
					</div>
					
				</div>
			</div>
			<?php
			# code...
		}
	}

	// echo "publication: ".$idt;
	# code...
}


 ?>