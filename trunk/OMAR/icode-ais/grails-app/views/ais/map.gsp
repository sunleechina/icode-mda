<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Ais Map</title>
  <meta name="layout" content="generatedViews" />

  <link rel="stylesheet" href="${resource(plugin: 'openlayers', dir: 'js/theme/default', file: 'style.css')}"
        type="text/css">

  <style type="text/css">
  #map {
    background: #7391ad;
    border: 0;
    height: 512px;
    width: 1024px;
  }
  </style>
  <g:javascript plugin="openlayers" src="OpenLayers.js"/>
  <g:javascript>
    var lon = 0;
    var lat = 0;
    var map, layers;

    function init()
    {
      map = new OpenLayers.Map( 'map' );
      
     var link = "${createLink(absolute:true,controller: 'ais', action: 'wms')}"
    // "http://localhost:8080/omar/ais/wms"

      layers = [

        new OpenLayers.Layer.WMS( "OpenLayers WMS",
          "http://vmap0.tiles.osgeo.org/wms/vmap0", {layers: 'basic'} ),

        new OpenLayers.Layer.WMS( "iCubed",
          "http://hyperquad.ucsd.edu/cgi-bin/i-cubed",
          {layers: "icubed", format: "image/png", transparent: true, bgcolor: '#99B3CC'},
          {buffer: 0, transitionEffect: 'resize'}
          ),

       new OpenLayers.Layer.WMS( "oneEarth",
          "http://hyperquad.ucsd.edu/cgi-bin/onearth",
          {layers: "OnEarth", format: "image/png", transparent: true, bgcolor: '#99B3CC'},
          {buffer: 0, transitionEffect: 'resize'}
          ),
          
         new OpenLayers.Layer.WMS( "AIS",
          "${createLink(absolute:false,controller: 'ais', action: 'wms')}",
          {layers:'location', format: 'image/png', styles: '{shape: {color: "#FF0000", type: "circle", size: 5}, fill: {color: "#000000", opacity: 0}, label: {property: "name"}}'},
          {buffer: 0, singleTile: true, transitionEffect: 'resize', isBaseLayer: false, minScale: 13841995.078125}
          ) ,
          new OpenLayers.Layer.WMS(
            'Location Labels',
            'http://vmap0.tiles.osgeo.org/wms/vmap0',
            {layers: 'clabel,ctylabel,statelabel',
            visibility: false, transparent: true},
            {opacity: .5}
        )
      ];
      
     

      map.addLayers(layers);
      map.zoomToMaxExtent();
      map.addControl( new OpenLayers.Control.LayerSwitcher() );
      
      
    }
  </g:javascript>
</head>

<body onload="init()">
  <content tag="content">
<div class="nav">
  <span class="menuButton">
    <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
  </span>
</div>

<div class="body">
  <br/>
  <div id="map"></div>
</div>
</content>
</body>
</html>