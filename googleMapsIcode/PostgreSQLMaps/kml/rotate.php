<?php

$output = shell_exec('mogrify -rotate '. $_GET["rotation"] .' files/ReducedResImage.png');
echo "<pre>$output</pre>";
?>
