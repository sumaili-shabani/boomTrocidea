<?php 

require_once("security2.php");
require_once("db.php");
require_once("function.php");

$connected;


$first_name = '';
$last_name = '';
$email = '';
$created_at = '';
$image = '';
$sexe = '';
$bio = '';
$facebook = '';
$twitter = '';
$linkedin = '';
$adresse = '';
$tel = '';



if (isset($_SESSION['user_connected'])) {
	$connected = $_SESSION['user_connected'];

	// echo("la personne connectée:".$connected);

	$query =$db->prepare("SELECT * FROM users WHERE id=:id");
	$query->execute(array(
		'id'	=>	$connected
	));

	$result = $query->fetchAll();
	foreach ($result as $key) {

		$first_name = $key['first_name'];
		$last_name = $key['last_name'];
		$email = $key['email'];
		$created_at = $key['created_at'];
		$image = 'upload/'.$key['image'];
		$sexe = $key['sexe'];
		$bio = $key['bio'];
		$facebook = $key['facebook'];
		$twitter = $key['twitter'];
		$linkedin = $key['linkedin'];
		$adresse = $key['adresse'];
		$tel = $key['tel'];
	}



}
else{
	echo("pas de session");
}


 ?>
<!DOCTYPE html>
<html>
<head>
	<title>Bienvenu chez nous!</title>
	<?php include("_meta.php") ?>
</head>
<body>

	<!-- insertion de navbar menu -->
	<?php include("_navBar.php") ?>
	<!-- fiin insertion -->


	<div class="container" style="margin-top: 80px;">
		<div class="container-fluid">
			<!-- mes scripts commencent -->

			<?php include("list_form.php") ?>
			
			<!-- fin de mes scripts -->
		</div>
	</div>


	


	<!-- bloc footer -->
    <div style="margin-top: 100px;"></div>

    <?php include("_footer.php") ?>

    <?php include("_script.php") ?>

    <script type="text/javascript">
    	$(document).ready(function() {
    		$(document).on('keyup', '.search_text', function(event) {
    			event.preventDefault();
    			/* Act on the event */
    			var query = $(this).val();
    			var url ="search.php";
    			$.ajax({
    				url: url,
    				type:'POST',
    				data:{
    					first_name: query
    				},
    				success: function(cool){
    					$('.afficher_info').html(cool);

    				}
    			})
    			
    			
    		});
    	});
    </script>






    <!-- fin bloc footer -->


</body>
</html>