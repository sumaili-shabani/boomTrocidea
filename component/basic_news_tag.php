
<?php 

$query2 =$db->prepare("SELECT * FROM profile_publication WHERE idt=".$_GET['idt']."  limit 1");
	$query2->execute();

	$result2 = $query2->fetchAll();
	foreach ($result2 as $key2) {

		$idt = $key2['idt'];
		$id_user = $key2['id_user'];
		$nom = $key2['nom'];
		$photo = $key2['photo'];
		$created_at = $key2['created_at'];
		$image = 'upload/'.$key2['image'];
		$photo = 'upload/product/'.$key2['photo'];
		$prix = $key2['prix'];
		$first_name = $key2['first_name'];
		$last_name = $key2['last_name'];
		$email = $key2['email'];
		$description = $key2['description'];
		

		?>

		<div class="col-md-12">
			<div class="row">
				
				<div class="col-12">

					<div class="col-md-12">
						<div class="row">
							<div class="col-8">
								<img src="<?= $photo ?>" class="img img-thumbnail img-respomsive">
							</div>
							<div class="col-4">
								<span class="text-info text-center title_prix"><?= $key2['prix'] ?> $</span>
							</div>
						</div>

						
						

					</div>
					<div class="col-md-12">
						<strong>

							<a href="detail_profil.php?id=<?= $key2['id_user'] ?>" class="text-dark link_none">
								<img src="<?= $image ?>" class="img img-circle img-respomsive avatar_user_pub"> <?= $key2['nom'] ?> 
								<span class="text-muted">
									<i class="fa fa-clock-o">
										<?= nl2br(substr(date(DATE_RFC822, strtotime($key2['created_at'])), 0, 23));?>
									</i>
								</span>
							</a>
							 
						</strong>
					<p>
						<?= nl2br(substr($key2['description'], 0,300)) ?>...
						
					</p>
					</div>
					<?php include("__info_news.php") ?>
				</div>
			</div>

			<hr>
		</div>


		<?php
		
	}


 ?>

