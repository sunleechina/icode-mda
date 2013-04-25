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
//Cluster objects
var CLUSTER = false;  //toggle this for CLUSTERing
var markerClusterer;
var mcOptions = {
               gridSize: 50, 
               minimumClusterSize: 50, 
               averageCenter: false
            };
//Track line options
var polylineOptions = {
               strokeColor: '#00FF25',
               strokeOpacity: 0.7,
               strokeWeight: 3
            };


/* -------------------------------------------------------------------------------- */
/** Initialize, called on main page load
 */
function initialize() {
   //Set up map properties
	var centerCoord = new google.maps.LatLng(0,0);

	var mapOptions = {
			zoom: 5,
			center: centerCoord,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			mapTypeControlOptions: {
				mapTypeIds: [google.maps.MapTypeId.ROADMAP, 
                         google.maps.MapTypeId.SATELLITE, 
                         google.maps.MapTypeId.HYBRID, 
                         google.maps.MapTypeId.TERRAIN],
				style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR //drop-down menu
			}
	};

	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

   if (CLUSTER) {
   	markerClusterer = new MarkerClusterer(map, [], mcOptions);
   }

   //Clear array
   markerArray = [];

   //Add listener to event for redrawing
   google.maps.event.addListener(map, 'idle', function() {
        //alert(this.getBounds());
        getCurrentAISFromDB(map.getBounds());
   });
}

/* -------------------------------------------------------------------------------- */
/** 
 * Get AIS data from XML, which is from database, with bounds 
 */
function getCurrentAISFromDB(bounds) {
   console.debug("Refreshing target points...");

   //Delete previous markers
   //TODO: update to clear only markers that are now out of bounds
   clearMarkerArray();

   var sw = bounds.getSouthWest();
   var ne = bounds.getNorthEast();
   var minLat = sw.lat();
   var maxLat = ne.lat();
   var minLon = sw.lng();
   var maxLon = ne.lng();

   var infoWindow = new google.maps.InfoWindow();
   var polyline = new google.maps.Polyline();

   var boundStr = "minlat=" + minLat + "&maxlat=" + maxLat + 
      "&minlon=" + minLon + "&maxlon=" + maxLon;
   var phpWithArg = "query_current_vessels.php?" + boundStr + 
      "";
      //"&type=" + typesSelected[i] + "&limit=500";
      //"&limit=2000";

   //Debug query output
   // In Google Chrome, hit F12 and go to the Console tab to see the 
   //   output statements for debugging
   console.debug(phpWithArg);
   //end debug query

   downloadUrl(phpWithArg, 
         function(data) {
            var xml = data.responseXML;
            if(xml == null) {
               console.debug("No response; error in php?");
               return; 
            }

            var statement = xml.documentElement.getElementsByTagName("query");
            console.debug(statement[0].getAttribute("statement"));

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

               var html = '<div id="content">'+
                  '<div id="siteNotice">'+
                  '</div>'+
                  '<h2 id="firstHeading" class="firstHeading">' + vesselname + '</h2>' +
                  '<div id="bodyContent">' +
                  'MMSI: ' + mmsi + '<br>' +
                  'Report Date: ' + datetime + '<br>' +
                  'Message Type: ' + messagetype + '<br>' +
                  'Lat: ' + lat + '<br>' +
                  'Lon: ' + lon + '<br>' +
                  'Vessel Type (integer): ' + vesseltypeint + '<br>' +
                  'Navigation Status: ' + navstatus + '<br>' +
                  'Source: ' + streamid + '<br>'+
                  'Length x Width: ' + length + ' x ' + shipwidth + '<br>'+
                  'Draught: ' + draught  + '<br>'+
                  'Destination: ' + destination + '<br>'+
                  'ETA: ' + eta + '<br>'+
                  '</div>'+
                  '</div>';

               var iconLocation = getIconLocation(vesseltypeint);

               var marker = new google.maps.Marker({
                  position: point,
                  icon: iconLocation
               });
               markerInfo(marker, infoWindow, html, polyline, mmsi);
               markerArray.push(marker);
            }

            if (CLUSTER) {
               markerClusterer.addMarkers(markerArray);
               console.debug("Number of markers = " + markerClusterer.getTotalMarkers());
               console.debug("Number of clusters = " + markerClusterer.getTotalClusters());
            }
            else {
               //Display the markers individually
               showOverlays();
               //addHeatmap(map);
            }
            console.debug("Total number of markers = " + markerArray.length);
         }
   );
}

/* -------------------------------------------------------------------------------- */
/**
 * Function to attach information associated with marker, or call track 
 * fetcher to get track line
 */
function markerInfo(marker, infoWindow, html, polyline, mmsi) {

	google.maps.event.addListener(marker, 'click', function() {
		infoWindow.setContent(html);
		infoWindow.open(map, marker);
      //setTimeout(function () { infoWindow.close(); }, 2000);
	});

	google.maps.event.addListener(marker, 'mouseout', function() {
      setTimeout(function () { infoWindow.close(); }, 2000);
	});

	google.maps.event.addListener(marker, 'mouseover', function() {
      getTrack(polyline, mmsi);
	});
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
/**
 * Function to get track from track query PHP script
 */
function getTrack(polyline, mmsi) {
   var phpWithArg = "query_track.php?mmsi=" + mmsi;
   downloadUrl(phpWithArg, 
         function(data) {
            var xml = data.responseXML;
            if(xml == null) {
               console.debug("No response from track query; error in php?");
               return; 
            }

            var statement = xml.documentElement.getElementsByTagName("query");
            console.debug(statement[0].getAttribute("statement"));

            var ais_tips = xml.documentElement.getElementsByTagName("ais");
            console.debug("Results returned on track = " + ais_tips.length);

            var track = new Array();

            for (var i = 0; i < ais_tips.length; i++) {                       
               var mmsi = ais_tips[i].getAttribute("mmsi");
               var lon = ais_tips[i].getAttribute("lon");
               var lat = ais_tips[i].getAttribute("lat");
               var datetime = ais_tips[i].getAttribute("datetime");

               track[i] = new google.maps.LatLng(lat, lon);
            }

            console.debug("track size = " + track.length);

            polyline.setOptions(polylineOptions);
            polyline.setPath(track);
            polyline.setMap(map);
         }
   );
}

/* -------------------------------------------------------------------------------- */
function refreshLayers() {
	clearOverlays();
	clearMarkerArray();
   getCurrentAISFromDB(map.getBounds());
}

/* -------------------------------------------------------------------------------- */
function refreshPositions() {
	refreshLayers();
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
      }
      if(document.getElementById("7x-Cargo Vessels").checked) {
         types.push(70);   //covers 70-79
      }
      if(document.getElementById("8x-Tankers").checked) {
         types.push(80);   //covers 80-89
      }
   }

   return types;
}

/* -------------------------------------------------------------------------------- */
function getIconLocation(vesseltypeint) {
   if (vesseltypeint >= 70 && vesseltypeint <= 79) {
      return "shipicons/lightgreen1_90.png";
   }
   else if (vesseltypeint >= 80 && vesseltypeint <= 89) {
      return "shipicons/lightgreen1_90.png";
   }
   else if (vesseltypeint == 60) {
      return "shipicons/lightgreen1_90.png";
   }
   else if (vesseltypeint == 0) {
      return "shipicons/pink0.png";
   }
   else if (vesseltypeint == 55) {
      return "shipicons/blue1_90.png";
   }
   else if (vesseltypeint == 35) {
      return "shipicons/blue1_90.png";
   }
   else if (vesseltypeint == 31) {
      return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 32) {
      return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 52) {
      return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 33) {
		return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 50) {
		return "shipicons/brown1_90.png";
   }
   else if (vesseltypeint == 37) {
		return "shipicons/magenta1_90.png";
   }
   else if (vesseltypeint == 30) {
		return "shipicons/cyan1_90.png";
   }
   else if (vesseltypeint == 51) {
		return "shipicons/red1_90.png";
   }
   else if (vesseltypeint == 999) {
		return "shipicons/lightgray1_90.png";
   }
   else {
		return "shipicons/white0.png";
   }
		//return "shipicons/yellow1_90.png";
		//return "shipicons/white1_90.png";
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
function clearMap(map) {
	clearOverlays();
	clearMarkerArray();
}

/* -------------------------------------------------------------------------------- */
function closeAllInfowindows() {
	if (markerArray) {
		for (i in markerArray) {
         if (markerArray[i].infoWindow) {
			   markerArray[i].infoWindow.close();
         }
		}
	}	
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
function changePorts()
{}

/* -------------------------------------------------------------------------------- */
function changeStations()
{}

/* -------------------------------------------------------------------------------- */
function changeLights()
{}

/* -------------------------------------------------------------------------------- */
//adds an example heat map
//this could be for example a probability of pirate attack map
function addHeatmap(map) {
   /*
	var heatMapLayer = new google.maps.FusionTablesLayer({
		query: {
			select: 'location',
			from: '1xWyeuAhIFK_aED1ikkQEGmR8mINSCJO9Vq-BPQ'
		},
		heatmap: {
			enabled: true
		}
	});

	heatMapLayer.setMap(map);	
   */

   var heatmapData = new Array();

   for(var i=0; i<markerArray.length; i++)
   {
      heatmapData[i] = markerArray[i].getPosition();
   }

   var heatmap = new google.maps.visualization.HeatmapLayer({
     data: heatmapData
   });

   heatmap.setMap(map);
}


/* -------------------------------------------------------------------------------- */
function addWeatherLayer(map) {
	var weatherLayer = new google.maps.weather.WeatherLayer({
		temperatureUnits: google.maps.weather.TemperatureUnit.FAHRENHEIT
	});
	weatherLayer.setMap(map);

	var cloudLayer = new google.maps.weather.CloudLayer();
	cloudLayer.setMap(map);	
}

/* -------------------------------------------------------------------------------- */
//Adds a drawing manager to the map for adding custom shapes and placemarks
//to your map
function addDrawingManager(map) {
	var drawingManager = new google.maps.drawing.DrawingManager({
		drawingMode: null,
		drawingControl: true,
		drawingControlOptions: {
			position: google.maps.ControlPosition.TOP_LEFT,
			drawingModes: [
			               google.maps.drawing.OverlayType.MARKER,
			               google.maps.drawing.OverlayType.CIRCLE,
			               google.maps.drawing.OverlayType.POLYGON,
			               google.maps.drawing.OverlayType.RECTANGLE
			               ]
		},
		circleOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.2,
			strokeWeight: 0,
			clickable: false,
			editable: false,
			zIndex: 1
		},
		polygonOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.2,
			strokeWeight: 0,
			clickable: false,
			editable: false,
			zIndex: 1 
		},
		rectangleOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.2,
			strokeWeight: 0,
			clickable: false,
			editable: false,
			zIndex: 1 
		}
	});
	drawingManager.setMap(map);
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
function addWmsLayers(map) {
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
			var bbox =     (top.lng() + deltaX) + "," +
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

