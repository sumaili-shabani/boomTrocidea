<nav class="navbar navbar-expand-md navbar-light fixed-top bg-primary">
    <a class="navbar-brand" href="#"><img src="assets/images/icones/cat-img-5.jpg" class="responsive img-responsive img-thumbnail" style="width: 50px; height: 40px;"> 
        <!-- <span style="color: rgb(204, 205, 207); font-size: 16px;"><font class="text-warning">Boom</font><font class="text-info">social</font><font class="text-success">idea</font></span> -->
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my_div" aria-controls="my_div" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="my_div">
        <ul class="navbar-nav align-top mr-auto text-uppercase">
	        <li class="nav-item">
	            <a class="nav-link active" href="index.php"><i class="fa fa-home"></i> Accueil <span class="sr-only"></span></a>
	        </li>
	        <li class="nav-item">
	            <a class="nav-link" href="javascript:void(0);"><i class="fa fa-tag"></i> Trocs</a>
	        </li>
	        <li class="nav-item">
	            <a class="nav-link" href="list.php"><i class="fa fa-group"></i> Utilisateur</a>
	        </li>

	        <!-- <li class="nav-item">
	            <a class="nav-link" href="table.php"><i class="fa fa-trophy"></i> Tableau</a>
	        </li> -->


	        <?php 

	        if (isset($_SESSION['user_connected'])) {
	         ?>

	        <li class="nav-item">
	            <a class="nav-link" href="news.php"><i class="fa fa-hacker-news"></i> Infos</a>
	        </li>

	        <!-- notification connecte -->
	        <?php include("./component/__notification.php") ?>
	        <!-- fin notification onnecte -->

	        <!-- messagerie connecte -->
	        <?php include("./component/__messagerie.php") ?>
	        <!-- fin messagerie onnecte -->


	        <!-- utilisateur connecte -->
	        <li class="nav-item dropdown">
	            <a class="nav-link" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

	            	<img src="<?= $image ?>" class="responsive img-responsive img-thumbnail" style="width: 50px; height: 40px; border-radius: 100%;"> 
	            	
	            </a>
	            <div class="dropdown-menu" aria-labelledby="dropdown01">
	            <a class="dropdown-item" href="profile.php"><i class="fa fa-user"></i> Mon profile</a>
	            <a class="dropdown-item" href="basic.php"><i class="fa fa-cog"></i> Paramètre</a>
	            <a class="dropdown-item" href="news.php"><i class="fa fa-tag"></i> Publication</a>

	            <a class="dropdown-item" onclick="return(confirm('Etes-vous sûre de vouloir se deconnecter?'))"  href="logout.php"><i class="fa fa-sign-out"></i> Se deconnecter</a>


	            </div>
	        </li>
	        <!-- fin utilisateur onnecte -->

	    <?php } ?>
        </ul>
        <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2 search_text" type="text" placeholder="Recherche" aria-label="recherche">
        <button class="btn btn-outline-secondary my-2 my-sm-0" type="submit"><i class="fa fa-search"></i> recherche</button>
        </form>
    </div>
</nav>