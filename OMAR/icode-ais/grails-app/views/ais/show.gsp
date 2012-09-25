
<%@ page import="gov.spawar.icode.Ais" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ais.label', default: 'Ais')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ais" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ais" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ais">
			
				<g:if test="${aisInstance?.IMO}">
				<li class="fieldcontain">
					<span id="IMO-label" class="property-label"><g:message code="ais.IMO.label" default="IMO" /></span>
					
						<span class="property-value" aria-labelledby="IMO-label"><g:fieldValue bean="${aisInstance}" field="IMO"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.antennaLocationBow}">
				<li class="fieldcontain">
					<span id="antennaLocationBow-label" class="property-label"><g:message code="ais.antennaLocationBow.label" default="Antenna Location Bow" /></span>
					
						<span class="property-value" aria-labelledby="antennaLocationBow-label"><g:fieldValue bean="${aisInstance}" field="antennaLocationBow"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.antennaLocationPort}">
				<li class="fieldcontain">
					<span id="antennaLocationPort-label" class="property-label"><g:message code="ais.antennaLocationPort.label" default="Antenna Location Port" /></span>
					
						<span class="property-value" aria-labelledby="antennaLocationPort-label"><g:fieldValue bean="${aisInstance}" field="antennaLocationPort"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.antennaLocationStarboard}">
				<li class="fieldcontain">
					<span id="antennaLocationStarboard-label" class="property-label"><g:message code="ais.antennaLocationStarboard.label" default="Antenna Location Starboard" /></span>
					
						<span class="property-value" aria-labelledby="antennaLocationStarboard-label"><g:fieldValue bean="${aisInstance}" field="antennaLocationStarboard"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.antennaLocationStern}">
				<li class="fieldcontain">
					<span id="antennaLocationStern-label" class="property-label"><g:message code="ais.antennaLocationStern.label" default="Antenna Location Stern" /></span>
					
						<span class="property-value" aria-labelledby="antennaLocationStern-label"><g:fieldValue bean="${aisInstance}" field="antennaLocationStern"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.callsign}">
				<li class="fieldcontain">
					<span id="callsign-label" class="property-label"><g:message code="ais.callsign.label" default="Callsign" /></span>
					
						<span class="property-value" aria-labelledby="callsign-label"><g:fieldValue bean="${aisInstance}" field="callsign"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.changes}">
				<li class="fieldcontain">
					<span id="changes-label" class="property-label"><g:message code="ais.changes.label" default="Changes" /></span>
					
						<g:each in="${aisInstance.changes}" var="c">
						<span class="property-value" aria-labelledby="changes-label"><g:link controller="change" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.courseOverGround}">
				<li class="fieldcontain">
					<span id="courseOverGround-label" class="property-label"><g:message code="ais.courseOverGround.label" default="Course Over Ground" /></span>
					
						<span class="property-value" aria-labelledby="courseOverGround-label"><g:fieldValue bean="${aisInstance}" field="courseOverGround"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="ais.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${aisInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.destination}">
				<li class="fieldcontain">
					<span id="destination-label" class="property-label"><g:message code="ais.destination.label" default="Destination" /></span>
					
						<span class="property-value" aria-labelledby="destination-label"><g:link controller="country" action="show" id="${aisInstance?.destination?.id}">${aisInstance?.destination?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.draught}">
				<li class="fieldcontain">
					<span id="draught-label" class="property-label"><g:message code="ais.draught.label" default="Draught" /></span>
					
						<span class="property-value" aria-labelledby="draught-label"><g:fieldValue bean="${aisInstance}" field="draught"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.electronicPositionFixingDevice}">
				<li class="fieldcontain">
					<span id="electronicPositionFixingDevice-label" class="property-label"><g:message code="ais.electronicPositionFixingDevice.label" default="Electronic Position Fixing Device" /></span>
					
						<span class="property-value" aria-labelledby="electronicPositionFixingDevice-label"><g:link controller="epfd" action="show" id="${aisInstance?.electronicPositionFixingDevice?.id}">${aisInstance?.electronicPositionFixingDevice?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.eta}">
				<li class="fieldcontain">
					<span id="eta-label" class="property-label"><g:message code="ais.eta.label" default="Eta" /></span>
					
						<span class="property-value" aria-labelledby="eta-label"><g:formatDate date="${aisInstance?.eta}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="ais.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${aisInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.length}">
				<li class="fieldcontain">
					<span id="length-label" class="property-label"><g:message code="ais.length.label" default="Length" /></span>
					
						<span class="property-value" aria-labelledby="length-label"><g:fieldValue bean="${aisInstance}" field="length"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.locations}">
				<li class="fieldcontain">
					<span id="locations-label" class="property-label"><g:message code="ais.locations.label" default="Locations" /></span>
					
						<g:each in="${aisInstance.locations}" var="l">
						<span class="property-value" aria-labelledby="locations-label"><g:link controller="location" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.mid}">
				<li class="fieldcontain">
					<span id="mid-label" class="property-label"><g:message code="ais.mid.label" default="Mid" /></span>
					
						<span class="property-value" aria-labelledby="mid-label"><g:link controller="maritimeIdDigit" action="show" id="${aisInstance?.mid?.id}">${aisInstance?.mid?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.mmsi}">
				<li class="fieldcontain">
					<span id="mmsi-label" class="property-label"><g:message code="ais.mmsi.label" default="Mmsi" /></span>
					
						<span class="property-value" aria-labelledby="mmsi-label"><g:fieldValue bean="${aisInstance}" field="mmsi"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.navStatus}">
				<li class="fieldcontain">
					<span id="navStatus-label" class="property-label"><g:message code="ais.navStatus.label" default="Nav Status" /></span>
					
						<span class="property-value" aria-labelledby="navStatus-label"><g:link controller="navigationStatus" action="show" id="${aisInstance?.navStatus?.id}">${aisInstance?.navStatus?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.posAccuracy}">
				<li class="fieldcontain">
					<span id="posAccuracy-label" class="property-label"><g:message code="ais.posAccuracy.label" default="Pos Accuracy" /></span>
					
						<span class="property-value" aria-labelledby="posAccuracy-label"><g:fieldValue bean="${aisInstance}" field="posAccuracy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.positionFixType}">
				<li class="fieldcontain">
					<span id="positionFixType-label" class="property-label"><g:message code="ais.positionFixType.label" default="Position Fix Type" /></span>
					
						<span class="property-value" aria-labelledby="positionFixType-label"><g:fieldValue bean="${aisInstance}" field="positionFixType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.rateOfTurn}">
				<li class="fieldcontain">
					<span id="rateOfTurn-label" class="property-label"><g:message code="ais.rateOfTurn.label" default="Rate Of Turn" /></span>
					
						<span class="property-value" aria-labelledby="rateOfTurn-label"><g:fieldValue bean="${aisInstance}" field="rateOfTurn"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.speedOverGround}">
				<li class="fieldcontain">
					<span id="speedOverGround-label" class="property-label"><g:message code="ais.speedOverGround.label" default="Speed Over Ground" /></span>
					
						<span class="property-value" aria-labelledby="speedOverGround-label"><g:fieldValue bean="${aisInstance}" field="speedOverGround"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.trueHeading}">
				<li class="fieldcontain">
					<span id="trueHeading-label" class="property-label"><g:message code="ais.trueHeading.label" default="True Heading" /></span>
					
						<span class="property-value" aria-labelledby="trueHeading-label"><g:fieldValue bean="${aisInstance}" field="trueHeading"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.uId}">
				<li class="fieldcontain">
					<span id="uId-label" class="property-label"><g:message code="ais.uId.label" default="UI d" /></span>
					
						<span class="property-value" aria-labelledby="uId-label"><g:fieldValue bean="${aisInstance}" field="uId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.vesselName}">
				<li class="fieldcontain">
					<span id="vesselName-label" class="property-label"><g:message code="ais.vesselName.label" default="Vessel Name" /></span>
					
						<span class="property-value" aria-labelledby="vesselName-label"><g:fieldValue bean="${aisInstance}" field="vesselName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.vesselType}">
				<li class="fieldcontain">
					<span id="vesselType-label" class="property-label"><g:message code="ais.vesselType.label" default="Vessel Type" /></span>
					
						<span class="property-value" aria-labelledby="vesselType-label"><g:link controller="vesselType" action="show" id="${aisInstance?.vesselType?.id}">${aisInstance?.vesselType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${aisInstance?.width}">
				<li class="fieldcontain">
					<span id="width-label" class="property-label"><g:message code="ais.width.label" default="Width" /></span>
					
						<span class="property-value" aria-labelledby="width-label"><g:fieldValue bean="${aisInstance}" field="width"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${aisInstance?.id}" />
					<g:link class="edit" action="edit" id="${aisInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
