<?php 
include('db.php');

function upload_image()
{
	if(isset($_FILES["user_image"]))
	{

		$extension = explode('.', $_FILES['user_image']['name']);
		$new_name = rand() . '.' . $extension[1];
		$destination = './upload/' . $new_name;
		move_uploaded_file($_FILES['user_image']['tmp_name'], $destination);
		return $new_name;

		
	}
}

function upload_product()
{
	if(isset($_FILES["user_image"]))
	{

		$extension = explode('.', $_FILES['user_image']['name']);
		$new_name = rand() . '.' . $extension[1];
		$destination = './upload/product/' . $new_name;
		move_uploaded_file($_FILES['user_image']['tmp_name'], $destination);
		return $new_name;

		
	}
}

function show_number_count($id){

	include('db.php');
	$total;
	
	try {

		$query = $db->prepare("SELECT SUM(montant) AS total FROM compte WHERE id_user=:id");
		$query->execute([
			'id'	=>	$id
		]);
		$select = $query->rowCount();
		if ($select<=0) {
			$total = 0;
			return $total;
		}
		else{
			$result = $query->fetchAll();
			foreach ($result as $key) {
				$total = $key['total'];

				return $total;
			}
		}

		
		
	} catch (PDOException $e) {
		die("impossible de returner le montant :".$e->getMessage());
	}
}

function show_count_like($idt,$table,$colone){

	include('db.php');
	$total;
	
	try {

		$query = $db->prepare("SELECT COUNT(*) AS total FROM ".$table." WHERE ".$colone."=:idt");
		$query->execute([
			'idt'	=>	$idt
		]);
		$select = $query->rowCount();
		if ($select<=0) {
			$total = 0;
			return $total;
		}
		else{
			$result = $query->fetchAll();
			foreach ($result as $key) {
				$total = $key['total'];

				return $total;
			}
		}

		
		
	} catch (PDOException $e) {
		die("impossible de returner le montant :".$e->getMessage());
	}
}


function show_text_count_like($idt, $id_user){

	include('db.php');
	$total = "";
	
	try {

		$query = $db->prepare("SELECT * FROM likes WHERE idt=:idt AND id_user=:id_user");
		$query->execute([
			'idt'		=>	$idt,
			'id_user'	=>	$id_user
		]);
		$select = $query->rowCount();
		if ($select<=0) {
			$total = "j'aime";
			return $total;
		}
		else{
			$result = $query->fetchAll();
			foreach ($result as $key) {
				$total = "je n'aime plus";

				return $total;
			}
		}

		
		
	} catch (PDOException $e) {
		die("impossible de returner le montant :".$e->getMessage());
	}
}



function show_name_user($id){

	include('db.php');
	$total;
	
	try {

		$query = $db->prepare("SELECT first_name FROM users WHERE id=:id");
		$query->execute([
			'id'	=>	$id
		]);
		$select = $query->rowCount();
		if ($select<=0) {
			
		}
		else{
			$result = $query->fetchAll();
			foreach ($result as $key) {
				$total = $key['first_name'];

				return $total;
			}
		}

		
		
	} catch (PDOException $e) {
		die("impossible de returner le montant :".$e->getMessage());
	}
}






?>