<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<link type="text/css" href="css/jquery.qtip.css" rel="stylesheet" />

<script type="text/javascript" src="js/jquery.qtip.js"></script>

<div id=formImportEvent>

	<fieldset class="fieldsetCadre">
		<legend>
			<s:text name="events.form.importIcsFile" />
		</legend>

		<s:form styleId="formImportEventsFromFile"
			action="importEventsFromFile" enctype="multipart/form-data">
			<table class="inLineTable  tableStyle">
				<tr>
					<td><label for="icsFile"><s:text
								name="events.form.browseIcsFile" /></label></td>
					<td><input size="40%" type="file" name="icsFile" id="icsFile" />
						</td>
				</tr>
				<tr>
					<td colspan="2" class="tableButton"><input
						class="button btn btn-inverse" type="submit"
						value="<s:text name="events.button.import" />" /></td>
				</tr>
			</table>
		</s:form>
	</fieldset>

</div>