

<%@ page import="gov.spawar.icode.Ais" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ais.label', default: 'Ais')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${aisInstance}">
            <div class="errors">
                <g:renderErrors bean="${aisInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${aisInstance?.id}" />
                <g:hiddenField name="version" value="${aisInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vesselName"><g:message code="ais.vesselName.label" default="Vessel Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'vesselName', 'errors')}">
                                    <g:textField name="vesselName" maxlength="50" value="${aisInstance?.vesselName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vesselType"><g:message code="ais.vesselType.label" default="Vessel Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'vesselType', 'errors')}">
                                    <g:textField name="vesselType" value="${fieldValue(bean: aisInstance, field: 'vesselType')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mmsi"><g:message code="ais.mmsi.label" default="Mmsi" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'mmsi', 'errors')}">
                                    <g:textField name="mmsi" value="${fieldValue(bean: aisInstance, field: 'mmsi')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="IMO"><g:message code="ais.IMO.label" default="IMO" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'IMO', 'errors')}">
                                    <g:textField name="IMO" value="${fieldValue(bean: aisInstance, field: 'IMO')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="navStatus"><g:message code="ais.navStatus.label" default="Nav Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'navStatus', 'errors')}">
                                    <g:textField name="navStatus" value="${fieldValue(bean: aisInstance, field: 'navStatus')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="callsign"><g:message code="ais.callsign.label" default="Callsign" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'callsign', 'errors')}">
                                    <g:textField name="callsign" value="${aisInstance?.callsign}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="length"><g:message code="ais.length.label" default="Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'length', 'errors')}">
                                    <g:textField name="length" value="${fieldValue(bean: aisInstance, field: 'length')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="width"><g:message code="ais.width.label" default="Width" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'width', 'errors')}">
                                    <g:textField name="width" value="${fieldValue(bean: aisInstance, field: 'width')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="antennaLocationBow"><g:message code="ais.antennaLocationBow.label" default="Antenna Location Bow" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'antennaLocationBow', 'errors')}">
                                    <g:textField name="antennaLocationBow" value="${fieldValue(bean: aisInstance, field: 'antennaLocationBow')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="antennaLocationPort"><g:message code="ais.antennaLocationPort.label" default="Antenna Location Port" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'antennaLocationPort', 'errors')}">
                                    <g:textField name="antennaLocationPort" value="${fieldValue(bean: aisInstance, field: 'antennaLocationPort')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="antennaLocationStarboard"><g:message code="ais.antennaLocationStarboard.label" default="Antenna Location Starboard" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'antennaLocationStarboard', 'errors')}">
                                    <g:textField name="antennaLocationStarboard" value="${fieldValue(bean: aisInstance, field: 'antennaLocationStarboard')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="antennaLocationStern"><g:message code="ais.antennaLocationStern.label" default="Antenna Location Stern" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'antennaLocationStern', 'errors')}">
                                    <g:textField name="antennaLocationStern" value="${fieldValue(bean: aisInstance, field: 'antennaLocationStern')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="courseOverGround"><g:message code="ais.courseOverGround.label" default="Course Over Ground" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'courseOverGround', 'errors')}">
                                    <g:textField name="courseOverGround" value="${fieldValue(bean: aisInstance, field: 'courseOverGround')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="destination"><g:message code="ais.destination.label" default="Destination" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'destination', 'errors')}">
                                    <g:textField name="destination" value="${aisInstance?.destination}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="draught"><g:message code="ais.draught.label" default="Draught" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'draught', 'errors')}">
                                    <g:textField name="draught" value="${fieldValue(bean: aisInstance, field: 'draught')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="eta"><g:message code="ais.eta.label" default="Eta" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'eta', 'errors')}">
                                    <g:datePicker name="eta" precision="day" value="${aisInstance?.eta}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="locations"><g:message code="ais.locations.label" default="Locations" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'locations', 'errors')}">
                                    
<ul>
<g:each in="${aisInstance?.locations?}" var="l">
    <li><g:link controller="location" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="location" action="create" params="['ais.id': aisInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'location.label', default: 'Location')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="messageType"><g:message code="ais.messageType.label" default="Message Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'messageType', 'errors')}">
                                    <g:textField name="messageType" value="${fieldValue(bean: aisInstance, field: 'messageType')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="posAccuracy"><g:message code="ais.posAccuracy.label" default="Pos Accuracy" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'posAccuracy', 'errors')}">
                                    <g:textField name="posAccuracy" value="${fieldValue(bean: aisInstance, field: 'posAccuracy')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="positionFixType"><g:message code="ais.positionFixType.label" default="Position Fix Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'positionFixType', 'errors')}">
                                    <g:textField name="positionFixType" value="${fieldValue(bean: aisInstance, field: 'positionFixType')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="rateOfTurn"><g:message code="ais.rateOfTurn.label" default="Rate Of Turn" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'rateOfTurn', 'errors')}">
                                    <g:textField name="rateOfTurn" value="${fieldValue(bean: aisInstance, field: 'rateOfTurn')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="speedOverGround"><g:message code="ais.speedOverGround.label" default="Speed Over Ground" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'speedOverGround', 'errors')}">
                                    <g:textField name="speedOverGround" value="${fieldValue(bean: aisInstance, field: 'speedOverGround')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="trueHeading"><g:message code="ais.trueHeading.label" default="True Heading" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aisInstance, field: 'trueHeading', 'errors')}">
                                    <g:textField name="trueHeading" value="${fieldValue(bean: aisInstance, field: 'trueHeading')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
