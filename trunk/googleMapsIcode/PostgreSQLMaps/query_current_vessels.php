<?php
//Start execution time tracker
$mtime = microtime(); 
$mtime = explode(" ",$mtime); 
$mtime = $mtime[1] + $mtime[0]; 
$starttime = $mtime; 


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

//Query statement - default statement unless user inputs custom statement
$query = "SELECT * FROM (select * from radar_vessels UNION select * from current_vessels where vesseltypeint != -1) A WHERE";
//$query = "SELECT messagetype, mmsi, navstatus, rot, sog, lon, lat, cog, true_heading, datetime, imo, vesselname, vesseltypeint, length, shipwidth, bow, stern, port, starboard, draught, destination, callsign, posaccuracy, eta, posfixtype, streamid FROM current_vessels WHERE imo != -1";

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
          //$query = $query . " AND lat > " . round($_GET["minlat"],3) . " and lon > " . round($_GET["minlon"],3) . " and lat < " .  round($_GET["maxlat"],3) . " and lon < " . round($_GET["maxlon"],3);
          $query = $query . " lat BETWEEN " . round($_GET["minlat"],3) . " AND " . round($_GET["maxlat"],3) . " AND lon BETWEEN " .  round($_GET["minlon"],3) . " AND " . round($_GET["maxlon"],3);
    }
    if(!empty($_GET["limit"])) {
       $limit = $_GET["limit"];
       $query = $query . " limit " . $limit;
    }

    //custom query, erase everything else and use this query
    if(!empty($_GET["query"])) {
       //TODO: add security checks, e.g. against "DROP TABLE *" commands
       $query = $_GET["query"];
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
$count_vessels = 0;
while (odbc_fetch_row($result)){
   $count_vessels = $count_vessels + 1;
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

echo '<xml:resultCount>';
echo '<resultcount count="' . $count_vessels . '" />';
echo '</xml:resultCount>';

echo '<xml:timetaken>';
$mtime = microtime(); 
$mtime = explode(" ",$mtime); 
$mtime = $mtime[1] + $mtime[0]; 
$endtime = $mtime; 
$totaltime = ($endtime - $starttime); 
echo '<execution time="' . $totaltime . '" />';
echo '</xml:timetaken>';
echo '</xml:result>';

// End XML file
?>

