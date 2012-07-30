<%@ page import="gov.spawar.icode.RadarSurfTrack" %>



<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_kluster', 'error')} required">
	<label for="sdsTrackID_kluster">
		<g:message code="radarSurfTrack.sdsTrackID_kluster.label" default="Sds Track ID kluster" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_kluster" min="0" max="255" required="" value="${radarSurfTrackInstance.sdsTrackID_kluster}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_port', 'error')} required">
	<label for="sdsTrackID_port">
		<g:message code="radarSurfTrack.sdsTrackID_port.label" default="Sds Track ID port" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_port" min="0" max="15" required="" value="${radarSurfTrackInstance.sdsTrackID_port}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_platform', 'error')} required">
	<label for="sdsTrackID_platform">
		<g:message code="radarSurfTrack.sdsTrackID_platform.label" default="Sds Track ID platform" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_platform" min="0" max="15" required="" value="${radarSurfTrackInstance.sdsTrackID_platform}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_category', 'error')} required">
	<label for="sdsTrackID_category">
		<g:message code="radarSurfTrack.sdsTrackID_category.label" default="Sds Track ID category" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_category" min="0" max="255" required="" value="${radarSurfTrackInstance.sdsTrackID_category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_amplification', 'error')} required">
	<label for="sdsTrackID_amplification">
		<g:message code="radarSurfTrack.sdsTrackID_amplification.label" default="Sds Track ID amplification" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_amplification" min="0" max="255" required="" value="${radarSurfTrackInstance.sdsTrackID_amplification}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_site', 'error')} required">
	<label for="sdsTrackID_site">
		<g:message code="radarSurfTrack.sdsTrackID_site.label" default="Sds Track ID site" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_site" min="0" max="255" required="" value="${radarSurfTrackInstance.sdsTrackID_site}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'acquired', 'error')} required">
	<label for="acquired">
		<g:message code="radarSurfTrack.acquired.label" default="Acquired" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="acquired" min="0" max="2" required="" value="${radarSurfTrackInstance.acquired}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bCenterPositionValid', 'error')} required">
	<label for="bCenterPositionValid">
		<g:message code="radarSurfTrack.bCenterPositionValid.label" default="BC enter Position Valid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="bCenterPositionValid" min="0" max="1" required="" value="${radarSurfTrackInstance.bCenterPositionValid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'typeOfShip1', 'error')} required">
	<label for="typeOfShip1">
		<g:message code="radarSurfTrack.typeOfShip1.label" default="Type Of Ship1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="typeOfShip1" min="0" max="19" required="" value="${radarSurfTrackInstance.typeOfShip1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'typeOfShip2', 'error')} required">
	<label for="typeOfShip2">
		<g:message code="radarSurfTrack.typeOfShip2.label" default="Type Of Ship2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="typeOfShip2" min="-1" max="19" required="" value="${radarSurfTrackInstance.typeOfShip2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'dimensionLength', 'error')} required">
	<label for="dimensionLength">
		<g:message code="radarSurfTrack.dimensionLength.label" default="Dimension Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="dimensionLength" min="0" max="1022" required="" value="${radarSurfTrackInstance.dimensionLength}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'dimensionWidth', 'error')} required">
	<label for="dimensionWidth">
		<g:message code="radarSurfTrack.dimensionWidth.label" default="Dimension Width" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="dimensionWidth" min="0" max="126" required="" value="${radarSurfTrackInstance.dimensionWidth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'etaMonth', 'error')} required">
	<label for="etaMonth">
		<g:message code="radarSurfTrack.etaMonth.label" default="Eta Month" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="etaMonth" min="-1" max="12" required="" value="${radarSurfTrackInstance.etaMonth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'etaDay', 'error')} required">
	<label for="etaDay">
		<g:message code="radarSurfTrack.etaDay.label" default="Eta Day" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="etaDay" min="-1" max="31" required="" value="${radarSurfTrackInstance.etaDay}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'etaHour', 'error')} required">
	<label for="etaHour">
		<g:message code="radarSurfTrack.etaHour.label" default="Eta Hour" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="etaHour" min="-1" max="23" required="" value="${radarSurfTrackInstance.etaHour}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'etaMinute', 'error')} required">
	<label for="etaMinute">
		<g:message code="radarSurfTrack.etaMinute.label" default="Eta Minute" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="etaMinute" min="0" max="59" required="" value="${radarSurfTrackInstance.etaMinute}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'maxDraught', 'error')} required">
	<label for="maxDraught">
		<g:message code="radarSurfTrack.maxDraught.label" default="Max Draught" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="maxDraught" min="0" max="255" required="" value="${radarSurfTrackInstance.maxDraught}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'altitudeGNSS', 'error')} required">
	<label for="altitudeGNSS">
		<g:message code="radarSurfTrack.altitudeGNSS.label" default="Altitude GNSS" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="altitudeGNSS" step="any" min="0.0" max="13435.0" required="" value="${radarSurfTrackInstance.altitudeGNSS}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bClassA', 'error')} ">
	<label for="bClassA">
		<g:message code="radarSurfTrack.bClassA.label" default="BC lass A" />
		
	</label>
	<g:checkBox name="bClassA" value="${radarSurfTrackInstance?.bClassA}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bIgnoreAlarms', 'error')} ">
	<label for="bIgnoreAlarms">
		<g:message code="radarSurfTrack.bIgnoreAlarms.label" default="BI gnore Alarms" />
		
	</label>
	<g:checkBox name="bIgnoreAlarms" value="${radarSurfTrackInstance?.bIgnoreAlarms}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bLessThan10MetersError', 'error')} required">
	<label for="bLessThan10MetersError">
		<g:message code="radarSurfTrack.bLessThan10MetersError.label" default="BL ess Than10 Meters Error" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="bLessThan10MetersError" required="" value="${radarSurfTrackInstance.bLessThan10MetersError}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bMobileTrack', 'error')} ">
	<label for="bMobileTrack">
		<g:message code="radarSurfTrack.bMobileTrack.label" default="BM obile Track" />
		
	</label>
	<g:checkBox name="bMobileTrack" value="${radarSurfTrackInstance?.bMobileTrack}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bPlayerListIdValid', 'error')} ">
	<label for="bPlayerListIdValid">
		<g:message code="radarSurfTrack.bPlayerListIdValid.label" default="BP layer List Id Valid" />
		
	</label>
	<g:checkBox name="bPlayerListIdValid" value="${radarSurfTrackInstance?.bPlayerListIdValid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bSensorSite', 'error')} ">
	<label for="bSensorSite">
		<g:message code="radarSurfTrack.bSensorSite.label" default="BS ensor Site" />
		
	</label>
	<g:checkBox name="bSensorSite" value="${radarSurfTrackInstance?.bSensorSite}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bSurfaceTrack', 'error')} ">
	<label for="bSurfaceTrack">
		<g:message code="radarSurfTrack.bSurfaceTrack.label" default="BS urface Track" />
		
	</label>
	<g:checkBox name="bSurfaceTrack" value="${radarSurfTrackInstance?.bSurfaceTrack}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'bVecValid', 'error')} ">
	<label for="bVecValid">
		<g:message code="radarSurfTrack.bVecValid.label" default="BV ec Valid" />
		
	</label>
	<g:checkBox name="bVecValid" value="${radarSurfTrackInstance?.bVecValid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'callSign', 'error')} ">
	<label for="callSign">
		<g:message code="radarSurfTrack.callSign.label" default="Call Sign" />
		
	</label>
	<g:textField name="callSign" value="${radarSurfTrackInstance?.callSign}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'centerLat', 'error')} required">
	<label for="centerLat">
		<g:message code="radarSurfTrack.centerLat.label" default="Center Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="centerLat" step="any" required="" value="${radarSurfTrackInstance.centerLat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'centerLon', 'error')} required">
	<label for="centerLon">
		<g:message code="radarSurfTrack.centerLon.label" default="Center Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="centerLon" step="any" required="" value="${radarSurfTrackInstance.centerLon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'climb', 'error')} required">
	<label for="climb">
		<g:message code="radarSurfTrack.climb.label" default="Climb" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="climb" step="any" required="" value="${radarSurfTrackInstance.climb}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner1Lat', 'error')} required">
	<label for="corner1Lat">
		<g:message code="radarSurfTrack.corner1Lat.label" default="Corner1 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner1Lat" step="any" required="" value="${radarSurfTrackInstance.corner1Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner1Lon', 'error')} required">
	<label for="corner1Lon">
		<g:message code="radarSurfTrack.corner1Lon.label" default="Corner1 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner1Lon" step="any" required="" value="${radarSurfTrackInstance.corner1Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner2Lat', 'error')} required">
	<label for="corner2Lat">
		<g:message code="radarSurfTrack.corner2Lat.label" default="Corner2 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner2Lat" step="any" required="" value="${radarSurfTrackInstance.corner2Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner2Lon', 'error')} required">
	<label for="corner2Lon">
		<g:message code="radarSurfTrack.corner2Lon.label" default="Corner2 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner2Lon" step="any" required="" value="${radarSurfTrackInstance.corner2Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner3Lat', 'error')} required">
	<label for="corner3Lat">
		<g:message code="radarSurfTrack.corner3Lat.label" default="Corner3 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner3Lat" step="any" required="" value="${radarSurfTrackInstance.corner3Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner3Lon', 'error')} required">
	<label for="corner3Lon">
		<g:message code="radarSurfTrack.corner3Lon.label" default="Corner3 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner3Lon" step="any" required="" value="${radarSurfTrackInstance.corner3Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner4Lat', 'error')} required">
	<label for="corner4Lat">
		<g:message code="radarSurfTrack.corner4Lat.label" default="Corner4 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner4Lat" step="any" required="" value="${radarSurfTrackInstance.corner4Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'corner4Lon', 'error')} required">
	<label for="corner4Lon">
		<g:message code="radarSurfTrack.corner4Lon.label" default="Corner4 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner4Lon" step="any" required="" value="${radarSurfTrackInstance.corner4Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'destination', 'error')} ">
	<label for="destination">
		<g:message code="radarSurfTrack.destination.label" default="Destination" />
		
	</label>
	<g:textField name="destination" value="${radarSurfTrackInstance?.destination}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'heading', 'error')} required">
	<label for="heading">
		<g:message code="radarSurfTrack.heading.label" default="Heading" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="heading" step="any" required="" value="${radarSurfTrackInstance.heading}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'locations', 'error')} ">
	<label for="locations">
		<g:message code="radarSurfTrack.locations.label" default="Locations" />
		
	</label>
	<g:select name="locations" from="${gov.spawar.icode.Location.list()}" multiple="multiple" optionKey="id" size="5" value="${radarSurfTrackInstance?.locations*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'messageID', 'error')} required">
	<label for="messageID">
		<g:message code="radarSurfTrack.messageID.label" default="Message ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="messageID" required="" value="${radarSurfTrackInstance.messageID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'messageTime', 'error')} required">
	<label for="messageTime">
		<g:message code="radarSurfTrack.messageTime.label" default="Message Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="messageTime" step="any" required="" value="${radarSurfTrackInstance.messageTime}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="radarSurfTrack.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${radarSurfTrackInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'playerListId', 'error')} required">
	<label for="playerListId">
		<g:message code="radarSurfTrack.playerListId.label" default="Player List Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="playerListId" required="" value="${radarSurfTrackInstance.playerListId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'plotSize', 'error')} required">
	<label for="plotSize">
		<g:message code="radarSurfTrack.plotSize.label" default="Plot Size" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="plotSize" step="any" required="" value="${radarSurfTrackInstance.plotSize}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'portalName', 'error')} ">
	<label for="portalName">
		<g:message code="radarSurfTrack.portalName.label" default="Portal Name" />
		
	</label>
	<g:textField name="portalName" value="${radarSurfTrackInstance?.portalName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'quality', 'error')} required">
	<label for="quality">
		<g:message code="radarSurfTrack.quality.label" default="Quality" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="quality" step="any" required="" value="${radarSurfTrackInstance.quality}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'range', 'error')} required">
	<label for="range">
		<g:message code="radarSurfTrack.range.label" default="Range" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="range" step="any" required="" value="${radarSurfTrackInstance.range}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'remote_name', 'error')} ">
	<label for="remote_name">
		<g:message code="radarSurfTrack.remote_name.label" default="Remotename" />
		
	</label>
	<g:textField name="remote_name" value="${radarSurfTrackInstance?.remote_name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'reportLat', 'error')} required">
	<label for="reportLat">
		<g:message code="radarSurfTrack.reportLat.label" default="Report Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="reportLat" step="any" required="" value="${radarSurfTrackInstance.reportLat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'reportLon', 'error')} required">
	<label for="reportLon">
		<g:message code="radarSurfTrack.reportLon.label" default="Report Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="reportLon" step="any" required="" value="${radarSurfTrackInstance.reportLon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'reportTime', 'error')} required">
	<label for="reportTime">
		<g:message code="radarSurfTrack.reportTime.label" default="Report Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="reportTime" step="any" required="" value="${radarSurfTrackInstance.reportTime}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'rot', 'error')} required">
	<label for="rot">
		<g:message code="radarSurfTrack.rot.label" default="Rot" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="rot" step="any" required="" value="${radarSurfTrackInstance.rot}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsIndex', 'error')} required">
	<label for="sdsIndex">
		<g:message code="radarSurfTrack.sdsIndex.label" default="Sds Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsIndex" required="" value="${radarSurfTrackInstance.sdsIndex}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_radar', 'error')} required">
	<label for="sdsTrackID_radar">
		<g:message code="radarSurfTrack.sdsTrackID_radar.label" default="Sds Track ID radar" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_radar" required="" value="${radarSurfTrackInstance.sdsTrackID_radar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'sdsTrackID_trackID', 'error')} required">
	<label for="sdsTrackID_trackID">
		<g:message code="radarSurfTrack.sdsTrackID_trackID.label" default="Sds Track ID track ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_trackID" required="" value="${radarSurfTrackInstance.sdsTrackID_trackID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'speed', 'error')} required">
	<label for="speed">
		<g:message code="radarSurfTrack.speed.label" default="Speed" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="speed" step="any" required="" value="${radarSurfTrackInstance.speed}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_amplification', 'error')} required">
	<label for="systemTrackID_amplification">
		<g:message code="radarSurfTrack.systemTrackID_amplification.label" default="System Track ID amplification" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_amplification" required="" value="${radarSurfTrackInstance.systemTrackID_amplification}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_category', 'error')} required">
	<label for="systemTrackID_category">
		<g:message code="radarSurfTrack.systemTrackID_category.label" default="System Track ID category" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_category" required="" value="${radarSurfTrackInstance.systemTrackID_category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_kluster', 'error')} required">
	<label for="systemTrackID_kluster">
		<g:message code="radarSurfTrack.systemTrackID_kluster.label" default="System Track ID kluster" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_kluster" required="" value="${radarSurfTrackInstance.systemTrackID_kluster}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_platform', 'error')} required">
	<label for="systemTrackID_platform">
		<g:message code="radarSurfTrack.systemTrackID_platform.label" default="System Track ID platform" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_platform" required="" value="${radarSurfTrackInstance.systemTrackID_platform}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_port', 'error')} required">
	<label for="systemTrackID_port">
		<g:message code="radarSurfTrack.systemTrackID_port.label" default="System Track ID port" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_port" required="" value="${radarSurfTrackInstance.systemTrackID_port}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_radar', 'error')} required">
	<label for="systemTrackID_radar">
		<g:message code="radarSurfTrack.systemTrackID_radar.label" default="System Track ID radar" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_radar" required="" value="${radarSurfTrackInstance.systemTrackID_radar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_site', 'error')} required">
	<label for="systemTrackID_site">
		<g:message code="radarSurfTrack.systemTrackID_site.label" default="System Track ID site" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_site" required="" value="${radarSurfTrackInstance.systemTrackID_site}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'systemTrackID_trackID', 'error')} required">
	<label for="systemTrackID_trackID">
		<g:message code="radarSurfTrack.systemTrackID_trackID.label" default="System Track ID track ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_trackID" required="" value="${radarSurfTrackInstance.systemTrackID_trackID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="radarSurfTrack.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="time" step="any" required="" value="${radarSurfTrackInstance.time}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'trueHeading', 'error')} required">
	<label for="trueHeading">
		<g:message code="radarSurfTrack.trueHeading.label" default="True Heading" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="trueHeading" step="any" required="" value="${radarSurfTrackInstance.trueHeading}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'typeOfPositionDevice', 'error')} required">
	<label for="typeOfPositionDevice">
		<g:message code="radarSurfTrack.typeOfPositionDevice.label" default="Type Of Position Device" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="typeOfPositionDevice" required="" value="${radarSurfTrackInstance.typeOfPositionDevice}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'uID', 'error')} ">
	<label for="uID">
		<g:message code="radarSurfTrack.uID.label" default="UID" />
		
	</label>
	<g:textField name="uID" value="${radarSurfTrackInstance?.uID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'userId', 'error')} required">
	<label for="userId">
		<g:message code="radarSurfTrack.userId.label" default="User Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="userId" required="" value="${radarSurfTrackInstance.userId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarSurfTrackInstance, field: 'vin', 'error')} ">
	<label for="vin">
		<g:message code="radarSurfTrack.vin.label" default="Vin" />
		
	</label>
	<g:textField name="vin" value="${radarSurfTrackInstance?.vin}"/>
</div>

