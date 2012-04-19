<%--
  Created by IntelliJ IDEA.
  User: sbortman
  Date: 3/19/12
  Time: 9:29 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>AIS MapView</title>
  <link rel="stylesheet" href="${resource( contextPath: '', dir: 'css', file: 'main.css' )}"/>
  <meta content="aisLayout" name="layout">
</head>

<body class=" yui-skin-sam">
<content tag="top">
  <div class="nav">
    <span class="menuButton">
      <a class="home" href="${createLink( uri: '/' )}"><g:message code="default.home.label"/></a>
    </span>
  </div>
</content>

<content tag="bottom">
</content>

<content tag="right">
</content>

<content tag="left">
</content>

<content tag="center">
  <div id="map"></div>
</content>

<g:javascript plugin="openlayers" src="OpenLayers.js"/>
<g:javascript>
var lon = 0;
var lat = 0;
var map, layers;

function init()
{
    OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;

    map = new OpenLayers.Map( 'map' );

    layers = [
      new OpenLayers.Layer.WMS(
        "OpenLayers WMS",
        '${map1.url}',
        {layers: '${map1.layers}', format: 'image/jpeg' },
        {buffer: 0, transitionEffect: 'resize'}
      ),

      new OpenLayers.Layer.WMS(
        "Reference",
        '${map2.url}',
        {layers:'${map2.layers}', format: 'image/jpeg'},
        {buffer: 0, transitionEffect: 'resize'}
      ),
      
       new OpenLayers.Layer.WMS(
        "Current Location",
        "${createLink( absolute: true, controller: 'ais', action: 'currentLocation' )}",
        {layers:'location', format: 'image/png', styles: '{shape: {color: "#FF0000", type: "circle", size: 5}, fill: {color: "#000000", opacity: 0}, label: {property: "name"}}'},
        {buffer: 0, singleTile: false, transitionEffect: 'resize', isBaseLayer: false, /*minScale: 13841995.078125*/}
      ),

      new OpenLayers.Layer.WMS(
        "Vessel Tracks",
        "${createLink( absolute: true, controller: 'ais', action: 'vesselTracks' )}",
        {layers:'location', format: 'image/png', styles: '{stroke: {color: "#FF0000", width: 0.5}, fill: {color: "#000000", opacity: 0}}'},
        {buffer: 0, singleTile: true, transitionEffect: 'resize', isBaseLayer: false, /*minScale: 13841995.078125*/}
      ),


      new OpenLayers.Layer.WMS(
        'Location Labels',
        '${map3.url}',
        {layers: '${map3.layers}', visibility: false, transparent: true, format: 'image/png'},
        {opacity: .5, buffer: 0}
      ),

       new OpenLayers.Layer.WMS(
        "I-Cubed",
        'http://hyperquad.ucsd.edu/cgi-bin/i-cubed',
        {layers: 'icubed', format: 'image/png' },
        {buffer: 0, transitionEffect: 'resize'}
      ),

       new OpenLayers.Layer.WMS(
        "OnEarth",
        'http://hyperquad.ucsd.edu/cgi-bin/onearth',
        {layers: 'OnEarth', format: 'image/png' },
        {buffer: 0, transitionEffect: 'resize'}
      )

    ];

  map.addLayers(layers);
  map.zoomToMaxExtent();
  map.addControl( new OpenLayers.Control.LayerSwitcher() );
}

function resize()
{
    map.updateSize();
}
</g:javascript>
</body>
</html>