
<%@ page import="gov.spawar.icode.Ais" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ais.label', default: 'Ais')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ais" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ais" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="IMO" title="${message(code: 'ais.IMO.label', default: 'IMO')}" />
					
						<g:sortableColumn property="antennaLocationBow" title="${message(code: 'ais.antennaLocationBow.label', default: 'Antenna Location Bow')}" />
					
						<g:sortableColumn property="antennaLocationPort" title="${message(code: 'ais.antennaLocationPort.label', default: 'Antenna Location Port')}" />
					
						<g:sortableColumn property="antennaLocationStarboard" title="${message(code: 'ais.antennaLocationStarboard.label', default: 'Antenna Location Starboard')}" />
					
						<g:sortableColumn property="antennaLocationStern" title="${message(code: 'ais.antennaLocationStern.label', default: 'Antenna Location Stern')}" />
					
						<g:sortableColumn property="callsign" title="${message(code: 'ais.callsign.label', default: 'Callsign')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${aisInstanceList}" status="i" var="aisInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${aisInstance.id}">${fieldValue(bean: aisInstance, field: "IMO")}</g:link></td>
					
						<td>${fieldValue(bean: aisInstance, field: "antennaLocationBow")}</td>
					
						<td>${fieldValue(bean: aisInstance, field: "antennaLocationPort")}</td>
					
						<td>${fieldValue(bean: aisInstance, field: "antennaLocationStarboard")}</td>
					
						<td>${fieldValue(bean: aisInstance, field: "antennaLocationStern")}</td>
					
						<td>${fieldValue(bean: aisInstance, field: "callsign")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${aisInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
