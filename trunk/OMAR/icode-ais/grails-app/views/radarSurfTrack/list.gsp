
<%@ page import="gov.spawar.icode.RadarSurfTrack" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'radarSurfTrack.label', default: 'RadarSurfTrack')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-radarSurfTrack" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-radarSurfTrack" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="sdsTrackID_kluster" title="${message(code: 'radarSurfTrack.sdsTrackID_kluster.label', default: 'Sds Track ID kluster')}" />
					
						<g:sortableColumn property="sdsTrackID_port" title="${message(code: 'radarSurfTrack.sdsTrackID_port.label', default: 'Sds Track ID port')}" />
					
						<g:sortableColumn property="sdsTrackID_platform" title="${message(code: 'radarSurfTrack.sdsTrackID_platform.label', default: 'Sds Track ID platform')}" />
					
						<g:sortableColumn property="sdsTrackID_category" title="${message(code: 'radarSurfTrack.sdsTrackID_category.label', default: 'Sds Track ID category')}" />
					
						<g:sortableColumn property="sdsTrackID_amplification" title="${message(code: 'radarSurfTrack.sdsTrackID_amplification.label', default: 'Sds Track ID amplification')}" />
					
						<g:sortableColumn property="sdsTrackID_site" title="${message(code: 'radarSurfTrack.sdsTrackID_site.label', default: 'Sds Track ID site')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${radarSurfTrackInstanceList}" status="i" var="radarSurfTrackInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${radarSurfTrackInstance.id}">${fieldValue(bean: radarSurfTrackInstance, field: "sdsTrackID_kluster")}</g:link></td>
					
						<td>${fieldValue(bean: radarSurfTrackInstance, field: "sdsTrackID_port")}</td>
					
						<td>${fieldValue(bean: radarSurfTrackInstance, field: "sdsTrackID_platform")}</td>
					
						<td>${fieldValue(bean: radarSurfTrackInstance, field: "sdsTrackID_category")}</td>
					
						<td>${fieldValue(bean: radarSurfTrackInstance, field: "sdsTrackID_amplification")}</td>
					
						<td>${fieldValue(bean: radarSurfTrackInstance, field: "sdsTrackID_site")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${radarSurfTrackInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
