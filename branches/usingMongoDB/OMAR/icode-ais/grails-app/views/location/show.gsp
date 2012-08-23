
<%@ page import="gov.spawar.icode.Location" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'location.label', default: 'Location')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-location" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-location" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list location">
			
				<g:if test="${locationInstance?.geometryObject}">
				<li class="fieldcontain">
					<span id="geometryObject-label" class="property-label"><g:message code="location.geometryObject.label" default="Geometry Object" /></span>
					
						<span class="property-value" aria-labelledby="geometryObject-label"><g:fieldValue bean="${locationInstance}" field="geometryObject"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${locationInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="location.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${locationInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${locationInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="location.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${locationInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${locationInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="location.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${locationInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${locationInstance?.ais}">
				<li class="fieldcontain">
					<span id="ais-label" class="property-label"><g:message code="location.ais.label" default="Ais" /></span>
					
						<span class="property-value" aria-labelledby="ais-label"><g:link controller="ais" action="show" id="${locationInstance?.ais?.id}">${locationInstance?.ais?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${locationInstance?.altitude}">
				<li class="fieldcontain">
					<span id="altitude-label" class="property-label"><g:message code="location.altitude.label" default="Altitude" /></span>
					
						<span class="property-value" aria-labelledby="altitude-label"><g:fieldValue bean="${locationInstance}" field="altitude"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${locationInstance?.id}" />
					<g:link class="edit" action="edit" id="${locationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
