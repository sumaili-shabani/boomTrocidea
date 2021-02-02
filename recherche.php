<!DOCTYPE html>
<html>
<head>
	<title>Bienvenu chez nous!</title>
	<link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="assets/font-awesome/css/font-awesome.min.css">

	<link rel="shortcut Icon" type="text/css" href="assets/images/icones/address-icon.png">

	<meta name="viewport" content="widtd=device-widtd, initial-scale=1, shrink-to-fit=no">

	<meta name="robots" content="follow, all">
	<meta name="description" content="site web des echanges des idées et de trocs">
	<meta name="autdor" content="devtech">
	<meta name="keyword" content="réseau social">
	<meta charset="utf-8">
</head>
<body>

	<!-- insertion de navbar menu -->
	<?php include("_navBar.php") ?>
	<!-- fiin insertion -->


	<div class="container" style="margin-top: 80px;">
		<div class="container-fluid">
			<!-- mes scripts commencent -->
			

			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="col-md-12">
							<div class="card-title">
								<span class="text-info">
									Exercice sur la recupération de l'adresse ip et map
								</span>
							</div>

							
							<div class="col-md-12">

								<span class="text-info">
									recuparation php
								</span>
								<?php
								ob_start();
								system("ipconfig /all");
								$mycom=ob_get_contents();
								ob_clean();
								$findme = "physique";
								$pmac = strpos($mycom, $findme);
								$mac=substr($mycom,($pmac+36),17);
								echo $mac;

								



								?>
							</div>	

							<div class="col-md-12">
								<span class="text-info">
									recuparation javascript classique
								</span> <div id="list"></div> 
							</div>

							<div class="col-md-12">
								<span class="text-info">
									recuparation avec api(ip-api)
								</span> 
								<input type="text" name="ipv4" id="ipv4" class="form-control ipv4" placeholder="adresse ipv4">
							</div>
						</div>
					</div>
				</div>
			</div>


			


			


			<!-- fin de mes scripts -->
		</div>
	</div>


	


	<!-- bloc footer -->
    <div style="margin-top: 100px;"></div>

    <?php include("_footer.php") ?>


    <!-- jQuery -->
	<script src="./assets/js/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="./assets/js/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->



   

<script type="text/javascript">  
    var RTCPeerConnection = /*window.RTCPeerConnection ||*/ window.webkitRTCPeerConnection || window.mozRTCPeerConnection;  
	if (RTCPeerConnection)(function() {  
	    var rtc = new RTCPeerConnection({  
	        iceServers: []  
	    });  
	    if (1 || window.mozRTCPeerConnection) {  
	        rtc.createDataChannel('', {  
	            reliable: false  
	        });  
	    };  
	    rtc.onicecandidate = function(evt) {  
	        if (evt.candidate) grepSDP("a=" + evt.candidate.candidate);  
	    };  
	    rtc.createOffer(function(offerDesc) {  
	        grepSDP(offerDesc.sdp);  
	        rtc.setLocalDescription(offerDesc);  
	    }, function(e) {  
	        console.warn("offer failed", e);  
	    });  
	    var addrs = Object.create(null);  
	    addrs["0.0.0.0"] = false;  
	  
	    function updateDisplay(newAddr) {  
	        if (newAddr in addrs) return;  
	        else addrs[newAddr] = true;  
	        var displayAddrs = Object.keys(addrs).filter(function(k) {  
	            return addrs[k];  
	        });  
	        document.getElementById('list').textContent = displayAddrs.join(" or perhaps ") || "n/a";  
	    }  
	  
	    function grepSDP(sdp) {  
	        var hosts = [];  
	        sdp.split('\r\n').forEach(function(line) {  
	            if (~line.indexOf("a=candidate")) {  
	                var parts = line.split(' '),  
	                    addr = parts[4],  
	                    type = parts[7];  
	                if (type === 'host') updateDisplay(addr);  
	            } else if (~line.indexOf("c=")) {  
	                var parts = line.split(' '),  
	                    addr = parts[2];  
	                updateDisplay(addr);  
	            }  
	        });  
	    }  
	})();  
	else {  
	    document.getElementById('list').innerHTML = "<code>ifconfig| grep inet | grep -v inet6 | cut -d\" \" -f2 | tail -n1</code>";  
	    document.getElementById('list').nextSibling.textContent = "In Chrome and Firefox your IP should display automatically, by the power of WebRTCskull.";  
	} 

</script> 

<script type="text/javascript">
	$(document).ready(function() {
		
		var url = "http://ip-api.com/json/";
		

		fetch(url)
		.then(response => response.json())
		.then((data) => {

			var ipv4 = $('#ipv4').val();

			var ipv = data.query;

			$('#ipv4').val(ipv);
			// ipv4.val(ipv);
			console.log(ipv);
				// console.log(data.query);

			}
		);


	});
</script>

    <!-- fin bloc footer -->


</body>
</html>