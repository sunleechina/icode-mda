
<%@ page import="gov.spawar.icode.Country" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="generatedViews" />
        <g:set var="entityName" value="${message(code: 'country.label', default: 'Country')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'country.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'country.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="countryCode" title="${message(code: 'country.countryCode.label', default: 'Country Code')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${countryInstanceList}" status="i" var="countryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${countryInstance.id}">${fieldValue(bean: countryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: countryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: countryInstance, field: "countryCode")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${countryInstanceTotal}" />
            </div>
        </div>

    </content>
    </body>
</html>
