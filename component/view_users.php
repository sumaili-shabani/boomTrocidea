<!-- debit bloc -->
<div class="col-md-6" style="margin-top: 10px;">
	<div class="col-md-12">
		<div class="row">
			<div class="col-4">

				<img src="upload/<?php echo($key['image']) ?>" class="img-responsive img-thumbnail">
			</div>

			<div class="col-8">

				<span class="text-muted form-group">
					<strong><i class="fa fa-user"></i>&nbsp;Nom:</strong> <?php echo($key['first_name']) ?></span> <br>

				<span class="text-muted form-group">
					<strong><i class="fa fa-user"></i>&nbsp;Postnom:</strong> <?php echo($key['last_name']) ?>								</span><br>

				<span class="text-muted form-group">
					<strong><i class="fa fa-male">&nbsp;</i>Sexe:</strong> <?php echo($key['sexe']) ?>							</span><br>

				<span class="text-muted form-group">
					<strong><i class="fa fa-google"></i>&nbsp;Email:</strong> <?php echo($key['email']) ?>									</span><br>

				<span class="text-muted form-group">
					<strong><i class="fa fa-phone"></i>&nbsp;Téléphone:</strong> <?php echo($key['tel']) ?>									</span><br>

				<span class="text-muted form-group">
					<strong><i class="fa fa-map-marker"></i>&nbsp;Adresse:</strong> 
					<?php echo($key['adresse']) ?>								</span><br>

				<span class="text-muted form-inline">
					<a href="<?php echo($key['facebook']) ?>" target="_blank" class="text-info mr-3"><i class="fa fa-facebook"></i></a>
					<a href="<?php echo($key['twitter']) ?>" target="_blank" class="text-info mr-3"><i class="fa fa-twitter"></i></a>
					<a href="<?php echo($key['linkedin']) ?>" target="_blank" class="text-info mr-3"><i class="fa fa-linkedin"></i></a>
				</span><br>
				
			</div>


			<div class="col-12">
				<span class="text-muted form-group">
					<strong><i class="fa fa-tag"></i>i&nbsp;Biographie:</strong> <?php echo($key['bio']) ?>	

					<?php 
					if ($key['id'] != $connected) {
						# code...
						?>
						<div class="col-md-12 text-center">
							<a class="btn btn-primary btn-sm text-center" href="chat.php?id_user=<?php echo($connected) ?>&id_recever=<?php echo($key['id']) ?>">
								<i class="fa fa-envelope"></i> Chater avec 
								<?php echo($key['first_name']) ?>
							</a>
						</div>	
						<?php
					}
					else{

						?>
						<div class="col-md-12 text-center">
							<a class="btn btn-warning btn-sm text-center" href="profile.php">
								<i class="fa fa-user"></i> Voir mon profile 
								
							</a>
						</div>	
						<?php

					}

					 ?>


													
					


				</span><br>
				<hr>
			</div>


		</div>
	</div>
</div>
<!-- fin bloc -->