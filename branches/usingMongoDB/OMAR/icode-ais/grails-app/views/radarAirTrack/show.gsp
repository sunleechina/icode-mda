
<%@ page import="gov.spawar.icode.RadarAirTrack" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'radarAirTrack.label', default: 'RadarAirTrack')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-radarAirTrack" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-radarAirTrack" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list radarAirTrack">
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_kluster}">
				<li class="fieldcontain">
					<span id="sdsTrackID_kluster-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_kluster.label" default="Sds Track ID kluster" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_kluster-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_kluster"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_port}">
				<li class="fieldcontain">
					<span id="sdsTrackID_port-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_port.label" default="Sds Track ID port" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_port-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_port"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_platform}">
				<li class="fieldcontain">
					<span id="sdsTrackID_platform-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_platform.label" default="Sds Track ID platform" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_platform-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_platform"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_category}">
				<li class="fieldcontain">
					<span id="sdsTrackID_category-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_category.label" default="Sds Track ID category" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_category-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_amplification}">
				<li class="fieldcontain">
					<span id="sdsTrackID_amplification-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_amplification.label" default="Sds Track ID amplification" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_amplification-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_amplification"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_site}">
				<li class="fieldcontain">
					<span id="sdsTrackID_site-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_site.label" default="Sds Track ID site" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_site-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_site"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.ETAday}">
				<li class="fieldcontain">
					<span id="ETAday-label" class="property-label"><g:message code="radarAirTrack.ETAday.label" default="ETA day" /></span>
					
						<span class="property-value" aria-labelledby="ETAday-label"><g:fieldValue bean="${radarAirTrackInstance}" field="ETAday"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.ETAhour}">
				<li class="fieldcontain">
					<span id="ETAhour-label" class="property-label"><g:message code="radarAirTrack.ETAhour.label" default="ETA hour" /></span>
					
						<span class="property-value" aria-labelledby="ETAhour-label"><g:fieldValue bean="${radarAirTrackInstance}" field="ETAhour"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.ETAminute}">
				<li class="fieldcontain">
					<span id="ETAminute-label" class="property-label"><g:message code="radarAirTrack.ETAminute.label" default="ETA minute" /></span>
					
						<span class="property-value" aria-labelledby="ETAminute-label"><g:fieldValue bean="${radarAirTrackInstance}" field="ETAminute"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.ETAmonth}">
				<li class="fieldcontain">
					<span id="ETAmonth-label" class="property-label"><g:message code="radarAirTrack.ETAmonth.label" default="ETA month" /></span>
					
						<span class="property-value" aria-labelledby="ETAmonth-label"><g:fieldValue bean="${radarAirTrackInstance}" field="ETAmonth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.ROT}">
				<li class="fieldcontain">
					<span id="ROT-label" class="property-label"><g:message code="radarAirTrack.ROT.label" default="ROT" /></span>
					
						<span class="property-value" aria-labelledby="ROT-label"><g:fieldValue bean="${radarAirTrackInstance}" field="ROT"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.UID}">
				<li class="fieldcontain">
					<span id="UID-label" class="property-label"><g:message code="radarAirTrack.UID.label" default="UID" /></span>
					
						<span class="property-value" aria-labelledby="UID-label"><g:fieldValue bean="${radarAirTrackInstance}" field="UID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.altitudeGNSS}">
				<li class="fieldcontain">
					<span id="altitudeGNSS-label" class="property-label"><g:message code="radarAirTrack.altitudeGNSS.label" default="Altitude GNSS" /></span>
					
						<span class="property-value" aria-labelledby="altitudeGNSS-label"><g:fieldValue bean="${radarAirTrackInstance}" field="altitudeGNSS"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bCenterPositionValid}">
				<li class="fieldcontain">
					<span id="bCenterPositionValid-label" class="property-label"><g:message code="radarAirTrack.bCenterPositionValid.label" default="BC enter Position Valid" /></span>
					
						<span class="property-value" aria-labelledby="bCenterPositionValid-label"><g:fieldValue bean="${radarAirTrackInstance}" field="bCenterPositionValid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bClassA}">
				<li class="fieldcontain">
					<span id="bClassA-label" class="property-label"><g:message code="radarAirTrack.bClassA.label" default="BC lass A" /></span>
					
						<span class="property-value" aria-labelledby="bClassA-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bClassA}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bHDDirChange}">
				<li class="fieldcontain">
					<span id="bHDDirChange-label" class="property-label"><g:message code="radarAirTrack.bHDDirChange.label" default="BHDD ir Change" /></span>
					
						<span class="property-value" aria-labelledby="bHDDirChange-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bHDDirChange}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bHDHorizVel}">
				<li class="fieldcontain">
					<span id="bHDHorizVel-label" class="property-label"><g:message code="radarAirTrack.bHDHorizVel.label" default="BHDH oriz Vel" /></span>
					
						<span class="property-value" aria-labelledby="bHDHorizVel-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bHDHorizVel}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bHDVertVel}">
				<li class="fieldcontain">
					<span id="bHDVertVel-label" class="property-label"><g:message code="radarAirTrack.bHDVertVel.label" default="BHDV ert Vel" /></span>
					
						<span class="property-value" aria-labelledby="bHDVertVel-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bHDVertVel}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bHighDynamic}">
				<li class="fieldcontain">
					<span id="bHighDynamic-label" class="property-label"><g:message code="radarAirTrack.bHighDynamic.label" default="BH igh Dynamic" /></span>
					
						<span class="property-value" aria-labelledby="bHighDynamic-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bHighDynamic}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bIgnoreAlarms}">
				<li class="fieldcontain">
					<span id="bIgnoreAlarms-label" class="property-label"><g:message code="radarAirTrack.bIgnoreAlarms.label" default="BI gnore Alarms" /></span>
					
						<span class="property-value" aria-labelledby="bIgnoreAlarms-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bIgnoreAlarms}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bLessThan10MetersError}">
				<li class="fieldcontain">
					<span id="bLessThan10MetersError-label" class="property-label"><g:message code="radarAirTrack.bLessThan10MetersError.label" default="BL ess Than10 Meters Error" /></span>
					
						<span class="property-value" aria-labelledby="bLessThan10MetersError-label"><g:fieldValue bean="${radarAirTrackInstance}" field="bLessThan10MetersError"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bMobileTrack}">
				<li class="fieldcontain">
					<span id="bMobileTrack-label" class="property-label"><g:message code="radarAirTrack.bMobileTrack.label" default="BM obile Track" /></span>
					
						<span class="property-value" aria-labelledby="bMobileTrack-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bMobileTrack}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bMode2Valid}">
				<li class="fieldcontain">
					<span id="bMode2Valid-label" class="property-label"><g:message code="radarAirTrack.bMode2Valid.label" default="BM ode2 Valid" /></span>
					
						<span class="property-value" aria-labelledby="bMode2Valid-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bMode2Valid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bPlayerListIdValid}">
				<li class="fieldcontain">
					<span id="bPlayerListIdValid-label" class="property-label"><g:message code="radarAirTrack.bPlayerListIdValid.label" default="BP layer List Id Valid" /></span>
					
						<span class="property-value" aria-labelledby="bPlayerListIdValid-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bPlayerListIdValid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bPrecisionAltDiffSet}">
				<li class="fieldcontain">
					<span id="bPrecisionAltDiffSet-label" class="property-label"><g:message code="radarAirTrack.bPrecisionAltDiffSet.label" default="BP recision Alt Diff Set" /></span>
					
						<span class="property-value" aria-labelledby="bPrecisionAltDiffSet-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bPrecisionAltDiffSet}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bSensorMode2Valid}">
				<li class="fieldcontain">
					<span id="bSensorMode2Valid-label" class="property-label"><g:message code="radarAirTrack.bSensorMode2Valid.label" default="BS ensor Mode2 Valid" /></span>
					
						<span class="property-value" aria-labelledby="bSensorMode2Valid-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bSensorMode2Valid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bSensorMode3Valid}">
				<li class="fieldcontain">
					<span id="bSensorMode3Valid-label" class="property-label"><g:message code="radarAirTrack.bSensorMode3Valid.label" default="BS ensor Mode3 Valid" /></span>
					
						<span class="property-value" aria-labelledby="bSensorMode3Valid-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bSensorMode3Valid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bSensorSite}">
				<li class="fieldcontain">
					<span id="bSensorSite-label" class="property-label"><g:message code="radarAirTrack.bSensorSite.label" default="BS ensor Site" /></span>
					
						<span class="property-value" aria-labelledby="bSensorSite-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bSensorSite}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bSurfaceTrack}">
				<li class="fieldcontain">
					<span id="bSurfaceTrack-label" class="property-label"><g:message code="radarAirTrack.bSurfaceTrack.label" default="BS urface Track" /></span>
					
						<span class="property-value" aria-labelledby="bSurfaceTrack-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bSurfaceTrack}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.bVecValid}">
				<li class="fieldcontain">
					<span id="bVecValid-label" class="property-label"><g:message code="radarAirTrack.bVecValid.label" default="BV ec Valid" /></span>
					
						<span class="property-value" aria-labelledby="bVecValid-label"><g:formatBoolean boolean="${radarAirTrackInstance?.bVecValid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.callSign}">
				<li class="fieldcontain">
					<span id="callSign-label" class="property-label"><g:message code="radarAirTrack.callSign.label" default="Call Sign" /></span>
					
						<span class="property-value" aria-labelledby="callSign-label"><g:fieldValue bean="${radarAirTrackInstance}" field="callSign"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.centerLat}">
				<li class="fieldcontain">
					<span id="centerLat-label" class="property-label"><g:message code="radarAirTrack.centerLat.label" default="Center Lat" /></span>
					
						<span class="property-value" aria-labelledby="centerLat-label"><g:fieldValue bean="${radarAirTrackInstance}" field="centerLat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.centerLon}">
				<li class="fieldcontain">
					<span id="centerLon-label" class="property-label"><g:message code="radarAirTrack.centerLon.label" default="Center Lon" /></span>
					
						<span class="property-value" aria-labelledby="centerLon-label"><g:fieldValue bean="${radarAirTrackInstance}" field="centerLon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.climb}">
				<li class="fieldcontain">
					<span id="climb-label" class="property-label"><g:message code="radarAirTrack.climb.label" default="Climb" /></span>
					
						<span class="property-value" aria-labelledby="climb-label"><g:fieldValue bean="${radarAirTrackInstance}" field="climb"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.condition}">
				<li class="fieldcontain">
					<span id="condition-label" class="property-label"><g:message code="radarAirTrack.condition.label" default="Condition" /></span>
					
						<span class="property-value" aria-labelledby="condition-label"><g:fieldValue bean="${radarAirTrackInstance}" field="condition"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner1Lat}">
				<li class="fieldcontain">
					<span id="corner1Lat-label" class="property-label"><g:message code="radarAirTrack.corner1Lat.label" default="Corner1 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner1Lat-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner1Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner1Lon}">
				<li class="fieldcontain">
					<span id="corner1Lon-label" class="property-label"><g:message code="radarAirTrack.corner1Lon.label" default="Corner1 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner1Lon-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner1Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner2Lat}">
				<li class="fieldcontain">
					<span id="corner2Lat-label" class="property-label"><g:message code="radarAirTrack.corner2Lat.label" default="Corner2 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner2Lat-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner2Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner2Lon}">
				<li class="fieldcontain">
					<span id="corner2Lon-label" class="property-label"><g:message code="radarAirTrack.corner2Lon.label" default="Corner2 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner2Lon-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner2Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner3Lat}">
				<li class="fieldcontain">
					<span id="corner3Lat-label" class="property-label"><g:message code="radarAirTrack.corner3Lat.label" default="Corner3 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner3Lat-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner3Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner3Lon}">
				<li class="fieldcontain">
					<span id="corner3Lon-label" class="property-label"><g:message code="radarAirTrack.corner3Lon.label" default="Corner3 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner3Lon-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner3Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner4Lat}">
				<li class="fieldcontain">
					<span id="corner4Lat-label" class="property-label"><g:message code="radarAirTrack.corner4Lat.label" default="Corner4 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner4Lat-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner4Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.corner4Lon}">
				<li class="fieldcontain">
					<span id="corner4Lon-label" class="property-label"><g:message code="radarAirTrack.corner4Lon.label" default="Corner4 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner4Lon-label"><g:fieldValue bean="${radarAirTrackInstance}" field="corner4Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.destination}">
				<li class="fieldcontain">
					<span id="destination-label" class="property-label"><g:message code="radarAirTrack.destination.label" default="Destination" /></span>
					
						<span class="property-value" aria-labelledby="destination-label"><g:fieldValue bean="${radarAirTrackInstance}" field="destination"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.dimensionLength}">
				<li class="fieldcontain">
					<span id="dimensionLength-label" class="property-label"><g:message code="radarAirTrack.dimensionLength.label" default="Dimension Length" /></span>
					
						<span class="property-value" aria-labelledby="dimensionLength-label"><g:fieldValue bean="${radarAirTrackInstance}" field="dimensionLength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.dimensionWidth}">
				<li class="fieldcontain">
					<span id="dimensionWidth-label" class="property-label"><g:message code="radarAirTrack.dimensionWidth.label" default="Dimension Width" /></span>
					
						<span class="property-value" aria-labelledby="dimensionWidth-label"><g:fieldValue bean="${radarAirTrackInstance}" field="dimensionWidth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAADebugFlag}">
				<li class="fieldcontain">
					<span id="extAADebugFlag-label" class="property-label"><g:message code="radarAirTrack.extAADebugFlag.label" default="Ext AAD ebug Flag" /></span>
					
						<span class="property-value" aria-labelledby="extAADebugFlag-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAADebugFlag"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAAHorizBuf}">
				<li class="fieldcontain">
					<span id="extAAHorizBuf-label" class="property-label"><g:message code="radarAirTrack.extAAHorizBuf.label" default="Ext AAH oriz Buf" /></span>
					
						<span class="property-value" aria-labelledby="extAAHorizBuf-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAAHorizBuf"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAAHorzSep}">
				<li class="fieldcontain">
					<span id="extAAHorzSep-label" class="property-label"><g:message code="radarAirTrack.extAAHorzSep.label" default="Ext AAH orz Sep" /></span>
					
						<span class="property-value" aria-labelledby="extAAHorzSep-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAAHorzSep"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAALookAhead}">
				<li class="fieldcontain">
					<span id="extAALookAhead-label" class="property-label"><g:message code="radarAirTrack.extAALookAhead.label" default="Ext AAL ook Ahead" /></span>
					
						<span class="property-value" aria-labelledby="extAALookAhead-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAALookAhead"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAAVertExten}">
				<li class="fieldcontain">
					<span id="extAAVertExten-label" class="property-label"><g:message code="radarAirTrack.extAAVertExten.label" default="Ext AAV ert Exten" /></span>
					
						<span class="property-value" aria-labelledby="extAAVertExten-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAAVertExten"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAAVertSep}">
				<li class="fieldcontain">
					<span id="extAAVertSep-label" class="property-label"><g:message code="radarAirTrack.extAAVertSep.label" default="Ext AAV ert Sep" /></span>
					
						<span class="property-value" aria-labelledby="extAAVertSep-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAAVertSep"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.extAAVertVel}">
				<li class="fieldcontain">
					<span id="extAAVertVel-label" class="property-label"><g:message code="radarAirTrack.extAAVertVel.label" default="Ext AAV ert Vel" /></span>
					
						<span class="property-value" aria-labelledby="extAAVertVel-label"><g:fieldValue bean="${radarAirTrackInstance}" field="extAAVertVel"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.heading}">
				<li class="fieldcontain">
					<span id="heading-label" class="property-label"><g:message code="radarAirTrack.heading.label" default="Heading" /></span>
					
						<span class="property-value" aria-labelledby="heading-label"><g:fieldValue bean="${radarAirTrackInstance}" field="heading"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.locations}">
				<li class="fieldcontain">
					<span id="locations-label" class="property-label"><g:message code="radarAirTrack.locations.label" default="Locations" /></span>
					
						<g:each in="${radarAirTrackInstance.locations}" var="l">
						<span class="property-value" aria-labelledby="locations-label"><g:link controller="location" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.maxDraught}">
				<li class="fieldcontain">
					<span id="maxDraught-label" class="property-label"><g:message code="radarAirTrack.maxDraught.label" default="Max Draught" /></span>
					
						<span class="property-value" aria-labelledby="maxDraught-label"><g:fieldValue bean="${radarAirTrackInstance}" field="maxDraught"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.md_3a_validity}">
				<li class="fieldcontain">
					<span id="md_3a_validity-label" class="property-label"><g:message code="radarAirTrack.md_3a_validity.label" default="Md3avalidity" /></span>
					
						<span class="property-value" aria-labelledby="md_3a_validity-label"><g:formatBoolean boolean="${radarAirTrackInstance?.md_3a_validity}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.md_c_validity}">
				<li class="fieldcontain">
					<span id="md_c_validity-label" class="property-label"><g:message code="radarAirTrack.md_c_validity.label" default="Mdcvalidity" /></span>
					
						<span class="property-value" aria-labelledby="md_c_validity-label"><g:formatBoolean boolean="${radarAirTrackInstance?.md_c_validity}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.messageID}">
				<li class="fieldcontain">
					<span id="messageID-label" class="property-label"><g:message code="radarAirTrack.messageID.label" default="Message ID" /></span>
					
						<span class="property-value" aria-labelledby="messageID-label"><g:fieldValue bean="${radarAirTrackInstance}" field="messageID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.messageTime}">
				<li class="fieldcontain">
					<span id="messageTime-label" class="property-label"><g:message code="radarAirTrack.messageTime.label" default="Message Time" /></span>
					
						<span class="property-value" aria-labelledby="messageTime-label"><g:fieldValue bean="${radarAirTrackInstance}" field="messageTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.mode2}">
				<li class="fieldcontain">
					<span id="mode2-label" class="property-label"><g:message code="radarAirTrack.mode2.label" default="Mode2" /></span>
					
						<span class="property-value" aria-labelledby="mode2-label"><g:fieldValue bean="${radarAirTrackInstance}" field="mode2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.mode3A}">
				<li class="fieldcontain">
					<span id="mode3A-label" class="property-label"><g:message code="radarAirTrack.mode3A.label" default="Mode3 A" /></span>
					
						<span class="property-value" aria-labelledby="mode3A-label"><g:fieldValue bean="${radarAirTrackInstance}" field="mode3A"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="radarAirTrack.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${radarAirTrackInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.playerListId}">
				<li class="fieldcontain">
					<span id="playerListId-label" class="property-label"><g:message code="radarAirTrack.playerListId.label" default="Player List Id" /></span>
					
						<span class="property-value" aria-labelledby="playerListId-label"><g:fieldValue bean="${radarAirTrackInstance}" field="playerListId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.portalName}">
				<li class="fieldcontain">
					<span id="portalName-label" class="property-label"><g:message code="radarAirTrack.portalName.label" default="Portal Name" /></span>
					
						<span class="property-value" aria-labelledby="portalName-label"><g:fieldValue bean="${radarAirTrackInstance}" field="portalName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.precisionAltDiff}">
				<li class="fieldcontain">
					<span id="precisionAltDiff-label" class="property-label"><g:message code="radarAirTrack.precisionAltDiff.label" default="Precision Alt Diff" /></span>
					
						<span class="property-value" aria-labelledby="precisionAltDiff-label"><g:fieldValue bean="${radarAirTrackInstance}" field="precisionAltDiff"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.quality}">
				<li class="fieldcontain">
					<span id="quality-label" class="property-label"><g:message code="radarAirTrack.quality.label" default="Quality" /></span>
					
						<span class="property-value" aria-labelledby="quality-label"><g:fieldValue bean="${radarAirTrackInstance}" field="quality"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.radar_num}">
				<li class="fieldcontain">
					<span id="radar_num-label" class="property-label"><g:message code="radarAirTrack.radar_num.label" default="Radarnum" /></span>
					
						<span class="property-value" aria-labelledby="radar_num-label"><g:fieldValue bean="${radarAirTrackInstance}" field="radar_num"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.remote_name}">
				<li class="fieldcontain">
					<span id="remote_name-label" class="property-label"><g:message code="radarAirTrack.remote_name.label" default="Remotename" /></span>
					
						<span class="property-value" aria-labelledby="remote_name-label"><g:fieldValue bean="${radarAirTrackInstance}" field="remote_name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.reportLat}">
				<li class="fieldcontain">
					<span id="reportLat-label" class="property-label"><g:message code="radarAirTrack.reportLat.label" default="Report Lat" /></span>
					
						<span class="property-value" aria-labelledby="reportLat-label"><g:fieldValue bean="${radarAirTrackInstance}" field="reportLat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.reportLon}">
				<li class="fieldcontain">
					<span id="reportLon-label" class="property-label"><g:message code="radarAirTrack.reportLon.label" default="Report Lon" /></span>
					
						<span class="property-value" aria-labelledby="reportLon-label"><g:fieldValue bean="${radarAirTrackInstance}" field="reportLon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsIndex}">
				<li class="fieldcontain">
					<span id="sdsIndex-label" class="property-label"><g:message code="radarAirTrack.sdsIndex.label" default="Sds Index" /></span>
					
						<span class="property-value" aria-labelledby="sdsIndex-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsIndex"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_radar}">
				<li class="fieldcontain">
					<span id="sdsTrackID_radar-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_radar.label" default="Sds Track ID radar" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_radar-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_radar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sdsTrackID_trackID}">
				<li class="fieldcontain">
					<span id="sdsTrackID_trackID-label" class="property-label"><g:message code="radarAirTrack.sdsTrackID_trackID.label" default="Sds Track ID track ID" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_trackID-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sdsTrackID_trackID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sensorCondition}">
				<li class="fieldcontain">
					<span id="sensorCondition-label" class="property-label"><g:message code="radarAirTrack.sensorCondition.label" default="Sensor Condition" /></span>
					
						<span class="property-value" aria-labelledby="sensorCondition-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sensorCondition"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sensorMode2}">
				<li class="fieldcontain">
					<span id="sensorMode2-label" class="property-label"><g:message code="radarAirTrack.sensorMode2.label" default="Sensor Mode2" /></span>
					
						<span class="property-value" aria-labelledby="sensorMode2-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sensorMode2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.sensorMode3}">
				<li class="fieldcontain">
					<span id="sensorMode3-label" class="property-label"><g:message code="radarAirTrack.sensorMode3.label" default="Sensor Mode3" /></span>
					
						<span class="property-value" aria-labelledby="sensorMode3-label"><g:fieldValue bean="${radarAirTrackInstance}" field="sensorMode3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.speed}">
				<li class="fieldcontain">
					<span id="speed-label" class="property-label"><g:message code="radarAirTrack.speed.label" default="Speed" /></span>
					
						<span class="property-value" aria-labelledby="speed-label"><g:fieldValue bean="${radarAirTrackInstance}" field="speed"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_amplification}">
				<li class="fieldcontain">
					<span id="systemTrackID_amplification-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_amplification.label" default="System Track ID amplification" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_amplification-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_amplification"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_category}">
				<li class="fieldcontain">
					<span id="systemTrackID_category-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_category.label" default="System Track ID category" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_category-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_kluster}">
				<li class="fieldcontain">
					<span id="systemTrackID_kluster-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_kluster.label" default="System Track ID kluster" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_kluster-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_kluster"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_platform}">
				<li class="fieldcontain">
					<span id="systemTrackID_platform-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_platform.label" default="System Track ID platform" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_platform-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_platform"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_port}">
				<li class="fieldcontain">
					<span id="systemTrackID_port-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_port.label" default="System Track ID port" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_port-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_port"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_radar}">
				<li class="fieldcontain">
					<span id="systemTrackID_radar-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_radar.label" default="System Track ID radar" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_radar-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_radar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_site}">
				<li class="fieldcontain">
					<span id="systemTrackID_site-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_site.label" default="System Track ID site" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_site-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_site"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.systemTrackID_trackID}">
				<li class="fieldcontain">
					<span id="systemTrackID_trackID-label" class="property-label"><g:message code="radarAirTrack.systemTrackID_trackID.label" default="System Track ID track ID" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_trackID-label"><g:fieldValue bean="${radarAirTrackInstance}" field="systemTrackID_trackID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="radarAirTrack.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:fieldValue bean="${radarAirTrackInstance}" field="time"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.trackStatus}">
				<li class="fieldcontain">
					<span id="trackStatus-label" class="property-label"><g:message code="radarAirTrack.trackStatus.label" default="Track Status" /></span>
					
						<span class="property-value" aria-labelledby="trackStatus-label"><g:fieldValue bean="${radarAirTrackInstance}" field="trackStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.trueHeading}">
				<li class="fieldcontain">
					<span id="trueHeading-label" class="property-label"><g:message code="radarAirTrack.trueHeading.label" default="True Heading" /></span>
					
						<span class="property-value" aria-labelledby="trueHeading-label"><g:fieldValue bean="${radarAirTrackInstance}" field="trueHeading"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.typeOfPositionDevice}">
				<li class="fieldcontain">
					<span id="typeOfPositionDevice-label" class="property-label"><g:message code="radarAirTrack.typeOfPositionDevice.label" default="Type Of Position Device" /></span>
					
						<span class="property-value" aria-labelledby="typeOfPositionDevice-label"><g:fieldValue bean="${radarAirTrackInstance}" field="typeOfPositionDevice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.typeOfShip1}">
				<li class="fieldcontain">
					<span id="typeOfShip1-label" class="property-label"><g:message code="radarAirTrack.typeOfShip1.label" default="Type Of Ship1" /></span>
					
						<span class="property-value" aria-labelledby="typeOfShip1-label"><g:fieldValue bean="${radarAirTrackInstance}" field="typeOfShip1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.typeOfShip2}">
				<li class="fieldcontain">
					<span id="typeOfShip2-label" class="property-label"><g:message code="radarAirTrack.typeOfShip2.label" default="Type Of Ship2" /></span>
					
						<span class="property-value" aria-labelledby="typeOfShip2-label"><g:fieldValue bean="${radarAirTrackInstance}" field="typeOfShip2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarAirTrackInstance?.userId}">
				<li class="fieldcontain">
					<span id="userId-label" class="property-label"><g:message code="radarAirTrack.userId.label" default="User Id" /></span>
					
						<span class="property-value" aria-labelledby="userId-label"><g:fieldValue bean="${radarAirTrackInstance}" field="userId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${radarAirTrackInstance?.id}" />
					<g:link class="edit" action="edit" id="${radarAirTrackInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
