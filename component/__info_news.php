<div class="col-md-12">
	<div class="row">
	<div class="col-4">
		<i class="fa fa-heart"></i> <a href="insert_like.php?idt=<?= $key2['idt']?>" idt="<?= $key2['idt']?>" class="text-muted link_none likes_users">

			<?php
			$c_likes = show_count_like($key2['idt'],"likes","idt");

			$c_likes_text =show_text_count_like($key2['idt'], $connected);
			 if ($c_likes !='' && $c_likes_text !='') {
			 	echo($c_likes_text." ".$c_likes);
			 }
			 else{
			 	echo("Je n'aime plus 0");
			 }

			 ?>
		</a>



		<div class="col-md-12">
			<div class="row afficher_user_like afficher_user_like_<?= $key2['idt']?>">
				<!-- bloc -->
				
				<!-- fin bloc -->
				
			</div>
		</div>




	</div>
	<div class="col-8">
		
		<div class="col-md-12 question">
			<i class="fa fa-comment"></i> <a href="javascript:void(0);" class="text-muted afficher link_none">Commentaire
				<?php
				$c_likes = show_count_like($key2['idt'],"commentaire","idt");

				
				 if ($c_likes !='') {
				 	echo($c_likes);
				 }
				 else{
				 	echo("0");
				 }

			 ?>
			</a>
		</div>

		<div class="col-md-12 reponse">

			<?php 
			$com = $db->prepare("SELECT * FROM profile_commentaire WHERE idt=:idt ORDER BY created_at DESC LIMIT 5");
			$com->execute([
				'idt'	=>	$key2['idt']
			]);
			$count_comment = $com->rowCount();
			
			if ($count_comment <=0) {
				# code...
			}
			else{

				$show_comment = $com->fetchAll();

				foreach ($show_comment as $row) {
					?>
					<!-- debit bloc -->
					<div class="col-md-12">
						<div class="row">
							<div class="col-4">
								<img src="./upload/<?= $row['image']?>" class="img img-responsive img-thumbnail avatar_user_pub">
							</div>
							<div class="col-8">
								<p>
									<strong><a href="detail_profil.php?id=<?= $row['id']?>" class="text-dark link_none"><?= $row['first_name']?> <?= $row['last_name']?></a></strong> <br>

									<span class="text-muted"><i class="fa fa-clock-o"></i> 
										<?= nl2br(substr(date(DATE_RFC822, strtotime($row['created_at'])), 0, 23));?>
									</span>
								</p>
								<p>
									<?= nl2br(substr($row['comments'], 0,200))?>... &nbsp;&nbsp;&nbsp;
									<br>

									<div class="col-md-12 form-inline">

									<a class="text-muted" href="like_commentaire.php?idcomment=<?php echo($row['idcomment']); ?>&idt=<?php echo($key2['idt']); ?>&id_user=<?php echo($row['id_user']); ?>"><i class="fa fa-heart"></i>&nbsp;

										<?php
											$c_likes_comment = show_count_like($row['idcomment'],"likes_comment","idcomment");

											
											 if ($c_likes_comment !='') {
											 	echo($c_likes_comment);
											 }
											 else{
											 	echo("0");
											 }

										 ?>
									</a>

									<?php 
									if ($_SESSION['user_connected'] == $row['id_user'] ) {
										?>
										&nbsp;&nbsp;
										<a class="text-danger" onclick="return confirm('Etes-vous sûre de vouloir supprimer votre commentaire?')" href="delete_commentaire.php?idcomment=<?php echo($row['idcomment']); ?>&idt=<?php echo($key2['idt']); ?>"><i class="fa fa-trash"></i></a>
											<?php
										}

									 ?>
										
									</div>

									
								</p>

								
								<hr>
							</div>
						</div>
					</div>
					<!-- fin bloc -->
					<?php
				}
			}


			 ?>
			

			

			<!-- debit bloc -->
			<div class="col-md-12">
				<form method="POST" action="insert_comment.php" class="row">
					<div class="col-8 form-group">
						<textarea name="comments" id="comments" class="form-control" placeholder="Quoi de new?"></textarea>
						<input value="<?= $key2['idt']?>" type="hidden" name="idt" placeholder="idt" >
					</div>
					<div class="col-4 form-group" style="margin-top: 15px;">
						<button type="submit" name="btn_comment" class="btn btn-primary btn-sm">
							<i class="fa fa-send"></i> Commenter
						</button>
					</div>
				</form>
			</div>
			<!-- fin bloc -->


		</div>
	</div>	
	</div>
</div>