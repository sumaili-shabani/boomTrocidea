<?php

if (isset($msg_ok) !='') {
?>
<div class="col-md-12 alert alert-success">
<?php echo($msg_ok) ?>
<button class="close" data-dismiss="alert">x</button>
</div>
<?php
}
elseif(isset($msg) !=''){
?>
<div class="col-md-12 alert alert-danger">
    <?php echo($msg) ?>
    <button class="close" data-dismiss="alert">x</button>
</div>
<?php

}
else{

}

?>