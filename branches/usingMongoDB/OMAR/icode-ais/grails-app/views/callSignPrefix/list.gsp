
<%@ page import="gov.spawar.icode.CallSignPrefix" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="generatedViews" />
        <g:set var="entityName" value="${message(code: 'callSignPrefix.label', default: 'CallSignPrefix')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'callSignPrefix.id.label', default: 'Id')}" />
                        
                            <th><g:message code="callSignPrefix.country.label" default="Country" /></th>
                        
                            <g:sortableColumn property="prefix" title="${message(code: 'callSignPrefix.prefix.label', default: 'Prefix')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${callSignPrefixInstanceList}" status="i" var="callSignPrefixInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${callSignPrefixInstance.id}">${fieldValue(bean: callSignPrefixInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: callSignPrefixInstance, field: "country")}</td>
                        
                            <td>${fieldValue(bean: callSignPrefixInstance, field: "prefix")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${callSignPrefixInstanceTotal}" />
            </div>
        </div>
    </content>
    </body>
</html>
