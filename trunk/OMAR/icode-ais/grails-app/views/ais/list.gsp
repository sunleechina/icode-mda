
<%@ page import="gov.spawar.icode.Ais" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="generatedViews" />
        <g:set var="entityName" value="${message(code: 'ais.label', default: 'Ais')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <content tag="content">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'ais.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="vesselName" title="${message(code: 'ais.vesselName.label', default: 'Vessel Name')}" />
                        
                            <g:sortableColumn property="vesselType" title="${message(code: 'ais.vesselType.label', default: 'Vessel Type')}" />
                        
                            <g:sortableColumn property="mmsi" title="${message(code: 'ais.mmsi.label', default: 'Mmsi')}" />
                        
                            <g:sortableColumn property="IMO" title="${message(code: 'ais.IMO.label', default: 'IMO')}" />
                        
                            <g:sortableColumn property="navStatus" title="${message(code: 'ais.navStatus.label', default: 'Nav Status')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${aisInstanceList}" status="i" var="aisInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${aisInstance.id}">${fieldValue(bean: aisInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: aisInstance, field: "vesselName")}</td>
                        
                            <td>${fieldValue(bean: aisInstance, field: "vesselType")}</td>
                        
                            <td>${fieldValue(bean: aisInstance, field: "mmsi")}</td>
                        
                            <td>${fieldValue(bean: aisInstance, field: "IMO")}</td>
                        
                            <td>${fieldValue(bean: aisInstance, field: "navStatus")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${aisInstanceTotal}" />
            </div>
        </div>
      
    </content>
    </body>
</html>
