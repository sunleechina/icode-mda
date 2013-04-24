<?php

function parseToXML($htmlStr) { 
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

//Query statement
$query = "SELECT mmsi, messagetype, datetime as report_date, streamid as source, lat, lon, vesseltypeint, navstatus, rot, sog, cog, true_heading, imo FROM current_vessels WHERE imo != -1";

if(count($_GET) > 0) { //count the number of arguments
    /*
    if(!empty($_GET["type"])) {
       $type = $_GET["type"];
       if ($type == 999)    //catch all, display all case
          $query = $query;
       else if ($type == 70)
          $query = $query . " and vesseltypeint>=70 and vesseltypeint <=79";
       else if ($type == 80)
          $query = $query . " and vesseltypeint>=80 and vesseltypeint <=89";
       else if ($type == 60)
          $query = $query . " and vesseltypeint>=60 and vesseltypeint <=69";
       else
          $query = $query . " and vesseltypeint=" .$type;
    }
    */
    if(!empty($_GET["minlat"]) && !empty($_GET["minlon"]) &&
       !empty($_GET["maxlat"]) && !empty($_GET["maxlon"])) {
          $query = $query . " AND ST_Intersects(ST_SetSRID(ST_Point(lon,lat),4326), ST_Transform( ST_MakeEnvelope(" . 
                   $_GET["minlat"] . ", " . $_GET["minlon"] . ", " .  $_GET["maxlat"] . ", " . $_GET["maxlon"] . ", 4326),4326) )";
       }
    if(!empty($_GET["limit"])) {
       $limit = $_GET["limit"];
       $query = $query . " limit " . $limit;
    }
}
else {
    $limit = 10;
    $query = $query . " limit " . $limit;
}


$result = @odbc_exec($connection, $query) or die('Query error: '.htmlspecialchars(odbc_errormsg()));;

//$result = mysql_query($query);
if (!$result) {
    die('Invalid query: ' . mysql_error());
}



/* Output XML */
header("Content-type: text/xml");

echo '<?xml version="1.0" encoding="iso-8859-1"?>';
echo '<xml:result>';
echo '<query statement="' . htmlspecialchars($query, ENT_NOQUOTES) .'" />';
// Iterate through the rows, printing XML nodes for each
while (odbc_fetch_row($result)){
   // ADD TO XML DOCUMENT NODE
   echo '<ais ';
   echo 'report_date="' . odbc_result($result,"report_date") . '" ';
   echo 'message_source_id="' . odbc_result($result,"message_source_id") . '" ';
   echo 'messagetype="' . odbc_result($result,"messagetype") . '" ';
   echo 'mmsi="' . odbc_result($result,"mmsi") . '" ';
   echo 'lat="' . odbc_result($result,"lat") . '" ';
   echo 'lon="' . odbc_result($result,"lon") . '" ';
   echo 'vesseltypeint="' . odbc_result($result,"vesseltypeint") . '" ';
   echo 'navstatus="' . odbc_result($result,"navstatus") . '" ';
   echo 'rot="' . odbc_result($result,"rot") . '" ';
   echo 'sog="' . odbc_result($result,"sog") . '" ';
   echo 'cog="' . odbc_result($result,"cog") . '" ';
   echo 'true_heading="' . odbc_result($result,"true_heading") . '" ';
   echo 'imo="' . odbc_result($result,"imo") . '" ';
   echo '/>';
}

// End XML file
echo '</xml:result>';

?>

