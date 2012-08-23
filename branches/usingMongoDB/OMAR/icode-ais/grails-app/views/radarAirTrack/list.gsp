
<%@ page import="gov.spawar.icode.RadarAirTrack" %>
<!doctype html>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="generatedViews" />
		<g:set var="entityName" value="${message(code: 'radarAirTrack.label', default: 'RadarAirTrack')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <content tag="content">
		<a href="#list-radarAirTrack" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-radarAirTrack" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="sdsTrackID_kluster" title="${message(code: 'radarAirTrack.sdsTrackID_kluster.label', default: 'Sds Track ID kluster')}" />
					
						<g:sortableColumn property="sdsTrackID_port" title="${message(code: 'radarAirTrack.sdsTrackID_port.label', default: 'Sds Track ID port')}" />
					
						<g:sortableColumn property="sdsTrackID_platform" title="${message(code: 'radarAirTrack.sdsTrackID_platform.label', default: 'Sds Track ID platform')}" />
					
						<g:sortableColumn property="sdsTrackID_category" title="${message(code: 'radarAirTrack.sdsTrackID_category.label', default: 'Sds Track ID category')}" />
					
						<g:sortableColumn property="sdsTrackID_amplification" title="${message(code: 'radarAirTrack.sdsTrackID_amplification.label', default: 'Sds Track ID amplification')}" />
					
						<g:sortableColumn property="sdsTrackID_site" title="${message(code: 'radarAirTrack.sdsTrackID_site.label', default: 'Sds Track ID site')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${radarAirTrackInstanceList}" status="i" var="radarAirTrackInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${radarAirTrackInstance.id}">${fieldValue(bean: radarAirTrackInstance, field: "sdsTrackID_kluster")}</g:link></td>
					
						<td>${fieldValue(bean: radarAirTrackInstance, field: "sdsTrackID_port")}</td>
					
						<td>${fieldValue(bean: radarAirTrackInstance, field: "sdsTrackID_platform")}</td>
					
						<td>${fieldValue(bean: radarAirTrackInstance, field: "sdsTrackID_category")}</td>
					
						<td>${fieldValue(bean: radarAirTrackInstance, field: "sdsTrackID_amplification")}</td>
					
						<td>${fieldValue(bean: radarAirTrackInstance, field: "sdsTrackID_site")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${radarAirTrackInstanceTotal}" />
			</div>
		</div>
    </content>
	</body>
</html>
