
<%@ page import="gov.spawar.icode.RadarSurfTrack" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-radarSurfTrack" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-radarSurfTrack" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list radarSurfTrack">
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_kluster}">
				<li class="fieldcontain">
					<span id="sdsTrackID_kluster-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_kluster.label" default="Sds Track ID kluster" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_kluster-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_kluster"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_port}">
				<li class="fieldcontain">
					<span id="sdsTrackID_port-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_port.label" default="Sds Track ID port" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_port-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_port"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_platform}">
				<li class="fieldcontain">
					<span id="sdsTrackID_platform-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_platform.label" default="Sds Track ID platform" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_platform-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_platform"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_category}">
				<li class="fieldcontain">
					<span id="sdsTrackID_category-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_category.label" default="Sds Track ID category" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_category-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_amplification}">
				<li class="fieldcontain">
					<span id="sdsTrackID_amplification-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_amplification.label" default="Sds Track ID amplification" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_amplification-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_amplification"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_site}">
				<li class="fieldcontain">
					<span id="sdsTrackID_site-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_site.label" default="Sds Track ID site" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_site-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_site"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.acquired}">
				<li class="fieldcontain">
					<span id="acquired-label" class="property-label"><g:message code="radarSurfTrack.acquired.label" default="Acquired" /></span>
					
						<span class="property-value" aria-labelledby="acquired-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="acquired"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bCenterPositionValid}">
				<li class="fieldcontain">
					<span id="bCenterPositionValid-label" class="property-label"><g:message code="radarSurfTrack.bCenterPositionValid.label" default="BC enter Position Valid" /></span>
					
						<span class="property-value" aria-labelledby="bCenterPositionValid-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="bCenterPositionValid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.typeOfShip1}">
				<li class="fieldcontain">
					<span id="typeOfShip1-label" class="property-label"><g:message code="radarSurfTrack.typeOfShip1.label" default="Type Of Ship1" /></span>
					
						<span class="property-value" aria-labelledby="typeOfShip1-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="typeOfShip1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.typeOfShip2}">
				<li class="fieldcontain">
					<span id="typeOfShip2-label" class="property-label"><g:message code="radarSurfTrack.typeOfShip2.label" default="Type Of Ship2" /></span>
					
						<span class="property-value" aria-labelledby="typeOfShip2-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="typeOfShip2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.dimensionLength}">
				<li class="fieldcontain">
					<span id="dimensionLength-label" class="property-label"><g:message code="radarSurfTrack.dimensionLength.label" default="Dimension Length" /></span>
					
						<span class="property-value" aria-labelledby="dimensionLength-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="dimensionLength"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.dimensionWidth}">
				<li class="fieldcontain">
					<span id="dimensionWidth-label" class="property-label"><g:message code="radarSurfTrack.dimensionWidth.label" default="Dimension Width" /></span>
					
						<span class="property-value" aria-labelledby="dimensionWidth-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="dimensionWidth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.etaMonth}">
				<li class="fieldcontain">
					<span id="etaMonth-label" class="property-label"><g:message code="radarSurfTrack.etaMonth.label" default="Eta Month" /></span>
					
						<span class="property-value" aria-labelledby="etaMonth-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="etaMonth"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.etaDay}">
				<li class="fieldcontain">
					<span id="etaDay-label" class="property-label"><g:message code="radarSurfTrack.etaDay.label" default="Eta Day" /></span>
					
						<span class="property-value" aria-labelledby="etaDay-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="etaDay"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.etaHour}">
				<li class="fieldcontain">
					<span id="etaHour-label" class="property-label"><g:message code="radarSurfTrack.etaHour.label" default="Eta Hour" /></span>
					
						<span class="property-value" aria-labelledby="etaHour-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="etaHour"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.etaMinute}">
				<li class="fieldcontain">
					<span id="etaMinute-label" class="property-label"><g:message code="radarSurfTrack.etaMinute.label" default="Eta Minute" /></span>
					
						<span class="property-value" aria-labelledby="etaMinute-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="etaMinute"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.maxDraught}">
				<li class="fieldcontain">
					<span id="maxDraught-label" class="property-label"><g:message code="radarSurfTrack.maxDraught.label" default="Max Draught" /></span>
					
						<span class="property-value" aria-labelledby="maxDraught-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="maxDraught"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.altitudeGNSS}">
				<li class="fieldcontain">
					<span id="altitudeGNSS-label" class="property-label"><g:message code="radarSurfTrack.altitudeGNSS.label" default="Altitude GNSS" /></span>
					
						<span class="property-value" aria-labelledby="altitudeGNSS-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="altitudeGNSS"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.UID}">
				<li class="fieldcontain">
					<span id="UID-label" class="property-label"><g:message code="radarSurfTrack.UID.label" default="UID" /></span>
					
						<span class="property-value" aria-labelledby="UID-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="UID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bClassA}">
				<li class="fieldcontain">
					<span id="bClassA-label" class="property-label"><g:message code="radarSurfTrack.bClassA.label" default="BC lass A" /></span>
					
						<span class="property-value" aria-labelledby="bClassA-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bClassA}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bIgnoreAlarms}">
				<li class="fieldcontain">
					<span id="bIgnoreAlarms-label" class="property-label"><g:message code="radarSurfTrack.bIgnoreAlarms.label" default="BI gnore Alarms" /></span>
					
						<span class="property-value" aria-labelledby="bIgnoreAlarms-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bIgnoreAlarms}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bLessThan10MetersError}">
				<li class="fieldcontain">
					<span id="bLessThan10MetersError-label" class="property-label"><g:message code="radarSurfTrack.bLessThan10MetersError.label" default="BL ess Than10 Meters Error" /></span>
					
						<span class="property-value" aria-labelledby="bLessThan10MetersError-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="bLessThan10MetersError"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bMobileTrack}">
				<li class="fieldcontain">
					<span id="bMobileTrack-label" class="property-label"><g:message code="radarSurfTrack.bMobileTrack.label" default="BM obile Track" /></span>
					
						<span class="property-value" aria-labelledby="bMobileTrack-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bMobileTrack}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bPlayerListIdValid}">
				<li class="fieldcontain">
					<span id="bPlayerListIdValid-label" class="property-label"><g:message code="radarSurfTrack.bPlayerListIdValid.label" default="BP layer List Id Valid" /></span>
					
						<span class="property-value" aria-labelledby="bPlayerListIdValid-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bPlayerListIdValid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bSensorSite}">
				<li class="fieldcontain">
					<span id="bSensorSite-label" class="property-label"><g:message code="radarSurfTrack.bSensorSite.label" default="BS ensor Site" /></span>
					
						<span class="property-value" aria-labelledby="bSensorSite-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bSensorSite}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bSurfaceTrack}">
				<li class="fieldcontain">
					<span id="bSurfaceTrack-label" class="property-label"><g:message code="radarSurfTrack.bSurfaceTrack.label" default="BS urface Track" /></span>
					
						<span class="property-value" aria-labelledby="bSurfaceTrack-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bSurfaceTrack}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.bVecValid}">
				<li class="fieldcontain">
					<span id="bVecValid-label" class="property-label"><g:message code="radarSurfTrack.bVecValid.label" default="BV ec Valid" /></span>
					
						<span class="property-value" aria-labelledby="bVecValid-label"><g:formatBoolean boolean="${radarSurfTrackInstance?.bVecValid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.callSign}">
				<li class="fieldcontain">
					<span id="callSign-label" class="property-label"><g:message code="radarSurfTrack.callSign.label" default="Call Sign" /></span>
					
						<span class="property-value" aria-labelledby="callSign-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="callSign"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.centerLat}">
				<li class="fieldcontain">
					<span id="centerLat-label" class="property-label"><g:message code="radarSurfTrack.centerLat.label" default="Center Lat" /></span>
					
						<span class="property-value" aria-labelledby="centerLat-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="centerLat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.centerLon}">
				<li class="fieldcontain">
					<span id="centerLon-label" class="property-label"><g:message code="radarSurfTrack.centerLon.label" default="Center Lon" /></span>
					
						<span class="property-value" aria-labelledby="centerLon-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="centerLon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.climb}">
				<li class="fieldcontain">
					<span id="climb-label" class="property-label"><g:message code="radarSurfTrack.climb.label" default="Climb" /></span>
					
						<span class="property-value" aria-labelledby="climb-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="climb"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner1Lat}">
				<li class="fieldcontain">
					<span id="corner1Lat-label" class="property-label"><g:message code="radarSurfTrack.corner1Lat.label" default="Corner1 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner1Lat-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner1Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner1Lon}">
				<li class="fieldcontain">
					<span id="corner1Lon-label" class="property-label"><g:message code="radarSurfTrack.corner1Lon.label" default="Corner1 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner1Lon-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner1Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner2Lat}">
				<li class="fieldcontain">
					<span id="corner2Lat-label" class="property-label"><g:message code="radarSurfTrack.corner2Lat.label" default="Corner2 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner2Lat-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner2Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner2Lon}">
				<li class="fieldcontain">
					<span id="corner2Lon-label" class="property-label"><g:message code="radarSurfTrack.corner2Lon.label" default="Corner2 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner2Lon-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner2Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner3Lat}">
				<li class="fieldcontain">
					<span id="corner3Lat-label" class="property-label"><g:message code="radarSurfTrack.corner3Lat.label" default="Corner3 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner3Lat-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner3Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner3Lon}">
				<li class="fieldcontain">
					<span id="corner3Lon-label" class="property-label"><g:message code="radarSurfTrack.corner3Lon.label" default="Corner3 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner3Lon-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner3Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner4Lat}">
				<li class="fieldcontain">
					<span id="corner4Lat-label" class="property-label"><g:message code="radarSurfTrack.corner4Lat.label" default="Corner4 Lat" /></span>
					
						<span class="property-value" aria-labelledby="corner4Lat-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner4Lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.corner4Lon}">
				<li class="fieldcontain">
					<span id="corner4Lon-label" class="property-label"><g:message code="radarSurfTrack.corner4Lon.label" default="Corner4 Lon" /></span>
					
						<span class="property-value" aria-labelledby="corner4Lon-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="corner4Lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.destination}">
				<li class="fieldcontain">
					<span id="destination-label" class="property-label"><g:message code="radarSurfTrack.destination.label" default="Destination" /></span>
					
						<span class="property-value" aria-labelledby="destination-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="destination"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.heading}">
				<li class="fieldcontain">
					<span id="heading-label" class="property-label"><g:message code="radarSurfTrack.heading.label" default="Heading" /></span>
					
						<span class="property-value" aria-labelledby="heading-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="heading"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.locations}">
				<li class="fieldcontain">
					<span id="locations-label" class="property-label"><g:message code="radarSurfTrack.locations.label" default="Locations" /></span>
					
						<g:each in="${radarSurfTrackInstance.locations}" var="l">
						<span class="property-value" aria-labelledby="locations-label"><g:link controller="location" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.messageID}">
				<li class="fieldcontain">
					<span id="messageID-label" class="property-label"><g:message code="radarSurfTrack.messageID.label" default="Message ID" /></span>
					
						<span class="property-value" aria-labelledby="messageID-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="messageID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.messageTime}">
				<li class="fieldcontain">
					<span id="messageTime-label" class="property-label"><g:message code="radarSurfTrack.messageTime.label" default="Message Time" /></span>
					
						<span class="property-value" aria-labelledby="messageTime-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="messageTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="radarSurfTrack.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.playerListId}">
				<li class="fieldcontain">
					<span id="playerListId-label" class="property-label"><g:message code="radarSurfTrack.playerListId.label" default="Player List Id" /></span>
					
						<span class="property-value" aria-labelledby="playerListId-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="playerListId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.plotSize}">
				<li class="fieldcontain">
					<span id="plotSize-label" class="property-label"><g:message code="radarSurfTrack.plotSize.label" default="Plot Size" /></span>
					
						<span class="property-value" aria-labelledby="plotSize-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="plotSize"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.portalName}">
				<li class="fieldcontain">
					<span id="portalName-label" class="property-label"><g:message code="radarSurfTrack.portalName.label" default="Portal Name" /></span>
					
						<span class="property-value" aria-labelledby="portalName-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="portalName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.quality}">
				<li class="fieldcontain">
					<span id="quality-label" class="property-label"><g:message code="radarSurfTrack.quality.label" default="Quality" /></span>
					
						<span class="property-value" aria-labelledby="quality-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="quality"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.range}">
				<li class="fieldcontain">
					<span id="range-label" class="property-label"><g:message code="radarSurfTrack.range.label" default="Range" /></span>
					
						<span class="property-value" aria-labelledby="range-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="range"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.remote_name}">
				<li class="fieldcontain">
					<span id="remote_name-label" class="property-label"><g:message code="radarSurfTrack.remote_name.label" default="Remotename" /></span>
					
						<span class="property-value" aria-labelledby="remote_name-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="remote_name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.reportLat}">
				<li class="fieldcontain">
					<span id="reportLat-label" class="property-label"><g:message code="radarSurfTrack.reportLat.label" default="Report Lat" /></span>
					
						<span class="property-value" aria-labelledby="reportLat-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="reportLat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.reportLon}">
				<li class="fieldcontain">
					<span id="reportLon-label" class="property-label"><g:message code="radarSurfTrack.reportLon.label" default="Report Lon" /></span>
					
						<span class="property-value" aria-labelledby="reportLon-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="reportLon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.reportTime}">
				<li class="fieldcontain">
					<span id="reportTime-label" class="property-label"><g:message code="radarSurfTrack.reportTime.label" default="Report Time" /></span>
					
						<span class="property-value" aria-labelledby="reportTime-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="reportTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.rot}">
				<li class="fieldcontain">
					<span id="rot-label" class="property-label"><g:message code="radarSurfTrack.rot.label" default="Rot" /></span>
					
						<span class="property-value" aria-labelledby="rot-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="rot"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsIndex}">
				<li class="fieldcontain">
					<span id="sdsIndex-label" class="property-label"><g:message code="radarSurfTrack.sdsIndex.label" default="Sds Index" /></span>
					
						<span class="property-value" aria-labelledby="sdsIndex-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsIndex"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_radar}">
				<li class="fieldcontain">
					<span id="sdsTrackID_radar-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_radar.label" default="Sds Track ID radar" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_radar-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_radar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.sdsTrackID_trackID}">
				<li class="fieldcontain">
					<span id="sdsTrackID_trackID-label" class="property-label"><g:message code="radarSurfTrack.sdsTrackID_trackID.label" default="Sds Track ID track ID" /></span>
					
						<span class="property-value" aria-labelledby="sdsTrackID_trackID-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="sdsTrackID_trackID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.speed}">
				<li class="fieldcontain">
					<span id="speed-label" class="property-label"><g:message code="radarSurfTrack.speed.label" default="Speed" /></span>
					
						<span class="property-value" aria-labelledby="speed-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="speed"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_amplification}">
				<li class="fieldcontain">
					<span id="systemTrackID_amplification-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_amplification.label" default="System Track ID amplification" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_amplification-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_amplification"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_category}">
				<li class="fieldcontain">
					<span id="systemTrackID_category-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_category.label" default="System Track ID category" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_category-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_kluster}">
				<li class="fieldcontain">
					<span id="systemTrackID_kluster-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_kluster.label" default="System Track ID kluster" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_kluster-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_kluster"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_platform}">
				<li class="fieldcontain">
					<span id="systemTrackID_platform-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_platform.label" default="System Track ID platform" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_platform-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_platform"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_port}">
				<li class="fieldcontain">
					<span id="systemTrackID_port-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_port.label" default="System Track ID port" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_port-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_port"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_radar}">
				<li class="fieldcontain">
					<span id="systemTrackID_radar-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_radar.label" default="System Track ID radar" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_radar-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_radar"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_site}">
				<li class="fieldcontain">
					<span id="systemTrackID_site-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_site.label" default="System Track ID site" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_site-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_site"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.systemTrackID_trackID}">
				<li class="fieldcontain">
					<span id="systemTrackID_trackID-label" class="property-label"><g:message code="radarSurfTrack.systemTrackID_trackID.label" default="System Track ID track ID" /></span>
					
						<span class="property-value" aria-labelledby="systemTrackID_trackID-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="systemTrackID_trackID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="radarSurfTrack.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="time"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.trackStatus}">
				<li class="fieldcontain">
					<span id="trackStatus-label" class="property-label"><g:message code="radarSurfTrack.trackStatus.label" default="Track Status" /></span>
					
						<span class="property-value" aria-labelledby="trackStatus-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="trackStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.trueHeading}">
				<li class="fieldcontain">
					<span id="trueHeading-label" class="property-label"><g:message code="radarSurfTrack.trueHeading.label" default="True Heading" /></span>
					
						<span class="property-value" aria-labelledby="trueHeading-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="trueHeading"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="radarSurfTrack.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.typeOfPositionDevice}">
				<li class="fieldcontain">
					<span id="typeOfPositionDevice-label" class="property-label"><g:message code="radarSurfTrack.typeOfPositionDevice.label" default="Type Of Position Device" /></span>
					
						<span class="property-value" aria-labelledby="typeOfPositionDevice-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="typeOfPositionDevice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.userId}">
				<li class="fieldcontain">
					<span id="userId-label" class="property-label"><g:message code="radarSurfTrack.userId.label" default="User Id" /></span>
					
						<span class="property-value" aria-labelledby="userId-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="userId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${radarSurfTrackInstance?.vin}">
				<li class="fieldcontain">
					<span id="vin-label" class="property-label"><g:message code="radarSurfTrack.vin.label" default="Vin" /></span>
					
						<span class="property-value" aria-labelledby="vin-label"><g:fieldValue bean="${radarSurfTrackInstance}" field="vin"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${radarSurfTrackInstance?.id}" />
					<g:link class="edit" action="edit" id="${radarSurfTrackInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
