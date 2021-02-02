<?php
session_start();
if (!isset($_SESSION['admin_connected'])) {

	header("Location:login.php");
 	# code...
 } 
 


 ?>
 