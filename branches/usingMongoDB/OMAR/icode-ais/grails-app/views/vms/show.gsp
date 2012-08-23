
<%@ page import="gov.spawar.icode.Vms" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'vms.label', default: 'Vms')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-vms" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-vms" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list vms">
			
				<g:if test="${vmsInstance?.vesselName}">
				<li class="fieldcontain">
					<span id="vesselName-label" class="property-label"><g:message code="vms.vesselName.label" default="Vessel Name" /></span>
					
						<span class="property-value" aria-labelledby="vesselName-label"><g:fieldValue bean="${vmsInstance}" field="vesselName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.callSign}">
				<li class="fieldcontain">
					<span id="callSign-label" class="property-label"><g:message code="vms.callSign.label" default="Call Sign" /></span>
					
						<span class="property-value" aria-labelledby="callSign-label"><g:fieldValue bean="${vmsInstance}" field="callSign"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.country}">
				<li class="fieldcontain">
					<span id="country-label" class="property-label"><g:message code="vms.country.label" default="Country" /></span>
					
						<span class="property-value" aria-labelledby="country-label"><g:fieldValue bean="${vmsInstance}" field="country"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.messageType}">
				<li class="fieldcontain">
					<span id="messageType-label" class="property-label"><g:message code="vms.messageType.label" default="Message Type" /></span>
					
						<span class="property-value" aria-labelledby="messageType-label"><g:fieldValue bean="${vmsInstance}" field="messageType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="vms.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${vmsInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.course}">
				<li class="fieldcontain">
					<span id="course-label" class="property-label"><g:message code="vms.course.label" default="Course" /></span>
					
						<span class="property-value" aria-labelledby="course-label"><g:fieldValue bean="${vmsInstance}" field="course"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.destination}">
				<li class="fieldcontain">
					<span id="destination-label" class="property-label"><g:message code="vms.destination.label" default="Destination" /></span>
					
						<span class="property-value" aria-labelledby="destination-label"><g:fieldValue bean="${vmsInstance}" field="destination"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.flag}">
				<li class="fieldcontain">
					<span id="flag-label" class="property-label"><g:message code="vms.flag.label" default="Flag" /></span>
					
						<span class="property-value" aria-labelledby="flag-label"><g:fieldValue bean="${vmsInstance}" field="flag"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.lat}">
				<li class="fieldcontain">
					<span id="lat-label" class="property-label"><g:message code="vms.lat.label" default="Lat" /></span>
					
						<span class="property-value" aria-labelledby="lat-label"><g:fieldValue bean="${vmsInstance}" field="lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.locations}">
				<li class="fieldcontain">
					<span id="locations-label" class="property-label"><g:message code="vms.locations.label" default="Locations" /></span>
					
						<g:each in="${vmsInstance.locations}" var="l">
						<span class="property-value" aria-labelledby="locations-label"><g:link controller="location" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.lon}">
				<li class="fieldcontain">
					<span id="lon-label" class="property-label"><g:message code="vms.lon.label" default="Lon" /></span>
					
						<span class="property-value" aria-labelledby="lon-label"><g:fieldValue bean="${vmsInstance}" field="lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.registration}">
				<li class="fieldcontain">
					<span id="registration-label" class="property-label"><g:message code="vms.registration.label" default="Registration" /></span>
					
						<span class="property-value" aria-labelledby="registration-label"><g:fieldValue bean="${vmsInstance}" field="registration"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${vmsInstance?.speed}">
				<li class="fieldcontain">
					<span id="speed-label" class="property-label"><g:message code="vms.speed.label" default="Speed" /></span>
					
						<span class="property-value" aria-labelledby="speed-label"><g:fieldValue bean="${vmsInstance}" field="speed"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${vmsInstance?.id}" />
					<g:link class="edit" action="edit" id="${vmsInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
