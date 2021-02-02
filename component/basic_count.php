<div class="col-md-12">
	<div class="row">

		<div class="col-md-6">

			<div class="card">
				<div class="card-header text-center">
					Mon compte en dollards
				</div>  
				<div class="card-body">
					<div class="col-md-12">
						<div class="row">
							<div class="col-4"></div>
							<div class="col-4">
								<i class="fa fa-dollar fa-lg" style="font-size: 30px;" ></i>
								<hr>
							</div>

							<div class="col-4">
								<i class="fa fa-pie-chart fa-lg" style="font-size: 60px;"></i>
							</div>
						</div>
					</div>

					

					<div class="col-md-12">
						<div class="row">
							<div class="col-2"></div>
							<div class="col-8 card">
								<span class="card-body" style="font-size: 30px;">
									<?php 
									if ($total !='') {
										echo($total);
									}
									else{
										$total = 0;
										echo($total);
									}

									 ?></span>
							</div>
							<div class="col-2"></div>
						</div>
					</div>


				</div>
			</div> 
			
		</div>

		<div class="col-md-6">
			
		</div>


		
	</div>
</div>