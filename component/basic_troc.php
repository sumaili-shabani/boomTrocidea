<div class="col-md-12">
	<label for="nom">Le nom du produit</label>
	<input type="text" name="nom" id="nom" class="form-control" required placeholder="Le nom du produit">
</div>

<div class="col-md-12">
	<label for="prix">Le Prix</label>
	<input type="number" min="1" name="prix" id="prix" class="form-control" required placeholder="Le prix en dollard">
</div>


<div class="col-md-12">
	<label for="description">La description du produit</label>
	<textarea name="description" id="description" placeholder="Parler un peu de votre produit" class="form-control" required></textarea>
</div>

<div class="col-md-12">
	<label for="user_image">Selectionner l'image du produit</label>
	<input type="file" name="user_image" id="user_image" class="form-control" required>
</div>



<div class="col-md-12" style="margin-top: 10px;">
	<button type="submit" name="btn_add" class="btn btn-primary pull-right">
		<i class="fa fa-plus"></i> Ajouter votre produit
	</button>

</div>

