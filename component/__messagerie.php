<?php 

$select_not = $db->prepare("SELECT * FROM messagerie WHERE id_recever=:id_recever");
$select_not->execute([
	':id_recever'	=>	$_SESSION['user_connected']
]);
$c_not = $select_not->rowCount();
if ($c_not <=0) {
	$nombre_de_message =0;
}
else{
	$nombre_de_message =$c_not;
}

 ?>

<li class="nav-item dropdown">
    <a class="nav-link" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

    	<i class="fa fa-comment"></i><sup><span class="badge badge-danger"><?php echo $nombre_de_message; ?></span></sup>
    	
    </a>
    <div class="dropdown-menu" aria-labelledby="dropdown01">

    <?php 

    $select_not = $db->prepare("SELECT * FROM profile_message_notification WHERE id_recever=:id_recever ORDER BY created_at DESC LIMIT 10");
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
			<a class="dropdown-item" href="chat.php?id_user=<?=$_SESSION['user_connected']?>&id_recever=<?= $not['id_user'] ?>">

				<img src="./upload/<?=$not['image'] ?>" class="img img-responsive img-thumbnail" style="width: 30px;height: 30px; border-radius: 50%;">

			 <?php echo(substr($not['message'], 0,28)); ?> ...</a>
			<?php
		}

		?>
		<a class="dropdown-item text-center" href="message_user.php"><i class="fa fa-eye"></i> voir les messages</a>
		<?php 

	}
	



    ?>




    
    


    </div>
</li>