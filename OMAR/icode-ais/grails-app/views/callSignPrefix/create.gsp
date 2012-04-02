

<%@ page import="gov.spawar.icode.CallSignPrefix" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'callSignPrefix.label', default: 'CallSignPrefix')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${callSignPrefixInstance}">
            <div class="errors">
                <g:renderErrors bean="${callSignPrefixInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><g:message code="callSignPrefix.country.label" default="Country" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: callSignPrefixInstance, field: 'country', 'errors')}">
                                    <g:select name="country.id" from="${gov.spawar.icode.Country.list()}" optionKey="id" value="${callSignPrefixInstance?.country?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="prefix"><g:message code="callSignPrefix.prefix.label" default="Prefix" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: callSignPrefixInstance, field: 'prefix', 'errors')}">
                                    <g:textField name="prefix" value="${callSignPrefixInstance?.prefix}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
