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

      <!-- Base Layer -->
      new OpenLayers.Layer.WMS(
        "OpenLayers WMS",
        '${map1.url}',
        {layers: '${map1.layers}', format: 'image/jpeg' },
        {buffer: 0, transitionEffect: 'resize'}
      ),

      <!-- Base Layer -->
      new OpenLayers.Layer.WMS(
        "Reference",
        '${map2.url}',
        {layers:'${map2.layers}', format: 'image/jpeg'},
        {buffer: 0, transitionEffect: 'resize'}
      ),

<%--
       <!-- Base Layer -->
       new OpenLayers.Layer.WMS(
        "I-Cubed",
        '${map4.url}',
        {layers: '${map4.layers}', format: 'image/jpeg' },
        {buffer: 0, transitionEffect: 'resize'}
      ),

       <!-- Base Layer -->
       new OpenLayers.Layer.WMS(
        "OnEarth",
        '${map5.url}',
        {layers: '${map5.layers}', format: 'image/jpeg' },
        {buffer: 0, transitionEffect: 'resize'}
      ),
--%>
       <!-- Overylay: AIS Current Location -->
       new OpenLayers.Layer.WMS(
        "Current Location",
        "${createLink( absolute: true, controller: 'ais', action: 'currentLocation' )}",
        {layers:'location', format: 'image/png', styles: '{shape: {color: "#FF0000", type: "circle", size: 15}, label: {property: "name"}, fill: {color: "#FF0000", opacity: 0}, halo: {color: "#FF0000", radius: 2}}'},
        {buffer: 0, singleTile: false, transitionEffect: 'resize', isBaseLayer: false/*, minScale: 13841995.078125*/}
      ),

      <!-- Overylay: AIS Tracks-->
      new OpenLayers.Layer.WMS(
        "Vessel Tracks",
        "${createLink( absolute: true, controller: 'ais', action: 'vesselTracks' )}",
        {layers:'location', format: 'image/png', styles: '{stroke: {color: "#FF0000", width: 0.5}, fill: {color: "#000000", opacity: 0}}'},
        {buffer: 0, singleTile: false, transitionEffect: 'resize', isBaseLayer: false/*, minScale: 13841995.078125*/}
      ),

      <!-- Overylay: Location Labels-->
      new OpenLayers.Layer.WMS(
        'Location Labels',
        '${map3.url}',
        {layers: '${map3.layers}', visibility: false, transparent: true, format: 'image/png'},
        {opacity: .5, buffer: 0}
      )//,

<%--
      <!-- Overylay: Radar Data-->
      new OpenLayers.Layer.WMS(
        'Radar',
        "${createLink( absolute: true, controller: 'ais', action: 'radarCurrentLocation' )}",
        {layers:'location', format: 'image/png', styles: '{shape: {color: "#FF0000", type: "circle", size: 5}, label: {property: "name"}, fill: {color: "#FF0000", opacity: 0}, halo: {color: "#FF0000", radius: 2}}'},
        {buffer: 0, singleTile: false, transitionEffect: 'resize', isBaseLayer: false/*, minScale: 13841995.078125*/}

      )
--%>
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