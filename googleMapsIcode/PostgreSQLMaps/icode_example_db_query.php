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


/* Connection data */
$odbc_driver      = 'PostgreSQL Unicode(x64)';
$odbc_database    = 'YOURTABLENAME';
$odbc_host        = 'localhost';
$odbc_user        = 'postgres';
$odbc_password    = 'YOURPASSWORD';


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

if(count($_GET) > 0)
{
   $limit = $_GET["limit"];
   $type = $_GET["type"];
}

// Select all the rows in the markers table
$query = "SELECT * FROM ter_20120130 limit 50";
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
  echo 'key_column="' . odbc_result($result,"key_column") . '" ';
  echo 'messagetype="' . odbc_result($result,"messagetype") . '" ';
  echo 'mmsi="' . odbc_result($result,"mmsi") . '" ';
  echo 'navstatus="' . odbc_result($result,"navstatus") . '" ';
  echo 'rot="' . odbc_result($result,"rot") . '" ';
  echo 'sog="' . odbc_result($result,"sog") . '" ';
  echo 'lon="' . odbc_result($result,"lon") . '" ';
  echo 'lat="' . odbc_result($result,"lat") . '" ';
  echo 'cog="' . odbc_result($result,"cog") . '" ';
  echo 'true_heading="' . odbc_result($result,"true_heading") . '" ';
  echo 'datetime="' . odbc_result($result,"datetime") . '" ';
  echo 'imo="' . odbc_result($result,"imo") . '" ';
  echo 'vesselname="' . odbc_result($result,"vesselname") . '" ';
  echo 'vesseltypeint="' . odbc_result($result,"vesseltypeint") . '" ';
  echo 'length="' . odbc_result($result,"length") . '" ';
  echo 'shipwidth="' . odbc_result($result,"shipwidth") . '" ';
  echo 'bow="' . odbc_result($result,"bow") . '" ';
  echo 'stern="' . odbc_result($result,"stern") . '" ';
  echo 'port="' . odbc_result($result,"port") . '" ';
  echo 'starboard="' . odbc_result($result,"starboard") . '" ';
  echo 'draught="' . odbc_result($result,"draught") . '" ';
  echo 'destination="' . odbc_result($result,"destination") . '" ';
  echo 'callsign="' . odbc_result($result,"callsign") . '" ';
  echo 'posaccuracy="' . odbc_result($result,"posaccuracy") . '" ';
  echo 'eta="' . odbc_result($result,"eta") . '" ';
  echo 'posfixtype="' . odbc_result($result,"posfixtype") . '" ';
  echo 'streamid="' . odbc_result($result,"streamid") . '" ';
  echo '/>';
}

// End XML file
echo '</tips>';

?>

