<%@ page contentType="text/html;charset=UTF-8" %>
<html lang='en'> 
<head> 
  <meta name="layout" content="generatedViews" />
    <meta charset='utf-8' /> 
     <script src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2&mkt=en-us"></script>
    <script type='text/javascript' src='OpenLayers.js'></script>
    <script type='text/javascript'>

      var lon = 0;
    var lat = 0;
    var map, layers;
    
    function init() {
            //Create the map object
            	map = new OpenLayers.Map('map_element',{
			maxExtent: new OpenLayers.Bounds(
			-128 * 156543.0339,
			-128 * 156543.0339,
			128 * 156543.0339,
			128 * 156543.0339),
			maxResolution: 156543.0339,                
			units: 'm',
			projection: new OpenLayers.Projection('EPSG:900913'),
			displayProjection: new OpenLayers.Projection("EPSG:4326"),
		});
            
             layers = [

          //Hybrid Layer
	   new OpenLayers.Layer.VirtualEarth(
				"Shaded",
				{type: VEMapStyle.Shaded}
			),

            //Roads Layer (Like shaded layer, only without shade)
            new OpenLayers.Layer.VirtualEarth(
                "Road",
                {type: VEMapStyle.Road, animationEnabled: false}
            ),
			
            //Aerial (Satellite) Layer
            new OpenLayers.Layer.VirtualEarth(
                "Aerial",
                {type: VEMapStyle.Aerial}
            ),
			
            //Hybrid view layer
            new OpenLayers.Layer.VirtualEarth(
                "Hybrid",
                {type: VEMapStyle.Hybrid}
            )

      ];

            //Add the google map layers
            map.addLayers(layers);

            //Add a layer switcher control
            map.addControl(new OpenLayers.Control.LayerSwitcher());

			// Add a layer switcher control
			map.addControl(new OpenLayers.Control.LayerSwitcher({}));
			
			// Zoom the map to the max extent 
			if(!map.getCenter()){
				map.zoomToMaxExtent();
			}
        }


    </script>
</head>

<body onload='init();'>
  <content tag="content">
<div class="nav">
  <span class="menuButton">
    <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
  </span>
</div>

<div class="body">
  <br/>

  <div id='map_element' style='width: 500px; height: 500px;'></div>
</div>
</content>
</body>
</html>
