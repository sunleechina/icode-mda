<%@ page import="gov.spawar.icode.Vms" %>



<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'vesselName', 'error')} ">
	<label for="vesselName">
		<g:message code="vms.vesselName.label" default="Vessel Name" />
		
	</label>
	<g:textField name="vesselName" value="${vmsInstance?.vesselName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'callSign', 'error')} ">
	<label for="callSign">
		<g:message code="vms.callSign.label" default="Call Sign" />
		
	</label>
	<g:textField name="callSign" value="${vmsInstance?.callSign}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'country', 'error')} ">
	<label for="country">
		<g:message code="vms.country.label" default="Country" />
		
	</label>
	<g:textField name="country" value="${vmsInstance?.country}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'messageType', 'error')} ">
	<label for="messageType">
		<g:message code="vms.messageType.label" default="Message Type" />
		
	</label>
	<g:textField name="messageType" value="${vmsInstance?.messageType}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="vms.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${vmsInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'course', 'error')} required">
	<label for="course">
		<g:message code="vms.course.label" default="Course" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="course" required="" value="${vmsInstance.course}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'destination', 'error')} ">
	<label for="destination">
		<g:message code="vms.destination.label" default="Destination" />
		
	</label>
	<g:textField name="destination" value="${vmsInstance?.destination}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'flag', 'error')} ">
	<label for="flag">
		<g:message code="vms.flag.label" default="Flag" />
		
	</label>
	<g:textField name="flag" value="${vmsInstance?.flag}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'lat', 'error')} required">
	<label for="lat">
		<g:message code="vms.lat.label" default="Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="lat" step="any" required="" value="${vmsInstance.lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'locations', 'error')} ">
	<label for="locations">
		<g:message code="vms.locations.label" default="Locations" />
		
	</label>
	<g:select name="locations" from="${gov.spawar.icode.Location.list()}" multiple="multiple" optionKey="id" size="5" value="${vmsInstance?.locations*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'lon', 'error')} required">
	<label for="lon">
		<g:message code="vms.lon.label" default="Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="lon" step="any" required="" value="${vmsInstance.lon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'registration', 'error')} ">
	<label for="registration">
		<g:message code="vms.registration.label" default="Registration" />
		
	</label>
	<g:textField name="registration" value="${vmsInstance?.registration}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: vmsInstance, field: 'speed', 'error')} required">
	<label for="speed">
		<g:message code="vms.speed.label" default="Speed" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="speed" step="any" required="" value="${vmsInstance.speed}"/>
</div>

