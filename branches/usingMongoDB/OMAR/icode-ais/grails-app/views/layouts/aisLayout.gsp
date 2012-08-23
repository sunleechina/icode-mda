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
  <title><g:layoutTitle default="AIS"/></title>
  <style type="text/css">
    /*
    margin and padding on body element
    can introduce errors in determining
    element position and are not recommended;
    we turn them off as a foundation for YUI
    CSS treatments.
    */
  body {
    margin: 0;
    padding: 0;
  }
  </style>
  <yui:stylesheet dir="reset-fonts-grids" file="reset-fonts-grids.css"/>
  <yui:stylesheet dir="assets/skins/sam" file="resize.css"/>
  <yui:stylesheet dir="layout/assets/skins/sam" file="layout.css"/>
  <yui:stylesheet dir="assets/skins/sam" file="button.css"/>
  <g:layoutHead/>
</head>

<body class="${pageProperty(name: 'body.class')}">

<div id="top1">
  <g:pageProperty name="page.top"/>
</div>

<div id="bottom1">
  <g:pageProperty name="page.bottom"/>
</div>

<div id="right1">
  <g:pageProperty name="page.right"/>
</div>

<div id="left1">
  <g:pageProperty name="page.left"/>
</div>

<div id="center1">
  <g:pageProperty name="page.center"/>
</div>

<g:layoutBody/>

<yui:javascript dir="yahoo-dom-event" file="yahoo-dom-event.js"/>
<yui:javascript dir="element" file="element-min.js"/>
<yui:javascript dir="dragdrop" file="dragdrop-min.js"/>
<yui:javascript dir="resize" file="resize-min.js"/>
<yui:javascript dir="animation" file="animation-min.js"/>
<yui:javascript dir="layout" file="layout-min.js"/>

<g:javascript>
  (function ()
  {
    var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event;

    Event.onDOMReady( function ()
    {
      var layout = new YAHOO.widget.Layout( {
        units:[
          { position:'top', height:40, body:'top1'/*, header:'Top', gutter:'5px', collapse:true, resize:true*/ },
          { position:'right', header:'Right', width:200, resize:true, gutter:'5px', collapse:true, scroll:true, body:'right1', animate:true },
          { position:'bottom', header:'Bottom', height:100, resize:true, body:'bottom1', gutter:'5px', collapse:true },
          { position:'left', header:'Left', width:200, resize:true, body:'left1', gutter:'5px', collapse:true, scroll:true, animate:true },
          { position:'center', body:'center1' }
        ]
      } );
      layout.on( 'render', function ()
      {
/*
        layout.getUnitByPosition( "top" ).on( "heightChange", function ()
        {
          resize();
        } );
*/
        layout.getUnitByPosition( "bottom" ).on( "heightChange", function ()
        {
          resize();
        } );
        layout.getUnitByPosition( "left" ).on( "widthChange", function ()
        {
          resize();
        } );
        layout.getUnitByPosition( "right" ).on( "widthChange", function ()
        {
          resize();
        } );
        init();
      } );
      layout.render();
    } );
  })();
</g:javascript>
</body>
</html>