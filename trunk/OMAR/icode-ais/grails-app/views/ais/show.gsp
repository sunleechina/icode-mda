
<%@ page import="gov.spawar.icode.Ais" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ais.label', default: 'Ais')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.vesselName.label" default="Vessel Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "vesselName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.vesselType.label" default="Vessel Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "vesselType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.mmsi.label" default="Mmsi" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "mmsi")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.IMO.label" default="IMO" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "IMO")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.navStatus.label" default="Nav Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "navStatus")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.callsign.label" default="Callsign" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "callsign")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.length.label" default="Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "length")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.width.label" default="Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "width")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.antennaLocationBow.label" default="Antenna Location Bow" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "antennaLocationBow")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.antennaLocationPort.label" default="Antenna Location Port" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "antennaLocationPort")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.antennaLocationStarboard.label" default="Antenna Location Starboard" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "antennaLocationStarboard")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.antennaLocationStern.label" default="Antenna Location Stern" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "antennaLocationStern")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.courseOverGround.label" default="Course Over Ground" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "courseOverGround")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${aisInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.destination.label" default="Destination" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "destination")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.draught.label" default="Draught" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "draught")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.eta.label" default="Eta" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${aisInstance?.eta}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${aisInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.locations.label" default="Locations" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${aisInstance.locations}" var="l">
                                    <li><g:link controller="location" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.messageType.label" default="Message Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "messageType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.posAccuracy.label" default="Pos Accuracy" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "posAccuracy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.positionFixType.label" default="Position Fix Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "positionFixType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.rateOfTurn.label" default="Rate Of Turn" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "rateOfTurn")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.speedOverGround.label" default="Speed Over Ground" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "speedOverGround")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="ais.trueHeading.label" default="True Heading" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: aisInstance, field: "trueHeading")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${aisInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
