
<%@ page import="gov.spawar.icode.Vms" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'vms.label', default: 'Vms')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-vms" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-vms" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="vesselName" title="${message(code: 'vms.vesselName.label', default: 'Vessel Name')}" />
					
						<g:sortableColumn property="callSign" title="${message(code: 'vms.callSign.label', default: 'Call Sign')}" />
					
						<g:sortableColumn property="country" title="${message(code: 'vms.country.label', default: 'Country')}" />
					
						<g:sortableColumn property="messageType" title="${message(code: 'vms.messageType.label', default: 'Message Type')}" />
					
						<g:sortableColumn property="date" title="${message(code: 'vms.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="course" title="${message(code: 'vms.course.label', default: 'Course')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${vmsInstanceList}" status="i" var="vmsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${vmsInstance.id}">${fieldValue(bean: vmsInstance, field: "vesselName")}</g:link></td>
					
						<td>${fieldValue(bean: vmsInstance, field: "callSign")}</td>
					
						<td>${fieldValue(bean: vmsInstance, field: "country")}</td>
					
						<td>${fieldValue(bean: vmsInstance, field: "messageType")}</td>
					
						<td><g:formatDate date="${vmsInstance.date}" /></td>
					
						<td>${fieldValue(bean: vmsInstance, field: "course")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${vmsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
