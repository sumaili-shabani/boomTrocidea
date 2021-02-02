<div class="col-md-12">
	<div class="row afficher_info">

		<?php 
			$query =$db->prepare("SELECT * FROM users Limit 6");
			$query->execute();

			$result = $query->fetchAll();
			$count = $query->rowCount();
			if ($count<=0) {
				# code...
			}
			else{
				
				foreach ($result as $key) {

					?>
					<?php include('./component/view_users.php') ?>
					<?php


				}
			}

		?>

		
		



	</div>
</div>