<?php 

$select_not = $db->prepare("SELECT * FROM notification WHERE id_recever=:id_recever");
$select_not->execute([
	':id_recever'	=>	$_SESSION['user_connected']
]);
$c_not = $select_not->rowCount();
if ($c_not <=0) {
	$nombre_notification =0;
	$not_plus = "notification";
}
else{
	$nombre_notification =$c_not;
	$not_plus = "notifications";
}

 ?>

 <div class="col-md-12  col-sm-12 col-lg-12">
 	<div class="row">
 		<div class="col-md-12 text-center">
 			vous avez <?php echo $nombre_notification.' '.$not_plus; ?> 
 		</div>

 		<?php 

	    $select_not = $db->prepare("SELECT * FROM notification WHERE id_recever=:id_recever ORDER BY created_at DESC LIMIT 10");
		$select_not->execute([
			':id_recever'	=>	$_SESSION['user_connected']
		]);
		$n_not = $select_not->rowCount();
		if ($n_not <= 0) {
			# code...
		}
		else{

			foreach ($select_not->fetchAll() as $not) {
				?>
				<!-- bloc -->
		 		<div class="col-md-12">
		 			<div class="row">
		 				<div class="col-7">
		 					<?php echo($not['message']); ?>
		 				</div>
		 				<div class="col-2">
		 					<a class="text-muted" href="<?php echo($not['url']); ?>"><i class="<?php echo($not['icone']); ?>"></i> #voir</a>
		 				</div>
		 				<div class="col-3">
		 					<a class="text-muted" onclick="return confirm('Etes-vous sûre de vouloir la supprimer?')" href="delete_notification.php?idnot=<?php echo($not['idnot']); ?>"><i class="fa fa-trash"></i>supprimer</a>
		 				</div>
		 			</div>
		 		</div>
		 		<!-- fin bloc -->

				<?php
			}

			
		}
		



	    ?>

 		
 	</div>
 </div>



    