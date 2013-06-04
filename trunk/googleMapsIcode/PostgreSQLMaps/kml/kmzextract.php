<?php
//ini_set('display_errors',1);
//error_reporting(E_ALL);

require('pclzip.lib.php');

echo 'Filename: '.$_FILES['file']['name'].'<br>';
   
if( $_FILES['file']['name'] != "" )
{
   //Move the uploaded file from temporary location to webserver location
   if (move_uploaded_file($_FILES["file"]["tmp_name"], "C:/pgsql/UniServer/www/ICODEMDAMaps/kml/".$_FILES["file"]["name"] )) {

//Try to unzip the file ----------------------------------------------------------------
$unzip = $_FILES["file"]["name"];
$basedir = "C:/pgsql/UniServer/www/ICODEMDAMaps/kml/";
$basedir = str_replace('\\','/',$basedir);

if (is_file($unzip)) {
	$zip = new PclZip($unzip);
	if (($list = $zip->listContent()) == 0) {
      echo 'Error unzipping file';
	}
	
	$fold = 0;
	$fil = 0;

   //Delete existing files
   $dfiles = glob($basedir.'/*'); // get all file names
   foreach($dfiles as $file){ // iterate files
   
      //Delete usual 'doc.kml' file
      //echo strtolower(basename($file)) . '<br>';
      if(is_file($file) && strtolower(basename($file)) == 'doc.kml') {
         //echo " - deleted file!!!<br>";
         unlink($file); // delete file
      }

      //Delete usual 'files' directory
      if(is_dir($file) && strtolower(basename($file)) == 'files') {
         //echo 'Entering files<br>';
         $dirfiles = glob($basedir.'\files\*');
         foreach($dirfiles as $dirfile){
            //echo '  ' . $dirfile . '<br>';
            if(is_file($dirfile)) {
               unlink($dirfile);
            }
         }
         rmdir($file);
      }
   }

   //Actually do the unzipping here!
   $zip->extract('');
}
//Done unzipping ----------------------------------------------------------------
unlink($unzip);

      echo json_encode(array('result'=>'success'));
   }
}
else
{
    die("No file specified!");
}
?>


