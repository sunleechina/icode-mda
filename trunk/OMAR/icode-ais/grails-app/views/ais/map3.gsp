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
  <link rel="stylesheet" href="${resource(contextPath: '', dir: 'css', file: 'main.css')}"/>
  <meta content="aisLayout" name="layout">
</head>

<body class=" yui-skin-sam">
<content tag="top">
  <div class="nav">
    <span class="menuButton">
      <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
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
    map = new OpenLayers.Map( 'map' );

    var link = "${createLink(absolute: true, controller: 'ais', action: 'wms')}"
    // "http://localhost:8080/omar/ais/wms"

    layers = [
      new OpenLayers.Layer.WMS(
        "OpenLayers WMS",
        "http://vmap0.tiles.osgeo.org/wms/vmap0",
        {layers: 'basic'}
      ),

      new OpenLayers.Layer.WMS(
        "Reference",
        "http://${InetAddress.localHost.hostAddress}/cgi-bin/mapserv?map=/data/omar/bmng.map&",
        {layers:'Reference', format: 'image/jpeg'},
        {buffer: 0, transitionEffect: 'resize'}
      ),

      new OpenLayers.Layer.WMS(
        "AIS",
        link,
        {layers:'location', format: 'image/png', styles: '{shape: {color: "#FF0000", type: "circle", size: 5}, fill: {color: "#000000", opacity: 0}, label: {property: "name"}}'},
        {buffer: 0, singleTile: true, transitionEffect: 'resize', isBaseLayer: false, /*minScale: 13841995.078125*/}
      ),

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

function resize()
{
    map.updateSize();
}
</g:javascript>
</body>
</html>