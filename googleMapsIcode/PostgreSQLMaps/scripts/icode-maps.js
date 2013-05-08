/**
 * @name ICODE-MDA Maps
 * @author Sparta Cheung, Bryan Bagnall
 * @fileoverview
 * Uses the Google Maps API to display AIS points at their reported locations
 */

/* -------------------------------------------------------------------------------- */
/**
 *  Global objects 
 */
var map;
var markerArray;
var trackline;
var tracklineIcons;
//Viewing bounds objects
var queryBounds;
var expandFactor = 0.05;
//Marker timing objects
var markerMouseoutTimeout;
var trackMouseoverTimeout;
//Cluster objects
var CLUSTER = true;  //toggle this for CLUSTERing
var markerClusterer;
var mcOptions = {
               gridSize: 60, 
               minimumClusterSize: 50, 
               averageCenter: false
            };
//Track line options
var tracklineIconsOptions = {
               path:          'M -1,0 0,-1 1,0 0,1 z',
               strokeColor:   '#FFFFFF',
               fillColor:     '#FFFFFF',
               //strokeColor:   '#F00',
               //fillColor:     '#F00',
               fillOpacity:   1
            };

var tracklineOptions = {
               strokeColor:   '#00FF25',
               strokeOpacity: 0.7,
               strokeWeight:  3,
            };
//Weather layer objects
var weatherLayer;
var cloudLayer;
//Heatmap objects
var HEATMAP = true;
var heatmapLayer;
//Other WMS layers
var openlayersWMS;
var wmsOptions = {
      alt: "OpenLayers",
      getTileUrl: WMSGetTileUrl,
      isPng: false,
      maxZoom: 17,
      minZoom: 1,
      name: "OpenLayers",
      tileSize: new google.maps.Size(256, 256)
   };
//Shape drawing objects
var selectedShape;
//KML objects
var KML = false;

/* -------------------------------------------------------------------------------- */
/** Initialize, called on main page load
*/
function initialize() {
   //Set up map properties
   //var centerCoord = new google.maps.LatLng(0,0);
   //var centerCoord = new google.maps.LatLng(32.72,-117.2319);   //Point Loma
   var centerCoord = new google.maps.LatLng(6.0719,1.3728);   //Lome, Togo

   var mapOptions = {
      //zoom:              5,
      zoom:              11,
      center:            centerCoord,
      scaleControl:      true,
      streetViewControl: false,
      overviewMapControl:true,
      mapTypeId:         google.maps.MapTypeId.ROADMAP,
      mapTypeControlOptions: {
         mapTypeIds: [google.maps.MapTypeId.ROADMAP, 
                         google.maps.MapTypeId.SATELLITE, 
                         google.maps.MapTypeId.HYBRID, 
                         google.maps.MapTypeId.TERRAIN,
                         'OpenLayers'
                         ],
				style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR, //or drop-down menu
			}
	};

	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

   //Set default map layer
   map.setMapTypeId(google.maps.MapTypeId.ROADMAP);

   //Clear marker array
   markerArray = [];
   trackline = new google.maps.Polyline();
   tracklineIcons = [];

   //Add drawing toolbar
   addDrawingManager();

   //Map dragged then idle listener
   google.maps.event.addListener(map, 'idle', function() {
      google.maps.event.trigger(map, 'resize'); 
      var idleTimeout = window.setTimeout(
         function() {
            getCurrentAISFromDB(map.getBounds(), null);
         }, 
         2000);   //milliseconds to pause after bounds change

      google.maps.event.addListenerOnce(map, 'bounds_changed', function() {
         window.clearTimeout(idleTimeout);
      });
   });

   //Latlog indicator for current mouse position
   google.maps.event.addListener(map,'mousemove',function(event) {
      document.getElementById('latlong').innerHTML = 
            Math.round(event.latLng.lat()*10000000)/10000000 + ', ' + Math.round(event.latLng.lng()*10000000)/10000000
   });

   //TODO: TEST WMS layers
   addWmsLayers();
   //map.setMapTypeId('OpenLayers');
   //TEST
   
   //Cluster overlay layer
   if (CLUSTER) {
   	markerClusterer = new MarkerClusterer(map, [], mcOptions);
   }

   //KML overlay layer
   if (KML) {
      showKML();
   }
}

/* -------------------------------------------------------------------------------- */
function enteredQuery() {
   if (event.which == 13) {
      var entered_query = document.getElementById("query_input").value;

      //Trim white space
      $.trim(entered_query);

if (typeof String.prototype.startsWith != 'function') {
  // see below for better implementation!
  String.prototype.startsWith = function (str){
    return this.indexOf(str) == 0;
  };
}

      if (entered_query.startsWith('SELECT')) {
         getCurrentAISFromDB(map.getBounds(), entered_query);
      }
      else {
         getCurrentAISFromDB(map.getBounds(), entered_query);
      }
   }
}

/* -------------------------------------------------------------------------------- */
function clearTrack() {
   trackline.setMap(null);
   for (var i=0; i < tracklineIcons.length; i++) {
      var trackIcon = tracklineIcons.pop()
      trackIcon.setMap(null);
      trackIcon = null;
   }
   tracklineIcons = [];
}

/* -------------------------------------------------------------------------------- */
/** 
 * Get AIS data from XML, which is from database, with bounds 
 */
function getCurrentAISFromDB(bounds, customQuery) {
/*
var rectangle = new google.maps.Rectangle({
    strokeColor: '#ffffff',
    strokeOpacity: 1,
    strokeWeight: 2,
    fillColor: '#FFFFFF',
    fillOpacity: 1,
    map: map,
    bounds: new google.maps.LatLngBounds(
      new google.maps.LatLng(5.9,1.15),
      new google.maps.LatLng(6.1,1.17))
  });

var iconColor = getIconColor(989, null);
var myLatLng = new google.maps.LatLng(6.0, 1.16);
console.debug(iconColor);
var mark = new google.maps.Marker({
    position: myLatLng,
    map: map,
    icon: {
       path:        'M 0,8 4,8 0,-8 -4,8 z',
       strokeColor: '#000000',
       fillColor:   iconColor,
       fillOpacity: 0.6,
       rotation:    90
    }
});
*/

   //Set buffer around map bounds to expand queried area slightly outside viewable area
   var latLonBuffer = expandFactor * map.getZoom();

   var ne = bounds.getNorthEast();
   var sw = bounds.getSouthWest();

   var viewMinLat = sw.lat();
   var viewMaxLat = ne.lat();
   var viewMinLon = sw.lng();
   var viewMaxLon = ne.lng();

   var minLat = viewMinLat - latLonBuffer;
   var maxLat = viewMaxLat + latLonBuffer;
   var minLon = viewMinLon - latLonBuffer;
   var maxLon = viewMaxLon + latLonBuffer;

   //Set up queryBounds, which is extended initial or changed view bounds
   if (queryBounds == null) {
      //Initialize queryBounds if first time running
      queryBounds = new google.maps.LatLngBounds(
            new google.maps.LatLng(minLat, minLon), 
            new google.maps.LatLng(maxLat, maxLon));
   }
   else {
      if (customQuery == null && queryBounds.contains(ne) && queryBounds.contains(sw)) {
         //TODO: update result count to match what is actually within current view

         console.debug('Moved to within query bounds, not requerying.');
         return;
      }
      else {
         queryBounds = new google.maps.LatLngBounds(
               new google.maps.LatLng(minLat, minLon), 
               new google.maps.LatLng(maxLat, maxLon));
      }
   }

   console.debug("Refreshing target points...");
   document.getElementById("query_input").value = "QUERY RUNNING...";
   document.getElementById('stats_nav').innerHTML = '';
   document.getElementById('busy_indicator').style.visibility = 'visible';

   //var infoWindow = new google.maps.InfoWindow();
   var infoBubble = new InfoBubble({
      disableAnimation: true,
      disableAutoPan: true,
      arrowStyle:     2,
      padding:        10
   });

   var phpWithArg;
   if (!customQuery) {
      var boundStr = "minlat=" + minLat + "&maxlat=" + maxLat + "&minlon=" + minLon + "&maxlon=" + maxLon;
      phpWithArg = "query_current_vessels.php?" + boundStr + "";
   }
   else {
      if (customQuery.length < 20) {
         var boundStr = "minlat=" + minLat + "&maxlat=" + maxLat + "&minlon=" + minLon + "&maxlon=" + maxLon;
         phpWithArg = "query_current_vessels.php?" + boundStr + "&keyword=" + customQuery;
      }
      else {
         phpWithArg = "query_current_vessels.php?query=" + customQuery;
      }
   }

   //Debug query output
   console.debug(phpWithArg);

   downloadUrl(phpWithArg, 
         function(data) {
            var xml = data.responseXML;
            if(xml == null) {
               console.debug("No response; error in php?");
               document.getElementById("query_input").value = "ERROR IN QUERY.  PLEASE TRY AGAIN.";
               document.getElementById('busy_indicator').style.visibility = 'hidden';
               return; 
            }

            //Get the statement which embedded in the PHP returned XML output
            var statement = xml.documentElement.getElementsByTagName("query");
            console.debug(statement[0].getAttribute("statement"));
            //Show the query and put it in the form
            document.getElementById("query_input").value = statement[0].getAttribute("statement");            

            //Delete previous markers
            //TODO: update to clear only markers that are now out of bounds
            //clearMarkerArray();
            clearOutBoundMarkers();
            clearTrack();

            //Prepare to grab PHP results as XML
            var ais_tips = xml.documentElement.getElementsByTagName("ais");
            console.debug("Results returned = " + ais_tips.length);

            for (var i = 0; i < ais_tips.length; i++) {
               var key_column = ais_tips[i].getAttribute("key_column");
               var messagetype = ais_tips[i].getAttribute("messagetype");
               var mmsi = ais_tips[i].getAttribute("mmsi");
               var navstatus = ais_tips[i].getAttribute("navstatus");
               var rot = ais_tips[i].getAttribute("rot");
               var sog = ais_tips[i].getAttribute("sog");
               var lon = ais_tips[i].getAttribute("lon");
               var lat = ais_tips[i].getAttribute("lat");
               var point = new google.maps.LatLng(
                     parseFloat(ais_tips[i].getAttribute("lat")),
                     parseFloat(ais_tips[i].getAttribute("lon")));
               var cog = ais_tips[i].getAttribute("cog");
               var true_heading = ais_tips[i].getAttribute("true_heading");
               var datetime = ais_tips[i].getAttribute("datetime");
               var imo = ais_tips[i].getAttribute("imo");
               var vesselname = ais_tips[i].getAttribute("vesselname");
               var vesseltypeint = ais_tips[i].getAttribute("vesseltypeint");
               var length = ais_tips[i].getAttribute("length");
               var shipwidth = ais_tips[i].getAttribute("shipwidth");
               var bow = ais_tips[i].getAttribute("bow");
               var stern = ais_tips[i].getAttribute("stern");
               var port = ais_tips[i].getAttribute("port");
               var starboard = ais_tips[i].getAttribute("starboard");
               var draught = ais_tips[i].getAttribute("draught");
               var destination = ais_tips[i].getAttribute("destination");
               var callsign = ais_tips[i].getAttribute("callsign");
               var posaccuracy = ais_tips[i].getAttribute("posaccuracy");
               var eta = ais_tips[i].getAttribute("eta");
               var posfixtype = ais_tips[i].getAttribute("posfixtype");
               var streamid = ais_tips[i].getAttribute("streamid");

               imgURL = 'http://photos2.marinetraffic.com/ais/showphoto.aspx?mmsi=' + mmsi + '&imo=' + imo;
               
               var title;
               if (vesselname != null && vesselname != '') {
                  title = vesselname;
               }
               else {
                  title = 'MMSI or RADAR ID: ' + mmsi;
               }

               var html = '<div id="content">'+
                  '<div id="siteNotice">'+
                  '</div>'+
                  '<h2 id="firstHeading" class="firstHeading">' + title + '</h1>' +
                  '<div id="bodyContent" style="overflow: hidden">' +
                  //'<div id="content-left">' +
                  '<div id="content-left">' +
                  '<a href="https://marinetraffic.com/ais/shipdetails.aspx?MMSI=' + mmsi + '"> '+
                  '<img width=180px src="' + imgURL + '">' + 
                  '</a><br>' + 
                  '</div>' +

                  '<div id="content-right">' +
                  '<b>MMSI</b>: ' + mmsi + '<br>' +
                  '<b>IMO</b>: ' + imo + '<br>' +
                  //'<b>Report Date</b>: ' + datetime + '<br>' +
                  '<b>Report Date</b>: <br>' + toHumanTime(datetime) + '<br>' +
                  '<b>Message Type</b>: ' + messagetype + '<br>' +
                  '<b>Lat</b>: ' + lat + '<br>' +
                  '<b>Lon</b>: ' + lon + '<br>' +
                  '<b>Vessel Type</b>: ' + vesseltypeint + '<br>' +
                  '<b>Navigation Status</b>: ' + navstatus + '<br>' +
                  '<b>Length x Width</b>: ' + length + ' x ' + shipwidth + '<br>'+
                  '<b>Draught</b>: ' + draught  + '<br>'+
                  '<b>Destination</b>: ' + destination + '<br>'+
                  '<b>ETA</b>: ' + eta + '<br>'+
                  '<b>Source</b>: ' + streamid + '<br>'+
                  '</div>'+

                  '</div>'+
                  '</div>';

               var iconColor = getIconColor(vesseltypeint, streamid);

               var marker = new google.maps.Marker({
                  position: point,
                  icon: {
                     path:        'M 0,8 4,8 0,-8 -4,8 z',
                     strokeColor: iconColor,
                     fillColor:   iconColor,
                     fillOpacity: 0.6,
                     rotation:    true_heading
                  }
               });

               //markerInfoWindow(marker, infoWindow, html, mmsi, vesselname);
               markerInfoBubble(marker, infoBubble, html, mmsi, vesselname);
               markerArray.push(marker);
            }

            //Display the appropriate layer according to the sidebar checkboxes
            if (CLUSTER) {
               if (document.getElementById("HeatmapLayer").checked) {
                  addHeatmap();
               }
               else {
                  markerClusterer.addMarkers(markerArray);
               }
               console.debug("Number of markers = " + markerClusterer.getTotalMarkers());
               console.debug("Number of clusters = " + markerClusterer.getTotalClusters());
            }
            else {
               if (document.getElementById("HeatmapLayer").checked) {
                  addHeatmap();
               }
               else {
                  showOverlays();   //Display the markers individually
               }
            }

            console.debug("Total number of markers = " + markerArray.length);

            var execTime = xml.documentElement.getElementsByTagName("execution")[0].getAttribute("time");
            var resultCount= xml.documentElement.getElementsByTagName("resultcount")[0].getAttribute("count");
            document.getElementById('busy_indicator').style.visibility = 'hidden';
            document.getElementById('stats_nav').innerHTML = resultCount + " results<br>" + Math.round(execTime*1000)/1000 + " secs";
         }
   );
}

/* -------------------------------------------------------------------------------- */
/**
 * Function to attach information associated with marker, or call track 
 * fetcher to get track line
 */
function markerInfoBubble(marker, infoBubble, html, mmsi, vesselname) {
   //Listener for click on marker to display infoBubble
	google.maps.event.addListener(marker, 'click', function () {
      infoBubble.setContent(html);
      infoBubble.open(map, marker);

      /*
      google.maps.event.addListener(marker, 'mouseover', function() {
         window.clearTimeout(markerMouseoutTimeout);
      });

      google.maps.event.addListener(marker, 'mouseout', function() {
         markerMouseoutTimeout = window.setTimeout(
            function closeInfoWindow() { 
               infoBubble.removeTab(1);
               infoBubble.removeTab(0);
               infoBubble.close(); 
            }, 
            3000);   //milliseconds
      });
      */

      google.maps.event.addListener(infoBubble, 'mouseover', function() {
         alert("mouse over infobubble");
         window.clearTimeout(trackMouseoverTimeout);
      });
   });

   //Listener for mouseover marker to display tracks
   google.maps.event.addListener(marker, 'mouseover', function() {
      //Hover display name
      if (vesselname.length != 0 && vesselname != null) {
         marker.setTitle(vesselname.trim());
      }
      else {
         marker.setTitle(mmsi);
      }

      //Display ship details in sidebar
      //var $html = $(html);
      //document.getElementById('shipdetails').innerHTML = $html.find('#content-right').html();
      document.getElementById('shipdetails').innerHTML = html;
      document.getElementById('shipdetails').style.visibility = 'visible';

      //Delay, then get and display track
      trackMouseoverTimeout = window.setTimeout(
         function displayTracks() {
            getTrack(mmsi)
         },
         1000);   //milliseconds

      google.maps.event.addListenerOnce(marker, 'mouseout', function() {
         window.clearTimeout(trackMouseoverTimeout);
         document.getElementById('shipdetails').style.visibility = 'hidden';
      });
   });
}

/* -------------------------------------------------------------------------------- */
/**
 * Function to attach information associated with marker, or call track 
 * fetcher to get track line
 */
/*
function markerInfoWindow(marker, infoWindow, html, mmsi, vesselname) {
   //Listener for click on marker to display infoWindow
	google.maps.event.addListener(marker, 'click', function () {
      window.clearTimeout(markerMouseoutTimeout);
      infoWindow.setContent(html);
      infoWindow.open(map, marker);

      google.maps.event.addListener(marker, 'mouseover', function() {
         window.clearTimeout(markerMouseoutTimeout);
      });

      google.maps.event.addListener(marker, 'mouseout', function() {
         markerMouseoutTimeout = window.setTimeout(
            function closeInfoWindow() { 
               infoWindow.close(); 
            }, 
            3000);   //milliseconds
      });
   });

   //Listener for mouseover marker to display tracks
   google.maps.event.addListener(marker, 'mouseover', function() {
      //Hover display name
      marker.setTitle(vesselname.trim());

      //Delay, then get and display track
      trackMouseoverTimeout = window.setTimeout(
         function displayTracks() {
            getTrack(mmsi)
         },
         1000);   //milliseconds

      google.maps.event.addListenerOnce(marker, 'mouseout', function() {
         window.clearTimeout(trackMouseoverTimeout);
      });
   });
}
*/

/* -------------------------------------------------------------------------------- */
/**
 * Function to get track from track query PHP script
 */
function getTrack(mmsi) {
   clearTrack();

   document.getElementById("query_input").value = "QUERY RUNNING FOR TRACK...";
   document.getElementById('stats_nav').innerHTML = '';
   document.getElementById('busy_indicator').style.visibility = 'visible';
   var phpWithArg = "query_track.php?mmsi=" + mmsi;
   //Debug query output
   console.debug(phpWithArg);

//JSON ----------------------------------------------
   $.getJSON(
         phpWithArg, // The server URL 
         { }
      ) //end .getJSON()
      .done(function (response) {
         console.debug("Results returned on track = " + response.resultcount);
         console.log('query = ' + response.query);
         //console.log('exectime: ' + response.exectime);
         console.log('track size = ' + response.resultcount);
         //console.log('vessels: ' + response.vessels);

         var track = new Array();
         tracklineIcons = new Array(response.resultcount);

         $.each(response.vessels, function(key,vessel) {
            //console.log(' ' + key);
            //console.log(' ' + value);
            //console.log(' MMSI: ' + value.mmsi);
            //console.log(' lat: ' + value.lat);
            //console.log(' lon: ' + value.lon);
            //console.log(' datetime: ' + value.datetime);

            var mmsi = vessel.mmsi;
            var lat = vessel.lat
            var lon = vessel.lon;
            var datetime = vessel.datetime;

            track[key] = new google.maps.LatLng(lat, lon);
            var tracklineIcon = new google.maps.Marker({icon: tracklineIconsOptions});
            tracklineIcon.setPosition(track[key]);
            tracklineIcon.setMap(map);
            tracklineIcon.setTitle('MMSI: ' + mmsi + '\nDatetime: ' + toHumanTime(datetime) + '\nLat: ' + lat + '\nLon: ' + lon);
            tracklineIcons.push(tracklineIcon);
         });

         trackline.setOptions(tracklineOptions);
         trackline.setPath(track);
         trackline.setMap(map);

         document.getElementById('busy_indicator').style.visibility = 'hidden';
         document.getElementById('stats_nav').innerHTML = response.resultcount + " results<br>" + Math.round(response.exectime*1000)/1000 + " secs";
      }) //end .done()
      //.done(function() { console.log( "second success" ); })
      .fail(function() { 
         console.log( "No response from track query; error in php?" ); 
         document.getElementById("query_input").value = "ERROR IN QUERY.  PLEASE TRY AGAIN.";
         document.getElementById('busy_indicator').style.visibility = 'hidden';
         return; 
      }); //end .fail()
//END JSON ----------------------------------------------

   /*
   downloadUrl(phpWithArg, 
         function(data) {
            var xml = data.responseXML;
            if(xml == null) {
               console.debug("No response from track query; error in php?");
               document.getElementById("query_input").value = "ERROR IN QUERY.  PLEASE TRY AGAIN.";
               document.getElementById('busy_indicator').style.visibility = 'hidden';
               return; 
            }

            var statement = xml.documentElement.getElementsByTagName("query");
            console.debug(statement[0].getAttribute("statement"));
            document.getElementById("query_input").value = statement[0].getAttribute("statement");            

            var ais_tips = xml.documentElement.getElementsByTagName("ais");
            console.debug("Results returned on track = " + ais_tips.length);

            var track = new Array();
            tracklineIcons = new Array(ais_tips.length);

            for (var i = 0; i < ais_tips.length; i++) {                       
               var mmsi = ais_tips[i].getAttribute("mmsi");
               var lon = ais_tips[i].getAttribute("lon");
               var lat = ais_tips[i].getAttribute("lat");
               var datetime = ais_tips[i].getAttribute("datetime");

               track[i] = new google.maps.LatLng(lat, lon);
               var tracklineIcon = new google.maps.Marker({icon: tracklineIconsOptions});
               tracklineIcon.setPosition(track[i]);
               tracklineIcon.setMap(map);
               tracklineIcon.setTitle('MMSI: ' + mmsi + '\nDatetime: ' + toHumanTime(datetime) + '\nLat: ' + lat + '\nLon: ' + lon);
               tracklineIcons.push(tracklineIcon);
            }

            console.debug("track size = " + track.length);

            trackline.setOptions(tracklineOptions);
            trackline.setPath(track);
            trackline.setMap(map);

            var execTime = xml.documentElement.getElementsByTagName("execution")[0].getAttribute("time");
            var resultCount= xml.documentElement.getElementsByTagName("resultcount")[0].getAttribute("count");
            document.getElementById('busy_indicator').style.visibility = 'hidden';
            document.getElementById('stats_nav').innerHTML = resultCount + " results<br>" + Math.round(execTime*1000)/1000 + " secs";
         }
   );
   */
}

/* -------------------------------------------------------------------------------- */
/**
 * Function to download results from PHP script
 */
function downloadUrl(url, callback) {
	var request = window.ActiveXObject ?
			new ActiveXObject('Microsoft.XMLHTTP') :
				new XMLHttpRequest;

   request.onreadystatechange = function() {
      if (request.readyState == 4) {
         request.onreadystatechange = doNothing;
         callback(request, request.status);
      }
   };

   request.open('GET', url, true);
   request.send(null);
}

/* -------------------------------------------------------------------------------- */
function refreshLayers() {
	clearOverlays();
	clearMarkerArray();
   getCurrentAISFromDB(map.getBounds(),null);
}

/* -------------------------------------------------------------------------------- */
function typeSelectUpdated() {
   var types = getTypesSelected();

   var entered_query = document.getElementById("query_input").value;

   if (types[0] != 999) {
      entered_query = entered_query + " AND vesseltypeint in (";
   
      for (var i=0; i < types.length; i++) {
         entered_query = entered_query + types[i];
         if (i != types.length-1) {
            entered_query = entered_query + ",";
         }
      }
      entered_query = entered_query + ")";
   }

   var navTypes = getNavTypesSelected();
   if (navTypes.length != 0) {
      if (navTypes[0] == 1) {
         entered_query = entered_query + " AND navstatus = 1";
      }
      else {
         entered_query = entered_query + " AND navstatus != 1";
      }
   }

   getCurrentAISFromDB(map.getBounds(), entered_query);

	//refreshLayers();
}

/* -------------------------------------------------------------------------------- */
function getNavTypesSelected() {
	var navTypes = [];

   if (document.getElementById("Underway").checked != document.getElementById("Anchored").checked) {
      if (document.getElementById("Anchored").checked) {
         navTypes.push(1);
      }
      else {
         navTypes.push(-1);
      }
   }

   return navTypes;
}


/* -------------------------------------------------------------------------------- */
function getTypesSelected() {
	var types = [];

   if(document.getElementById("All Ships").checked) {
      types.push(999);
   }
   else
   {
      if(document.getElementById("0-Unspecified Ships").checked) {
         types.push(0);
      }
      if(document.getElementById("30-Fishing").checked) {
         types.push(30);
      }
      if(document.getElementById("31-Towing").checked) {
         types.push(31);
      }
      if(document.getElementById("32-Big Tow").checked) {
         types.push(32);
      }
      if(document.getElementById("33-Dredge").checked) {
         types.push(33);
      }
      if(document.getElementById("35-Military").checked) {
         types.push(35);
      }
      if(document.getElementById("37-Pleasure Craft").checked) {
         types.push(37);
      }
      if(document.getElementById("50-Pilot").checked) {
         types.push(50);
      }
      if(document.getElementById("51-Search & Rescue").checked) {
         types.push(51);
      }
      if(document.getElementById("52-Tug").checked) {
         types.push(52);
      }
      if(document.getElementById("55-Law Enforcement").checked) {
         types.push(55);
      }
      if(document.getElementById("6x-Passenger Vessels").checked) {
         types.push(60);   //covers 60-69
         types.push(61);
         types.push(62);
         types.push(63);
         types.push(64);
         types.push(65);
         types.push(66);
         types.push(67);
         types.push(68);
         types.push(69);
      }
      if(document.getElementById("7x-Cargo Vessels").checked) {
         types.push(70);   //covers 70-79
         types.push(71);
         types.push(72);
         types.push(73);
         types.push(74);
         types.push(75);
         types.push(76);
         types.push(77);
         types.push(78);
         types.push(79);
      }
      if(document.getElementById("8x-Tankers").checked) {
         types.push(80);   //covers 80-89
         types.push(81);
         types.push(82);
         types.push(83);
         types.push(84);
         types.push(85);
         types.push(86);
         types.push(87);
         types.push(88);
         types.push(89);
      }
   }

   //Default to all ships if no types selected
   if (types.length == 0) {
      types.push(999);
   }

   return types;
}

/* -------------------------------------------------------------------------------- */
function getIconColor(vesseltypeint, streamid) {
   var color;
   if (streamid == 'shore-radar') {
      color = '#4000FF';
      return color;
   }
   if (vesseltypeint >= 70 && vesseltypeint <= 79) {
      color = '#04B404'; 
      //return "shipicons/lightgreen1_90.png";
   }
   else if (vesseltypeint >= 80 && vesseltypeint <= 89) {
      color = '#04B404'; 
      //return "shipicons/lightgreen1_90.png";
   }
   else if (vesseltypeint == 60) {
      color = '#04B404'; 
      //return "shipicons/lightgreen1_90.png";
   }
   else if (vesseltypeint == 0) {
      color = '#F78181';
      //return "shipicons/pink0.png";
   }
   else if (vesseltypeint == 55) {
      color = '#0000FF'; 
      //return "shipicons/blue1_90.png";
   }
   else if (vesseltypeint == 35) {
      color = '#0000FF'; 
      //return "shipicons/blue1_90.png";
   }
   else if (vesseltypeint == 31) {
      color = '#DF7401'; 
      //return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 32) {
      color = '#DF7401'; 
      //return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 52) {
      color = '#DF7401'; 
      //return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 33) {
      color = '#DF7401'; 
		//return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 50) {
      color = '#DF7401'; 
		//return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 37) {
      color = '#8904B1'; 
		//return "shipicons/magenta1_90.png";
   }
   else if (vesseltypeint == 30) {
      color = '#01DFD7'; 
		//return "shipicons/cyan1_90.png";
   }
   else if (vesseltypeint == 51) {
      color = '#FF0000'; 
		//return "shipicons/red1_90.png";
   }
   else if (vesseltypeint == 999) {
      color = '#A4A4A4'; 
		//return "shipicons/lightgray1_90.png";
   }
   else {
      color = '#FFFFFF';
		//return "shipicons/white0.png";
   }
   return color;
}

/* -------------------------------------------------------------------------------- */
//Shows any overlays currently in the array
function showOverlays() {
	if (markerArray) {
		for (i in markerArray) {
			markerArray[i].setMap(map);
		}
	}
}

/* -------------------------------------------------------------------------------- */
function tipDisplay(marker, info_window) {
	this.marker = marker;
	this.info_window = info_window;
}

/* -------------------------------------------------------------------------------- */
function doNothing() {
}

/* -------------------------------------------------------------------------------- */
function clearMap() {
	clearOverlays();
	clearMarkerArray();
}

/* -------------------------------------------------------------------------------- */
//Removes the overlays from the map, but keeps them in the array
function clearOverlays() {
	if (markerArray) {
		for (i in markerArray) {
			markerArray[i].setMap(null);
		}
	}
}

/* -------------------------------------------------------------------------------- */
//
function clearMarkerArray() {
	if (markerArray) {
      if (CLUSTER) {
         markerClusterer.removeMarkers(markerArray);
      }

		for (i in markerArray) {
			markerArray[i].setMap(null);
         markerArray[i] = null;
		}
		markerArray.length = 0;
      markerArray = [];
	}
}

/* -------------------------------------------------------------------------------- */
//TODO: need to update to clear only out of bound markers
function clearOutBoundMarkers() {
	if (markerArray) {
      if (CLUSTER) {
         markerClusterer.removeMarkers(markerArray);
      }

		for (i in markerArray) {
			markerArray[i].setMap(null);
         markerArray[i] = null;
		}
		markerArray.length = 0;
      markerArray = [];
	}
}

/* -------------------------------------------------------------------------------- */
function changePorts()
{}

/* -------------------------------------------------------------------------------- */
function changeStations()
{}

/* -------------------------------------------------------------------------------- */
function changeLights()
{}

/* -------------------------------------------------------------------------------- */
function toggleRadarLayer() {
   if (document.getElementById("RadarLayer").checked) {
   }
   else {
   }
}

/* -------------------------------------------------------------------------------- */
function toggleKMLLayer() {
   if (document.getElementById("KMLLayer").checked) {
      KML = true;
      showKML();
   }
   else {
      KML = false;
      //TODO: hide KML layer not working yet
      var kmlparser = new geoXML3.parser({map: map});
      kmlparser.hideDocument(kmlparser.docs);
   }
}

/* -------------------------------------------------------------------------------- */
function showKML() {
//TODO: Attempting to unzip KMZ files --------------------------
//   zip.workerScriptsPath = "lib/";

   var kmlparser = new geoXML3.parser({map: map});
//    myParser.parse('kml/sandiego.kml');
//    myParser.parse('kml/ghana.kml');
//    myParser.parse('kml/ghana.kmz');
//    myParser.parse('kml/ghanasmall.kmz');
//    myParser.parse('kml/tsxtestzip.kmz');
//    myParser.parse('kml/ghanatestzip.kmz');
   kmlparser.parse('kml/tsx.kml');
//    myParser.parse('kml/usa-ca-sf.kmz');

/*
   var extractCallback = function(id, sz) {
      return function (entry, entryContent) {
         var entryName = entry.name;
         console.debug(entryName);
         console.debug(typeof entryContent);
      };
   };

   var doneReadingKMZ = function(zip) {
      try {
         var randomId = "id-"+ Math.floor((Math.random() * 1000000000));         
         for (var i=0; i < zip.entries.length; i++) {
            var entry = zip.entries[i];
            //alert('Entry ' + i + ": " + entry.uncompressedSize + ' bytes.');
            entry.extract(extractCallback(randomId, entry.uncompressedSize));
         }
      }
      catch (exc1) {
         $("#status").append("exception: " + exc1.message + "<br/>source: " + exc1.source + "<br/>");
      }
   }
   var kmzFile = new ZipFile('ghana.kmz', doneReadingKMZ, 1);
*/
}

/* -------------------------------------------------------------------------------- */
function toggleClusterLayer() {
   if (document.getElementById("ClusterLayer").checked) {
      clearOverlays();
      CLUSTER = true;
      markerClusterer.addMarkers(markerArray);
   }
   else {
      CLUSTER = false;
      markerClusterer.removeMarkers(markerArray);
      showOverlays();   //Display the markers individually
   }
}

/* -------------------------------------------------------------------------------- */
function toggleHeatmapLayer() {
   if (document.getElementById("HeatmapLayer").checked) {
      markerClusterer.removeMarkers(markerArray);
      addHeatmap();
   }
   else {
      heatmapLayer.setMap(null);
      markerClusterer.addMarkers(markerArray);
   }
}

/* -------------------------------------------------------------------------------- */
//adds an example heat map
//this could be for example a probability of pirate attack map
function addHeatmap() {
   var heatmapData = new Array();

   for(var i=0; i<markerArray.length; i++) {
      heatmapData[i] = markerArray[i].getPosition();
   }

   heatmapLayer = new google.maps.visualization.HeatmapLayer({
     data: heatmapData
   });

   heatmapLayer.setMap(map);
}

/* -------------------------------------------------------------------------------- */
function toggleWeatherLayer() {
   if (document.getElementById("WeatherLayer").checked) {
      addWeatherLayer();
   }
   else {
      weatherLayer.setMap(null);
      cloudLayer.setMap(null);
   }
}

/* -------------------------------------------------------------------------------- */
function addWeatherLayer() {
	weatherLayer = new google.maps.weather.WeatherLayer({
		temperatureUnits: google.maps.weather.TemperatureUnit.FAHRENHEIT
	});
	weatherLayer.setMap(map);

	cloudLayer = new google.maps.weather.CloudLayer();
	cloudLayer.setMap(map);	
}

/* -------------------------------------------------------------------------------- */
//Adds a drawing manager to the map for adding custom shapes and placemarks
//to your map
function addDrawingManager() {
	var drawingManager = new google.maps.drawing.DrawingManager({
		drawingMode: null,
		drawingControl: true,
		drawingControlOptions: {
			position: google.maps.ControlPosition.TOP_LEFT,
			drawingModes: [
			               google.maps.drawing.OverlayType.MARKER,
			               google.maps.drawing.OverlayType.CIRCLE,
			               google.maps.drawing.OverlayType.POLYGON,
			               google.maps.drawing.OverlayType.POLYLINE,
			               google.maps.drawing.OverlayType.RECTANGLE
			               ]
		},
		circleOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.3,
			strokeWeight: 2,
			strokeColor: '#ffff00',
         strokeOpacity: 0.8,
			clickable: true,
			editable: false,
			zIndex: 1
		},
		polygonOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.3,
			strokeWeight: 2,
			strokeColor: '#ffff00',
         strokeOpacity: 0.8,
			clickable: true,
			editable: false,
			zIndex: 1 
		},
		polylineOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.3,
			strokeWeight: 3,
			strokeColor: '#ffff00',
         strokeOpacity: 0.8,
			clickable: true,
			editable: false,
			zIndex: 1 
		},
      rectangleOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.3,
			strokeWeight: 2,
			strokeColor: '#ffff00',
         strokeOpacity: 0.8,
			clickable: true,
			editable: false,
			zIndex: 1 
		}
	});
	drawingManager.setMap(map);

   google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
      //if (event.type != google.maps.drawing.OverlayType.MARKER) {
         // Switch back to non-drawing mode after drawing a shape.
         drawingManager.setDrawingMode(null);

         var newShape = event.overlay;
         newShape.type = event.type;
         //delete shape if user right clicks on the shape
         google.maps.event.addListener(newShape, 'rightclick', function (e) {
            newShape.setMap(null);
         });

         //make shape editable if user left clicks on the shape
         google.maps.event.addListener(newShape, 'click', function (e) {
            setSelection(newShape);
         });
         google.maps.event.addListener(map, 'click', clearSelection);
      //}
   });
}

/* -------------------------------------------------------------------------------- */
function clearSelection() {
   if (selectedShape) {
      selectedShape.setEditable(false);
      selectedShape = null;
   }
}

/* -------------------------------------------------------------------------------- */
function setSelection(shape) {
   clearSelection();
   selectedShape = shape;
   shape.setEditable(true);
}

/* -------------------------------------------------------------------------------- */
function setMapCenterToCenterOfMass(map, tips) {
   lat_mean=0;
   lon_mean=0;
   N=tips.length;
   for(var i=0;i<N;i++)
	{
		lat_mean = lat_mean+tips[i].lat/N;
		lon_mean = lon_mean+tips[i].lon/N;
	}
	var centerCoord = new google.maps.LatLng(lat_mean, lon_mean);
	map.setCenter(centerCoord);
}

/* -------------------------------------------------------------------------------- */
function addWmsLayers() {
   openlayersWMS = new google.maps.ImageMapType(wmsOptions);
   map.mapTypes.set('OpenLayers', openlayersWMS);
}

/* -------------------------------------------------------------------------------- */
function WMSGetTileUrl(tile, zoom) {
   var projection = window.map.getProjection();
   var zpow = Math.pow(2, zoom);
   var ul = new google.maps.Point(tile.x * 256.0 / zpow, (tile.y + 1) * 256.0 / zpow);
   var lr = new google.maps.Point((tile.x + 1) * 256.0 / zpow, (tile.y) * 256.0 / zpow);
   var ulw = projection.fromPointToLatLng(ul);
   var lrw = projection.fromPointToLatLng(lr);
   //The user will enter the address to the public WMS layer here.  The data must be in WGS84
   var baseURL = "http://demo.cubewerx.com/cubewerx/cubeserv.cgi?";
   var version = "1.3.0";
   var request = "GetMap";
   var format = "image%2Fjpeg"; //type of image returned  or image/jpeg
   //The layer ID.  Can be found when using the layers properties tool in ArcMap or from the WMS settings 
   var layers = "Foundation.GTOPO30";
   //projection to display. This is the projection of google map. Don't change unless you know what you are doing.  
   //Different from other WMS servers that the projection information is called by crs, instead of srs
   var crs = "EPSG:4326"; 
   //With the 1.3.0 version the coordinates are read in LatLon, as opposed to LonLat in previous versions
   var bbox = ulw.lat() + "," + ulw.lng() + "," + lrw.lat() + "," + lrw.lng();
   var service = "WMS";
   //the size of the tile, must be 256x256
   var width = "256";
   var height = "256";
   //Some WMS come with named styles.  The user can set to default.
   var styles = "default";
   //Establish the baseURL.  Several elements, including &EXCEPTIONS=INIMAGE and &Service are unique to openLayers addresses.
   var url = baseURL + "Layers=" + layers + "&version=" + version + "&EXCEPTIONS=INIMAGE" + "&Service=" + service + "&request=" + request + "&Styles=" + styles + "&format=" + format + "&CRS=" + crs + "&BBOX=" + bbox + "&width=" + width + "&height=" + height;
   return url;
}


/* -------------------------------------------------------------------------------- */
/*
   function addWmsLayers() {
//http://www.sumbera.com/lab/GoogleV3/tiledWMSoverlayGoogleV3.htm
//Define OSM as base layer in addition to the default Google layers

var osmMapType = new google.maps.ImageMapType({
getTileUrl: function (coord, zoom) {
return "http://tile.openstreetmap.org/" +
zoom + "/" + coord.x + "/" + coord.y + ".png";
},
tileSize: new google.maps.Size(256, 256),
isPng: true,
alt: "OpenStreetMap",
name: "OSM",
maxZoom: 19
});

//Define custom WMS tiled layer
	var SLPLayer = new google.maps.ImageMapType({
		getTileUrl: function (coord, zoom) {
			var proj = map.getProjection();
			var zfactor = Math.pow(2, zoom);

			// get Long Lat coordinates
			var top = proj.fromPointToLatLng(new google.maps.Point(coord.x * 256 / zfactor, coord.y * 256 / zfactor));
			var bot = proj.fromPointToLatLng(new google.maps.Point((coord.x + 1) * 256 / zfactor, (coord.y + 1) * 256 / zfactor));

			//corrections for the slight shift of the SLP (mapserver)
			var deltaX = 0.0013;
			var deltaY = 0.00058;


			//create the Bounding box string
			var bbox = (top.lng() + deltaX) + "," +
                    (bot.lat() + deltaY) + "," +
                    (bot.lng() + deltaX) + "," +
                    (top.lat() + deltaY);


			//http://onearth.jpl.nasa.gov/wms.cgi?request=GetCapabilities
			//base WMS URL
			var url = "http://mapserver-slp.mendelu.cz/cgi-bin/mapserv?map=/var/local/slp/krtinyWMS.map&";
			url += "&REQUEST=GetMap"; //WMS operation
			url += "&SERVICE=WMS";    //WMS service
			url += "&VERSION=1.1.1";  //WMS version  
			url += "&LAYERS=" + "typologie,hm2003"; //WMS layers
			url += "&FORMAT=image/png" ; //WMS format
			url += "&BGCOLOR=0xFFFFFF";  
			url += "&TRANSPARENT=TRUE";
			url += "&SRS=EPSG:4326";     //set WGS84 
			url += "&BBOX=" + bbox;      // set bounding box
			url += "&WIDTH=256";         //tile size in google
			url += "&HEIGHT=256";

			return url;                 // return URL for the tile
		},

		tileSize: new google.maps.Size(256, 256),

		isPng: true

	});

	map.mapTypes.set('OSM', osmMapType);

	map.setMapTypeId(google.maps.MapTypeId.ROADMAP);

	//add WMS layer

	map.overlayMapTypes.push(SLPLayer);
}
*/

/* -------------------------------------------------------------------------------- */
function microtime (get_as_float) {
  // http://kevin.vanzonneveld.net
  // +   original by: Paulo Freitas
  // *     example 1: timeStamp = microtime(true);
  // *     results 1: timeStamp > 1000000000 && timeStamp < 2000000000
  var now = new Date().getTime() / 1000;
  var s = parseInt(now, 10);

  return (get_as_float) ? now : (Math.round((now - s) * 1000) / 1000) + ' ' + s;
}

/* -------------------------------------------------------------------------------- */
function sleep(dur) {
 var d = new Date().getTime() + dur;
  while(new Date().getTime() <= d ) {
    //Do nothing
  }
}

/* -------------------------------------------------------------------------------- */
function toHumanTime(unixtime) {
   var date = new Date(unixtime * 1000);
   var humanTime = date.toLocaleString();
   return humanTime;
}