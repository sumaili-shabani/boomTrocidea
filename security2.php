<?php
session_start();
if (!isset($_SESSION['user_connected'])) {

	header("Location:login.php");
 	# code...
 } 


 ?>