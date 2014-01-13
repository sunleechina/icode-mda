<?php
//Start execution time tracker
$mtime = microtime(); 
$mtime = explode(" ",$mtime); 
$mtime = $mtime[1] + $mtime[0]; 
$starttime = $mtime; 


//-----------------------------------------------------------------------------
//Database execution
//Keep database connection information secure
require("phpsql_dbinfo.php");


/* ************************************************** */

/* Building DSN */
$dsn =  'DRIVER={'.$odbc_driver.'};'.
		'Server='.$odbc_host.';'.
		'Database='.$port_database.';'.
		'uid='.$odbc_user.'; pwd='.$odbc_password;

/* Connecting */
$connection = @odbc_connect($dsn, '', '') or die('Connection error: '.htmlspecialchars(odbc_errormsg()));

/* Check connection */
if (!$connection) {
    exit("Connection Failed: " . $conn);
}

//Query statement
$query = "SELECT main_port_name, latitude_degrees, latitude_minutes, latitude_hemisphere, longitude_degrees, longitude_minutes, longitude_hemisphere from $port_database.wpi_data";

//Count the number of arguments
/*
if(count($_GET) > 0) {
    //Bound limits
   if(!empty($_GET["minlat"]) && !empty($_GET["minlon"]) &&
      !empty($_GET["maxlat"]) && !empty($_GET["maxlon"])) {
         $query = $query . " WHERE latitude BETWEEN " . $_GET["minlat"] . " AND " . $_GET["maxlat"] . 
            " AND longitude BETWEEN " .  $_GET["minlon"] . " AND " . $_GET["maxlon"];
       }
}
else { //Fetch all ports
}
*/

//Execute the query
$result = @odbc_exec($connection, $query) or die('Query error: '.htmlspecialchars(odbc_errormsg()));;
//-----------------------------------------------------------------------------


//End execution time
$mtime = microtime(); 
$mtime = explode(" ",$mtime); 
$mtime = $mtime[1] + $mtime[0]; 
$endtime = $mtime; 
$totaltime = ($endtime - $starttime); 


// Prevent caching.
header('Cache-Control: no-cache, must-revalidate');
header('Expires: Mon, 01 Jan 1996 00:00:00 GMT');

// The JSON standard MIME header.
header('Content-type: application/json');

//echo json_encode(array(query => $query));
// Iterate through the rows, printing XML nodes for each
$count_results = 0;
$portarray = array();
while (odbc_fetch_row($result)){
   $count_results = $count_results + 1;

   //Output JSON object per row
   $port = array(port_name=>addslashes(odbc_result($result,"main_port_name")),
                 lat=>odbc_result($result,"latitude_degrees"),
                 lon=>odbc_result($result,"longitude_degrees")
   );
   array_push($portarray, $port);
}

$data = array(query => $query, resultcount => $count_results, exectime => $totaltime, ports => $portarray);
echo json_encode($data);
?>
