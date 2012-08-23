<%@ page import="gov.spawar.icode.RadarAirTrack" %>



<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_kluster', 'error')} required">
	<label for="sdsTrackID_kluster">
		<g:message code="radarAirTrack.sdsTrackID_kluster.label" default="Sds Track ID kluster" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_kluster" min="0" max="255" required="" value="${radarAirTrackInstance.sdsTrackID_kluster}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_port', 'error')} required">
	<label for="sdsTrackID_port">
		<g:message code="radarAirTrack.sdsTrackID_port.label" default="Sds Track ID port" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_port" min="0" max="15" required="" value="${radarAirTrackInstance.sdsTrackID_port}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_platform', 'error')} required">
	<label for="sdsTrackID_platform">
		<g:message code="radarAirTrack.sdsTrackID_platform.label" default="Sds Track ID platform" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_platform" min="0" max="15" required="" value="${radarAirTrackInstance.sdsTrackID_platform}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_category', 'error')} required">
	<label for="sdsTrackID_category">
		<g:message code="radarAirTrack.sdsTrackID_category.label" default="Sds Track ID category" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_category" min="0" max="255" required="" value="${radarAirTrackInstance.sdsTrackID_category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_amplification', 'error')} required">
	<label for="sdsTrackID_amplification">
		<g:message code="radarAirTrack.sdsTrackID_amplification.label" default="Sds Track ID amplification" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_amplification" min="0" max="255" required="" value="${radarAirTrackInstance.sdsTrackID_amplification}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_site', 'error')} required">
	<label for="sdsTrackID_site">
		<g:message code="radarAirTrack.sdsTrackID_site.label" default="Sds Track ID site" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_site" min="0" max="255" required="" value="${radarAirTrackInstance.sdsTrackID_site}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'ETAday', 'error')} required">
	<label for="ETAday">
		<g:message code="radarAirTrack.ETAday.label" default="ETA day" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ETAday" required="" value="${radarAirTrackInstance.ETAday}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'ETAhour', 'error')} required">
	<label for="ETAhour">
		<g:message code="radarAirTrack.ETAhour.label" default="ETA hour" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ETAhour" required="" value="${radarAirTrackInstance.ETAhour}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'ETAminute', 'error')} required">
	<label for="ETAminute">
		<g:message code="radarAirTrack.ETAminute.label" default="ETA minute" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ETAminute" required="" value="${radarAirTrackInstance.ETAminute}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'ETAmonth', 'error')} required">
	<label for="ETAmonth">
		<g:message code="radarAirTrack.ETAmonth.label" default="ETA month" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ETAmonth" required="" value="${radarAirTrackInstance.ETAmonth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'ROT', 'error')} required">
	<label for="ROT">
		<g:message code="radarAirTrack.ROT.label" default="ROT" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="ROT" step="any" required="" value="${radarAirTrackInstance.ROT}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'UID', 'error')} ">
	<label for="UID">
		<g:message code="radarAirTrack.UID.label" default="UID" />
		
	</label>
	<g:textField name="UID" value="${radarAirTrackInstance?.UID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'altitudeGNSS', 'error')} required">
	<label for="altitudeGNSS">
		<g:message code="radarAirTrack.altitudeGNSS.label" default="Altitude GNSS" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="altitudeGNSS" step="any" required="" value="${radarAirTrackInstance.altitudeGNSS}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bCenterPositionValid', 'error')} required">
	<label for="bCenterPositionValid">
		<g:message code="radarAirTrack.bCenterPositionValid.label" default="BC enter Position Valid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="bCenterPositionValid" required="" value="${radarAirTrackInstance.bCenterPositionValid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bClassA', 'error')} ">
	<label for="bClassA">
		<g:message code="radarAirTrack.bClassA.label" default="BC lass A" />
		
	</label>
	<g:checkBox name="bClassA" value="${radarAirTrackInstance?.bClassA}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bHDDirChange', 'error')} ">
	<label for="bHDDirChange">
		<g:message code="radarAirTrack.bHDDirChange.label" default="BHDD ir Change" />
		
	</label>
	<g:checkBox name="bHDDirChange" value="${radarAirTrackInstance?.bHDDirChange}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bHDHorizVel', 'error')} ">
	<label for="bHDHorizVel">
		<g:message code="radarAirTrack.bHDHorizVel.label" default="BHDH oriz Vel" />
		
	</label>
	<g:checkBox name="bHDHorizVel" value="${radarAirTrackInstance?.bHDHorizVel}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bHDVertVel', 'error')} ">
	<label for="bHDVertVel">
		<g:message code="radarAirTrack.bHDVertVel.label" default="BHDV ert Vel" />
		
	</label>
	<g:checkBox name="bHDVertVel" value="${radarAirTrackInstance?.bHDVertVel}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bHighDynamic', 'error')} ">
	<label for="bHighDynamic">
		<g:message code="radarAirTrack.bHighDynamic.label" default="BH igh Dynamic" />
		
	</label>
	<g:checkBox name="bHighDynamic" value="${radarAirTrackInstance?.bHighDynamic}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bIgnoreAlarms', 'error')} ">
	<label for="bIgnoreAlarms">
		<g:message code="radarAirTrack.bIgnoreAlarms.label" default="BI gnore Alarms" />
		
	</label>
	<g:checkBox name="bIgnoreAlarms" value="${radarAirTrackInstance?.bIgnoreAlarms}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bLessThan10MetersError', 'error')} required">
	<label for="bLessThan10MetersError">
		<g:message code="radarAirTrack.bLessThan10MetersError.label" default="BL ess Than10 Meters Error" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="bLessThan10MetersError" required="" value="${radarAirTrackInstance.bLessThan10MetersError}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bMobileTrack', 'error')} ">
	<label for="bMobileTrack">
		<g:message code="radarAirTrack.bMobileTrack.label" default="BM obile Track" />
		
	</label>
	<g:checkBox name="bMobileTrack" value="${radarAirTrackInstance?.bMobileTrack}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bMode2Valid', 'error')} ">
	<label for="bMode2Valid">
		<g:message code="radarAirTrack.bMode2Valid.label" default="BM ode2 Valid" />
		
	</label>
	<g:checkBox name="bMode2Valid" value="${radarAirTrackInstance?.bMode2Valid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bPlayerListIdValid', 'error')} ">
	<label for="bPlayerListIdValid">
		<g:message code="radarAirTrack.bPlayerListIdValid.label" default="BP layer List Id Valid" />
		
	</label>
	<g:checkBox name="bPlayerListIdValid" value="${radarAirTrackInstance?.bPlayerListIdValid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bPrecisionAltDiffSet', 'error')} ">
	<label for="bPrecisionAltDiffSet">
		<g:message code="radarAirTrack.bPrecisionAltDiffSet.label" default="BP recision Alt Diff Set" />
		
	</label>
	<g:checkBox name="bPrecisionAltDiffSet" value="${radarAirTrackInstance?.bPrecisionAltDiffSet}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bSensorMode2Valid', 'error')} ">
	<label for="bSensorMode2Valid">
		<g:message code="radarAirTrack.bSensorMode2Valid.label" default="BS ensor Mode2 Valid" />
		
	</label>
	<g:checkBox name="bSensorMode2Valid" value="${radarAirTrackInstance?.bSensorMode2Valid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bSensorMode3Valid', 'error')} ">
	<label for="bSensorMode3Valid">
		<g:message code="radarAirTrack.bSensorMode3Valid.label" default="BS ensor Mode3 Valid" />
		
	</label>
	<g:checkBox name="bSensorMode3Valid" value="${radarAirTrackInstance?.bSensorMode3Valid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bSensorSite', 'error')} ">
	<label for="bSensorSite">
		<g:message code="radarAirTrack.bSensorSite.label" default="BS ensor Site" />
		
	</label>
	<g:checkBox name="bSensorSite" value="${radarAirTrackInstance?.bSensorSite}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bSurfaceTrack', 'error')} ">
	<label for="bSurfaceTrack">
		<g:message code="radarAirTrack.bSurfaceTrack.label" default="BS urface Track" />
		
	</label>
	<g:checkBox name="bSurfaceTrack" value="${radarAirTrackInstance?.bSurfaceTrack}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'bVecValid', 'error')} ">
	<label for="bVecValid">
		<g:message code="radarAirTrack.bVecValid.label" default="BV ec Valid" />
		
	</label>
	<g:checkBox name="bVecValid" value="${radarAirTrackInstance?.bVecValid}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'callSign', 'error')} ">
	<label for="callSign">
		<g:message code="radarAirTrack.callSign.label" default="Call Sign" />
		
	</label>
	<g:textField name="callSign" value="${radarAirTrackInstance?.callSign}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'centerLat', 'error')} required">
	<label for="centerLat">
		<g:message code="radarAirTrack.centerLat.label" default="Center Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="centerLat" step="any" required="" value="${radarAirTrackInstance.centerLat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'centerLon', 'error')} required">
	<label for="centerLon">
		<g:message code="radarAirTrack.centerLon.label" default="Center Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="centerLon" step="any" required="" value="${radarAirTrackInstance.centerLon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'climb', 'error')} required">
	<label for="climb">
		<g:message code="radarAirTrack.climb.label" default="Climb" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="climb" step="any" required="" value="${radarAirTrackInstance.climb}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'condition', 'error')} required">
	<label for="condition">
		<g:message code="radarAirTrack.condition.label" default="Condition" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="condition" required="" value="${radarAirTrackInstance.condition}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner1Lat', 'error')} required">
	<label for="corner1Lat">
		<g:message code="radarAirTrack.corner1Lat.label" default="Corner1 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner1Lat" step="any" required="" value="${radarAirTrackInstance.corner1Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner1Lon', 'error')} required">
	<label for="corner1Lon">
		<g:message code="radarAirTrack.corner1Lon.label" default="Corner1 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner1Lon" step="any" required="" value="${radarAirTrackInstance.corner1Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner2Lat', 'error')} required">
	<label for="corner2Lat">
		<g:message code="radarAirTrack.corner2Lat.label" default="Corner2 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner2Lat" step="any" required="" value="${radarAirTrackInstance.corner2Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner2Lon', 'error')} required">
	<label for="corner2Lon">
		<g:message code="radarAirTrack.corner2Lon.label" default="Corner2 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner2Lon" step="any" required="" value="${radarAirTrackInstance.corner2Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner3Lat', 'error')} required">
	<label for="corner3Lat">
		<g:message code="radarAirTrack.corner3Lat.label" default="Corner3 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner3Lat" step="any" required="" value="${radarAirTrackInstance.corner3Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner3Lon', 'error')} required">
	<label for="corner3Lon">
		<g:message code="radarAirTrack.corner3Lon.label" default="Corner3 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner3Lon" step="any" required="" value="${radarAirTrackInstance.corner3Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner4Lat', 'error')} required">
	<label for="corner4Lat">
		<g:message code="radarAirTrack.corner4Lat.label" default="Corner4 Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner4Lat" step="any" required="" value="${radarAirTrackInstance.corner4Lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'corner4Lon', 'error')} required">
	<label for="corner4Lon">
		<g:message code="radarAirTrack.corner4Lon.label" default="Corner4 Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="corner4Lon" step="any" required="" value="${radarAirTrackInstance.corner4Lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'destination', 'error')} ">
	<label for="destination">
		<g:message code="radarAirTrack.destination.label" default="Destination" />
		
	</label>
	<g:textField name="destination" value="${radarAirTrackInstance?.destination}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'dimensionLength', 'error')} required">
	<label for="dimensionLength">
		<g:message code="radarAirTrack.dimensionLength.label" default="Dimension Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="dimensionLength" required="" value="${radarAirTrackInstance.dimensionLength}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'dimensionWidth', 'error')} required">
	<label for="dimensionWidth">
		<g:message code="radarAirTrack.dimensionWidth.label" default="Dimension Width" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="dimensionWidth" required="" value="${radarAirTrackInstance.dimensionWidth}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAADebugFlag', 'error')} required">
	<label for="extAADebugFlag">
		<g:message code="radarAirTrack.extAADebugFlag.label" default="Ext AAD ebug Flag" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAADebugFlag" required="" value="${radarAirTrackInstance.extAADebugFlag}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAAHorizBuf', 'error')} required">
	<label for="extAAHorizBuf">
		<g:message code="radarAirTrack.extAAHorizBuf.label" default="Ext AAH oriz Buf" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAAHorizBuf" step="any" required="" value="${radarAirTrackInstance.extAAHorizBuf}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAAHorzSep', 'error')} required">
	<label for="extAAHorzSep">
		<g:message code="radarAirTrack.extAAHorzSep.label" default="Ext AAH orz Sep" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAAHorzSep" step="any" required="" value="${radarAirTrackInstance.extAAHorzSep}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAALookAhead', 'error')} required">
	<label for="extAALookAhead">
		<g:message code="radarAirTrack.extAALookAhead.label" default="Ext AAL ook Ahead" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAALookAhead" step="any" required="" value="${radarAirTrackInstance.extAALookAhead}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAAVertExten', 'error')} required">
	<label for="extAAVertExten">
		<g:message code="radarAirTrack.extAAVertExten.label" default="Ext AAV ert Exten" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAAVertExten" required="" value="${radarAirTrackInstance.extAAVertExten}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAAVertSep', 'error')} required">
	<label for="extAAVertSep">
		<g:message code="radarAirTrack.extAAVertSep.label" default="Ext AAV ert Sep" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAAVertSep" required="" value="${radarAirTrackInstance.extAAVertSep}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'extAAVertVel', 'error')} required">
	<label for="extAAVertVel">
		<g:message code="radarAirTrack.extAAVertVel.label" default="Ext AAV ert Vel" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="extAAVertVel" required="" value="${radarAirTrackInstance.extAAVertVel}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'heading', 'error')} required">
	<label for="heading">
		<g:message code="radarAirTrack.heading.label" default="Heading" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="heading" step="any" required="" value="${radarAirTrackInstance.heading}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'locations', 'error')} ">
	<label for="locations">
		<g:message code="radarAirTrack.locations.label" default="Locations" />
		
	</label>
	<g:select name="locations" from="${gov.spawar.icode.Location.list()}" multiple="multiple" optionKey="id" size="5" value="${radarAirTrackInstance?.locations*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'maxDraught', 'error')} required">
	<label for="maxDraught">
		<g:message code="radarAirTrack.maxDraught.label" default="Max Draught" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="maxDraught" required="" value="${radarAirTrackInstance.maxDraught}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'md_3a_validity', 'error')} ">
	<label for="md_3a_validity">
		<g:message code="radarAirTrack.md_3a_validity.label" default="Md3avalidity" />
		
	</label>
	<g:checkBox name="md_3a_validity" value="${radarAirTrackInstance?.md_3a_validity}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'md_c_validity', 'error')} ">
	<label for="md_c_validity">
		<g:message code="radarAirTrack.md_c_validity.label" default="Mdcvalidity" />
		
	</label>
	<g:checkBox name="md_c_validity" value="${radarAirTrackInstance?.md_c_validity}" />
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'messageID', 'error')} required">
	<label for="messageID">
		<g:message code="radarAirTrack.messageID.label" default="Message ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="messageID" required="" value="${radarAirTrackInstance.messageID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'messageTime', 'error')} required">
	<label for="messageTime">
		<g:message code="radarAirTrack.messageTime.label" default="Message Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="messageTime" step="any" required="" value="${radarAirTrackInstance.messageTime}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'mode2', 'error')} required">
	<label for="mode2">
		<g:message code="radarAirTrack.mode2.label" default="Mode2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="mode2" required="" value="${radarAirTrackInstance.mode2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'mode3A', 'error')} required">
	<label for="mode3A">
		<g:message code="radarAirTrack.mode3A.label" default="Mode3 A" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="mode3A" required="" value="${radarAirTrackInstance.mode3A}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="radarAirTrack.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${radarAirTrackInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'playerListId', 'error')} required">
	<label for="playerListId">
		<g:message code="radarAirTrack.playerListId.label" default="Player List Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="playerListId" required="" value="${radarAirTrackInstance.playerListId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'portalName', 'error')} ">
	<label for="portalName">
		<g:message code="radarAirTrack.portalName.label" default="Portal Name" />
		
	</label>
	<g:textField name="portalName" value="${radarAirTrackInstance?.portalName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'precisionAltDiff', 'error')} required">
	<label for="precisionAltDiff">
		<g:message code="radarAirTrack.precisionAltDiff.label" default="Precision Alt Diff" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="precisionAltDiff" step="any" required="" value="${radarAirTrackInstance.precisionAltDiff}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'quality', 'error')} required">
	<label for="quality">
		<g:message code="radarAirTrack.quality.label" default="Quality" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="quality" step="any" required="" value="${radarAirTrackInstance.quality}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'radar_num', 'error')} required">
	<label for="radar_num">
		<g:message code="radarAirTrack.radar_num.label" default="Radarnum" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="radar_num" required="" value="${radarAirTrackInstance.radar_num}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'remote_name', 'error')} ">
	<label for="remote_name">
		<g:message code="radarAirTrack.remote_name.label" default="Remotename" />
		
	</label>
	<g:textField name="remote_name" value="${radarAirTrackInstance?.remote_name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'reportLat', 'error')} required">
	<label for="reportLat">
		<g:message code="radarAirTrack.reportLat.label" default="Report Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="reportLat" step="any" required="" value="${radarAirTrackInstance.reportLat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'reportLon', 'error')} required">
	<label for="reportLon">
		<g:message code="radarAirTrack.reportLon.label" default="Report Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="reportLon" step="any" required="" value="${radarAirTrackInstance.reportLon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsIndex', 'error')} required">
	<label for="sdsIndex">
		<g:message code="radarAirTrack.sdsIndex.label" default="Sds Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsIndex" required="" value="${radarAirTrackInstance.sdsIndex}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_radar', 'error')} required">
	<label for="sdsTrackID_radar">
		<g:message code="radarAirTrack.sdsTrackID_radar.label" default="Sds Track ID radar" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_radar" required="" value="${radarAirTrackInstance.sdsTrackID_radar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sdsTrackID_trackID', 'error')} required">
	<label for="sdsTrackID_trackID">
		<g:message code="radarAirTrack.sdsTrackID_trackID.label" default="Sds Track ID track ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sdsTrackID_trackID" required="" value="${radarAirTrackInstance.sdsTrackID_trackID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sensorCondition', 'error')} required">
	<label for="sensorCondition">
		<g:message code="radarAirTrack.sensorCondition.label" default="Sensor Condition" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sensorCondition" required="" value="${radarAirTrackInstance.sensorCondition}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sensorMode2', 'error')} required">
	<label for="sensorMode2">
		<g:message code="radarAirTrack.sensorMode2.label" default="Sensor Mode2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sensorMode2" required="" value="${radarAirTrackInstance.sensorMode2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'sensorMode3', 'error')} required">
	<label for="sensorMode3">
		<g:message code="radarAirTrack.sensorMode3.label" default="Sensor Mode3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sensorMode3" required="" value="${radarAirTrackInstance.sensorMode3}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'speed', 'error')} required">
	<label for="speed">
		<g:message code="radarAirTrack.speed.label" default="Speed" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="speed" step="any" required="" value="${radarAirTrackInstance.speed}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_amplification', 'error')} required">
	<label for="systemTrackID_amplification">
		<g:message code="radarAirTrack.systemTrackID_amplification.label" default="System Track ID amplification" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_amplification" required="" value="${radarAirTrackInstance.systemTrackID_amplification}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_category', 'error')} required">
	<label for="systemTrackID_category">
		<g:message code="radarAirTrack.systemTrackID_category.label" default="System Track ID category" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_category" required="" value="${radarAirTrackInstance.systemTrackID_category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_kluster', 'error')} required">
	<label for="systemTrackID_kluster">
		<g:message code="radarAirTrack.systemTrackID_kluster.label" default="System Track ID kluster" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_kluster" required="" value="${radarAirTrackInstance.systemTrackID_kluster}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_platform', 'error')} required">
	<label for="systemTrackID_platform">
		<g:message code="radarAirTrack.systemTrackID_platform.label" default="System Track ID platform" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_platform" required="" value="${radarAirTrackInstance.systemTrackID_platform}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_port', 'error')} required">
	<label for="systemTrackID_port">
		<g:message code="radarAirTrack.systemTrackID_port.label" default="System Track ID port" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_port" required="" value="${radarAirTrackInstance.systemTrackID_port}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_radar', 'error')} required">
	<label for="systemTrackID_radar">
		<g:message code="radarAirTrack.systemTrackID_radar.label" default="System Track ID radar" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_radar" required="" value="${radarAirTrackInstance.systemTrackID_radar}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_site', 'error')} required">
	<label for="systemTrackID_site">
		<g:message code="radarAirTrack.systemTrackID_site.label" default="System Track ID site" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_site" required="" value="${radarAirTrackInstance.systemTrackID_site}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'systemTrackID_trackID', 'error')} required">
	<label for="systemTrackID_trackID">
		<g:message code="radarAirTrack.systemTrackID_trackID.label" default="System Track ID track ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="systemTrackID_trackID" required="" value="${radarAirTrackInstance.systemTrackID_trackID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="radarAirTrack.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="time" step="any" required="" value="${radarAirTrackInstance.time}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'trackStatus', 'error')} required">
	<label for="trackStatus">
		<g:message code="radarAirTrack.trackStatus.label" default="Track Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="trackStatus" from="${gov.spawar.icode.RadarAirTrack$TrackStatus?.values()}" keys="${gov.spawar.icode.RadarAirTrack$TrackStatus.values()*.name()}" required="" value="${radarAirTrackInstance?.trackStatus?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'trueHeading', 'error')} required">
	<label for="trueHeading">
		<g:message code="radarAirTrack.trueHeading.label" default="True Heading" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="trueHeading" step="any" required="" value="${radarAirTrackInstance.trueHeading}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'typeOfPositionDevice', 'error')} required">
	<label for="typeOfPositionDevice">
		<g:message code="radarAirTrack.typeOfPositionDevice.label" default="Type Of Position Device" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="typeOfPositionDevice" required="" value="${radarAirTrackInstance.typeOfPositionDevice}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'typeOfShip1', 'error')} required">
	<label for="typeOfShip1">
		<g:message code="radarAirTrack.typeOfShip1.label" default="Type Of Ship1" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="typeOfShip1" required="" value="${radarAirTrackInstance.typeOfShip1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'typeOfShip2', 'error')} required">
	<label for="typeOfShip2">
		<g:message code="radarAirTrack.typeOfShip2.label" default="Type Of Ship2" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="typeOfShip2" required="" value="${radarAirTrackInstance.typeOfShip2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: radarAirTrackInstance, field: 'userId', 'error')} required">
	<label for="userId">
		<g:message code="radarAirTrack.userId.label" default="User Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="userId" required="" value="${radarAirTrackInstance.userId}"/>
</div>

