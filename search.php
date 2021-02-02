<?php 

require_once("security2.php");
require_once("db.php");
require_once("function.php");
$nom = $_POST['first_name'];
$connected;

if (isset($_SESSION['user_connected'])) {
	$connected = $_SESSION['user_connected'];

}
else{
	$connected = 0;
}


$query =$db->prepare("SELECT * FROM users WHERE first_name 
	LIKE '%".$nom."%' OR last_name 
	LIKE '%".$nom."%' Limit 6");
$query->execute();

$result = $query->fetchAll();
$count = $query->rowCount();
if ($count<=0) {
	
	?>
	<div class="col-md-12">
		<div class="row">
			<div class="col-4">
				
			</div>
			<div class="col-4">
				<img src="upload/annumation/a.gif" class="img img-responsive img-circle" style="width: 100%; height: 280px; border-radius: 100%;">
			</div>
			<div class="col-4">
				
			</div>
		</div>
	</div>
	<?php
}
else{
	
	foreach ($result as $key) {

		?>
		<?php include('./component/view_users.php') ?>
		<?php


	}
}

?>