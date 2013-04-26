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

//Query statement
$query = "SELECT mmsi, lon, lat, datetime FROM (SELECT * FROM ter_20130401 UNION SELECT * FROM ter_20130402 UNION SELECT * FROM ter_20130403 UNION SELECT * FROM ter_20130404) A WHERE messagetype != 5 AND messagetype != 24 AND mmsi = ";
//$query = "SELECT mmsi, lon, lat, datetime FROM (SELECT * FROM ter_20130401 UNION SELECT * FROM ter_20130402 UNION SELECT * FROM ter_20130403 UNION SELECT * FROM ter_20130404 UNION SELECT * FROM ter_20130405 UNION SELECT * FROM ter_20130406 UNION SELECT * FROM ter_20130407 UNION SELECT * FROM ter_20130408 UNION SELECT * FROM ter_20130409 UNION SELECT * FROM ter_20130410) A WHERE messagetype != 5 AND messagetype != 24 AND mmsi = ";
//$query = "SELECT mmsi, lon, lat, datetime FROM ter_20130401 A WHERE messagetype != 5 AND messagetype != 24 AND mmsi = ";

if(count($_GET) > 0) { //count the number of arguments
    if(!empty($_GET["mmsi"])) {
      $query = $query . $_GET["mmsi"];
    }

    //Bound limits not used for track queries
    /*
    if(!empty($_GET["minlat"]) && !empty($_GET["minlon"]) &&
       !empty($_GET["maxlat"]) && !empty($_GET["maxlon"])) {
          $query = $query . " AND lat > " . $_GET["minlat"] . " and lon > " . $_GET["minlon"] . " and lat < " .  $_GET["maxlat"] . " and lon < " . $_GET["maxlon"];
       }
     */

    //Order track by descending time
    $query = $query . " ORDER BY datetime DESC";

    //Add a limit if chosen
    if(!empty($_GET["limit"])) {
       $limit = $_GET["limit"];
       $query = $query . " LIMIT " . $limit;
    }
}
else {   //This case should not happen for track fetching (user must supply MMSI for query)
    $limit = 10;
    $query = $query . " 1193046";
    $query = $query . " ORDER BY datetime DESC";
    $query = $query . " LIMIT " . $limit;
}

$result = @odbc_exec($connection, $query) or die('Query error: '.htmlspecialchars(odbc_errormsg()));;

if (!$result) {
    die('Invalid query: ' . mysql_error());
}



/* Output XML */
header("Content-type: text/xml");

echo '<?xml version="1.0" encoding="iso-8859-1"?>';
echo '<xml:result>';
echo '<query statement="' . htmlspecialchars($query, ENT_NOQUOTES) .'" />';
// Iterate through the rows, printing XML nodes for each
$count_results = 0;
while (odbc_fetch_row($result)){
   $count_results = $count_results + 1;

   // ADD TO XML DOCUMENT NODE
   echo '<ais ';
   echo 'mmsi="' . odbc_result($result,"mmsi") . '" ';
   echo 'lon="' . addslashes(odbc_result($result,"lon")) . '" ';
   echo 'lat="' . addslashes(odbc_result($result,"lat")) . '" ';
   echo 'datetime="' . odbc_result($result,"datetime") . '" ';
   echo '/>';
}

echo '<xml:resultCount>';
echo '<resultcount count="' . $count_results . '" />';
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

