<?php

function parseToXML($htmlStr) 
{ 
$xmlStr=str_replace('<','&lt;',$htmlStr); 
$xmlStr=str_replace('>','&gt;',$xmlStr); 
$xmlStr=str_replace('"','&quot;',$xmlStr); 
$xmlStr=str_replace("'",'&#39;',$xmlStr);
$xmlStr=str_replace("&",'&amp;',$xmlStr);
return $xmlStr; 
} 


//Keep database connection information secure
require("phpsql_dbinfo.php");


/* ************************************************** */

/* Building DSN */
$dsn =  'DRIVER={'.$odbc_driver.'};'.
		'Server='.$odbc_host.';'.
		'Database='.$odbc_database.';'.
		'uid='.$odbc_user.'; pwd='.$odbc_password;

/* Connecting */
$connection = @odbc_connect($dsn, '', '') or die('Connection error: '.htmlspecialchars(odbc_errormsg()));


/* Check connection */
if (!$connection) {
   exit("Connection Failed: " . $conn);
}

$query = "SELECT target_location_id, report_date, message_source_id, message_type, ST_y(ST_AsText(location_data)) as Lat, ST_x(ST_AsText(location_data)) as Lon FROM target_location";
if(count($_GET) > 0) //count the number of arguments
{
   /*
   if(!empty($_GET["type"]))
   {
      $type = $_GET["type"];
      if ($type == 999)
         $query = $query . " where vesseltypeint=" .$type;
      else if ($type == 70)
         $query = $query . " where vesseltypeint>=70 and vesseltypeint <=79";
      else if ($type == 80)
         $query = $query . " where vesseltypeint>=80 and vesseltypeint <=89";
      else if ($type == 60)
         $query = $query . " where vesseltypeint>=60 and vesseltypeint <=69";
      else
         $query = $query . " where vesseltypeint=" .$type;
   }*/
   if(!empty($_GET["latmin"]) && !empty($_GET["lonmin"]) &&
      !empty($_GET["latmax"]) && !empty($_GET["lonmax"]))
   {
      $query = $query . " where ST_Intersects(location_data, ST_Transform( ST_MakeEnvelope(" .
         $_GET["latmin"] . ", " . $_GET["lonmin"] . ", " . 
         $_GET["latmax"] . ", " . $_GET["lonmax"] . ", 4326),4326) )";
   }
   if(!empty($_GET["limit"]))
   {
      $limit = $_GET["limit"];
      $query = $query . " limit " . $limit;
   }
}
else
{
   $limit = 5;
   $query = "SELECT * FROM target_location limit " . $limit;
}

$result = @odbc_exec($connection, $query) or die('Query error: '.htmlspecialchars(odbc_errormsg()));;
//$result = mysql_query($query);
if (!$result) {
  die('Invalid query: ' . mysql_error());
}

header("Content-type: text/xml");

// Start XML file, echo parent node
echo '<tips>';
// Iterate through the rows, printing XML nodes for each
while (odbc_fetch_row($result)){
  // ADD TO XML DOCUMENT NODE
  echo '<ais ';
  echo 'target_location_id="' . odbc_result($result,"target_location_id") . '" ';
  echo 'report_date="' . odbc_result($result,"report_date") . '" ';
  echo 'message_source_id="' . odbc_result($result,"message_source_id") . '" ';
  echo 'message_type="' . odbc_result($result,"message_type") . '" ';
  echo 'lat="' . odbc_result($result,"lat") . '" ';
  echo 'lon="' . odbc_result($result,"lon") . '" ';
  echo '/>';
}

// End XML file
echo '</tips>';

?>

