<div class="col-md-6">
	<label for="first_name">Nom</label>
	<input type="text" name="first_name" id="first_name" class="form-control" placeholder="votre nom d'utilisateur" value="<?= $first_name ?>" required>
</div>

<div class="col-md-6">
	<label for="last_name">Postnom</label>
	<input type="text" name="last_name" id="last_name" class="form-control" placeholder="votre postnom" required value="<?= $last_name ?>" >
</div>

<div class="col-md-6">
	<label for="email">Email</label>
	<input type="email" name="email" id="email" class="form-control" placeholder="votre compte email" value="<?= $email ?>" required>
</div>

<div class="col-md-6">
	<label for="tel">Téléphone</label>
	<input type="tel" name="tel" id="tel" class="form-control" placeholder="+243817883541" value="<?= $tel ?>">
</div>

<div class="col-md-6">
	<label for="adresse">Adresse</label>
	<input type="text" name="adresse" id="adresse" class="form-control" placeholder="Votre adresse domicile" value="<?= $adresse ?>">
</div>

<div class="col-md-6">
	<label for="facebook">Facebook</label>
	<input type="url" name="facebook" id="facebook" class="form-control" placeholder="https://facebook.com/" value="<?= $facebook ?>">
</div>

<div class="col-md-6">
	<label for="twitter">Twitter</label>
	<input type="url" name="twitter" id="twitter" class="form-control" placeholder="https://twitter.com/" value="<?= $twitter ?>">
</div>

<div class="col-md-6">
	<label for="linkedin">Linkedin</label>
	<input type="url" name="linkedin" id="linkedin" class="form-control" placeholder="https://linkedin.com/" value="<?= $linkedin ?>">
</div>

<div class="col-md-12">
	<label for="bio">Biographie</label>
	<textarea name="bio" class="form-control" id="bio" placeholder="Parler un peu de vous!!!">
		<?= $bio ?>
	</textarea>
</div>

<div class="col-md-12 form-group">
    <label for="sexe">Votre sexe</label>
    <input type="radio" value="M" <?php 
    if ($sexe =="M") {
    	echo("checked");
    }
    ?> id="sexe" name="sexe" cheacked> M
    <input type="radio" value="F" id="sexe" 
    <?php 
    if ($sexe =="F") {
    	echo("checked");
    }
    ?> name="sexe"> F
</div>

<div class="col-md-12">
	<button type="submit" name="btn_edit" class="btn btn-primary pull-right">
		<i class="fa fa-edit"></i> Modifier
	</button>

</div>

