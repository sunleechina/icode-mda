<%@ page import="gov.spawar.icode.Location" %>



<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'geometryObject', 'error')} required">
	<label for="geometryObject">
		<g:message code="location.geometryObject.label" default="Geometry Object" />
		<span class="required-indicator">*</span>
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="location.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="latitude" step="any" required="" value="${locationInstance.latitude}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="location.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="longitude" step="any" required="" value="${locationInstance.longitude}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="location.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${locationInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'ais', 'error')} required">
	<label for="ais">
		<g:message code="location.ais.label" default="Ais" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="ais" name="ais.id" from="${gov.spawar.icode.Ais.list()}" optionKey="id" required="" value="${locationInstance?.ais?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'altitude', 'error')} required">
	<label for="altitude">
		<g:message code="location.altitude.label" default="Altitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="altitude" step="any" required="" value="${locationInstance.altitude}"/>
</div>

