 <!-- jQuery -->
<script src="./assets/js/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="./assets/js/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->

<script type="text/javascript">
	$(document).ready(function() {
		var afficher_user_like = $('.afficher_user_like');
		afficher_user_like.fadeOut(500);

		$('.likes_users').mouseover(function(event) {
			/* Act on the event */
			event.preventDefault();
			var idt = $(this).attr('idt');
			var afficher_info = $('.afficher_user_like_'+idt);
			var afficher_user_like = $('.afficher_user_like');
			var src = "./upload/annumation/a.gif";

			afficher_user_like.fadeIn(500);

			$.ajax({
				url:"show_userLike.php",
				type:"POST",
				data:{
					idt: idt
				},
				beforeSend:function()
			    {
			     $('.afficher_user_like').html('<div class="media text-muted pt-3"><img data-src="'+src+'" class="mr-2 rounded" style="width: 70%; height: 300px;" src="'+src+'" srcset="'+src+'" data-holder-rendered="true"></div>');
			    },
			    success:(data)=>{
			    	afficher_info.html(data);
			    }
			});
			// alert("boom: "+idt);


		});

		$('.likes_users').mouseout(function(event) {
			/* Act on the event */
			event.preventDefault();
			var idt = $(this).attr('idt');
			var afficher_user_like = $('.afficher_user_like');

			afficher_user_like.fadeOut(500);
			// alert("boom: "+idt);


		});
	});
</script>