#This is a vulnerable php file.
<?php 
	$superSecret = "!!!SECRETMESSAGE!!!";
	echo ">> ";
	$flexibleInput = fgets(STDIN);
	eval($flexibleInput);
?>
