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
$query = "SELECT messagetype, mmsi, navstatus, rot, sog, lon, lat, cog, true_heading, datetime, imo, vesselname, vesseltypeint, length, shipwidth, bow, stern, port, starboard, draught, destination, callsign, posaccuracy, eta, posfixtype, streamid FROM current_vessels WHERE imo != -1";

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
//          $query = $query . " AND ST_Within(ST_SetSRID(ST_Point(lon,lat), 4326), ST_MakeEnvelope(" . $_GET["minlat"] . ", " . $_GET["minlon"] . ", " .  $_GET["maxlat"] . ", " . $_GET["maxlon"] . ", 4326))";
          $query = $query . " AND lat > " . $_GET["minlat"] . " and lon > " . $_GET["minlon"] . " and lat < " .  $_GET["maxlat"] . " and lon < " . $_GET["maxlon"];
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
   echo 'messagetype="' . odbc_result($result,"messagetype") . '" ';
   echo 'mmsi="' . odbc_result($result,"mmsi") . '" ';
   echo 'navstatus="' . odbc_result($result,"navstatus") . '" ';
   echo 'rot="' . odbc_result($result,"rot") . '" ';
   echo 'sog="' . odbc_result($result,"sog") . '" ';
   echo 'lon="' . addslashes(odbc_result($result,"lon")) . '" ';
   echo 'lat="' . addslashes(odbc_result($result,"lat")) . '" ';
   echo 'cog="' . odbc_result($result,"cog") . '" ';
   echo 'true_heading="' . odbc_result($result,"true_heading") . '" ';
   echo 'datetime="' . odbc_result($result,"datetime") . '" ';
   echo 'imo="' . odbc_result($result,"imo") . '" ';
   echo 'vesselname="' . htmlspecialchars(odbc_result($result,"vesselname")) . '" ';
   echo 'vesseltypeint="' . odbc_result($result,"vesseltypeint") . '" ';
   echo 'length="' . odbc_result($result,"length") . '" ';
   echo 'shipwidth="' . odbc_result($result,"shipwidth") . '" ';
   echo 'bow="' . odbc_result($result,"bow") . '" ';
   echo 'stern="' . odbc_result($result,"stern") . '" ';
   echo 'port="' . odbc_result($result,"port") . '" ';
   echo 'starboard="' . odbc_result($result,"starboard") . '" ';
   echo 'draught="' . odbc_result($result,"draught") . '" ';
   echo 'destination="' . htmlspecialchars(odbc_result($result,"destination")) . '" ';
   echo 'callsign="' . htmlspecialchars(odbc_result($result,"callsign")) . '" ';
   echo 'posaccuracy="' . odbc_result($result,"posaccuracy") . '" ';
   echo 'eta="' . odbc_result($result,"eta") . '" ';
   echo 'posfixtype="' . odbc_result($result,"posfixtype") . '" ';
   echo 'streamid="' . htmlspecialchars(odbc_result($result,"streamid")) . '" ';
   echo '/>';
}

// End XML file
echo '</xml:result>';

?>

