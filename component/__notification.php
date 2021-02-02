<?php 

$select_not = $db->prepare("SELECT * FROM notification WHERE id_recever=:id_recever");
$select_not->execute([
	':id_recever'	=>	$_SESSION['user_connected']
]);
$c_not = $select_not->rowCount();
if ($c_not <=0) {
	$nombre_notification =0;
}
else{
	$nombre_notification =$c_not;
}

 ?>

<li class="nav-item dropdown">
    <a class="nav-link" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

    	<i class="fa fa-bell"></i><sup><span class="badge badge-danger"><?php echo $nombre_notification; ?></span></sup>
    	
    </a>
    <div class="dropdown-menu" aria-labelledby="dropdown01">

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
			<a class="dropdown-item" href="<?php echo($not['url']); ?>"><i class="<?php echo($not['icone']); ?>"></i> <?php echo(substr($not['message'], 0,28)); ?> ...</a>
			<?php
		}

		?>
		<a class="dropdown-item text-center" href="notification_user.php"><i class="fa fa-eye"></i> voir les notification</a>
		<?php 

	}
	



    ?>




    
    


    </div>
</li>