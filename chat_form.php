<div class="col-md-12">
		<div class="row">								 
		<div class="col-md-12">

			<!-- DIRECT CHAT -->
            <div class="card direct-chat direct-chat-primary">
              <div class="card-header bg-primary">
                <h5 class="card-title text-center">Discution instantanée</h5>

                <div class="col-md-12 text-center">
                	<?= (isset($msg2))? '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button><small> '.$msg2.' </small></div>' : ''; ?>

	         		<?= (isset($msg22))? '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button><small> '.$msg22.' </small></div>' : ''; ?>
                </div>

                
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <!-- Conversations are loaded here -->
                <div class="direct-chat-messages">


                	<?php

                	$id_recever;

                	if (isset($_GET['id_recever'])) {
                	 	$id_recever= $_GET['id_recever'];
                	} 

	            	

	            	$q=$db->prepare("SELECT id_user,id_recever, messagerie.created_at, users.first_name,users.last_name, users.image, message FROM messagerie 
	                inner join 
	                users on users.id=messagerie.id_user WHERE (id_user=:id_recever AND id_recever=:id_user)
	                OR (id_recever=:id_recever2 AND id_user=:id_user2)
	                 ORDER BY created_at ASC");
	            	$q->execute(array(
	                    'id_recever'=>$id_recever,
	                    'id_user'=>$connected,
	            		'id_recever2'=>$id_recever,
	                    'id_user2'=>$connected
	            	));
	            	$count=$q->rowCount();
	            	if ($count<=0) {
	            		// echo("pas trouvé");
	            	}
	            	else{

	            		while ($data = $q->fetch()) {
	            			?>

	            			<!-- Message. Default to the left -->
			                  <div class="<?= ($data['id_user'] == $connected) ? 'direct-chat-msg right' : 'direct-chat-msg' ?>">

			                    <div class="direct-chat-infos clearfix">
			                      <span class="direct-chat-name float-left"><?php echo($data['first_name']) ?> <?php echo($data['last_name']) ?></span>
			                      <span class="direct-chat-timestamp float-right"><?php echo substr(date(DATE_RFC822, strtotime($data['created_at'])), 0, 23); ?></span>
			                    </div>
			                    <!-- /.direct-chat-infos -->
			                    <img class="direct-chat-img" src="upload/<?php echo($data['image']) ?>" alt="message user image">
			                    <!-- /.direct-chat-img -->
			                    <div class="direct-chat-text">
			                      <?php 
                                    echo(nl2br($data['message']));
                                   ?>
			                    </div>
			                    <!-- /.direct-chat-text -->
			                  </div>
			                  <!-- /.direct-chat-msg -->

	            			

	            			<?php
	            		}
	            	}


	            	 ?>


                  


                 

                </div>
                <!--/.direct-chat-messages-->

               
              </div>
              <!-- /.card-body -->
              <div class="card-footer bg-primary">
                <form action="#" method="post">
                  <div class="col-md-12">

                  	<div class="row">
                  		<div class="col-md-10">
                  			<textarea class="form-control" id="Message_text" name="Message_text" placeholder="Quoi de news?">
                  		
		                  	</textarea>
		                    

		                    
                  		</div>
                  		<div class="col-md-2" style="margin-top: 8px;">
                  			<span class="input-group-append">
		                      <button type="submit" name="envoyer_message" class="btn btn-primary"><i class="fa fa-send"></i></button>
		                    </span>
                  		</div>
                  	</div>
                  </div>
                </form>
              </div>
              <!-- /.card-footer-->
            </div>
            <!--/.direct-chat -->



			
		</div><!--col-md-6-->
	</div>		
		
	</div><!--col-md-9-->