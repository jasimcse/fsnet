<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="js/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="js/mceTextArea.js"></script>


<fieldset class="fieldsetCadre">
	<legend>
		<s:text name="announce.title.modify" />
	</legend>
	<table id="ModifyAnnounce"
		class="inLineTable tableStyle">

		<s:form action="ModifyAnnounce">
			<s:hidden property="idAnnounce" />

			<tr>
				<td><label for="announceTitle"><s:text
							name="announce.form.title" /></label></td>
				<td><s:textfield property="announceTitle" styleId="announceTitle" />
					</td>
			</tr>

			<tr>
				<td><label for="announceContent"><s:text
							name="announce.form.content" /> </label></td>
				<td><s:textarea cols="40" rows="8"
						property="announceContent" styleId="announceContent"
						cssClass="mceTextArea" style="width: 100%;" />
					</td>
			</tr>

			<tr>
				<td><label for="announceExpiryDate"><s:text
							name="announce.form.date" /></label></td>
				<td><s:textfield property="announceExpiryDate"
 						styleId="announceExpiryDate" />
			</td>
			</tr>

			<tr>
				<td colspan="2" class="tableButton">
					<s:submit cssClass="btn btn-inverse" key="announce.button.modify"/> 
				</td>
			</tr>

		</s:form>
	</table>
</fieldset>

<script type="text/javascript" src="js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.extend({
			minDate : 0,
			dateFormat : 'dd/mm/yy',
			showOn : 'both',
			buttonImage : 'images/calendar.gif',
			buttonImageOnly : true,
			showMonthAfterYear : false
		}));
		$.datepicker.setDefaults($.datepicker.regional['fr']);
		
		$.timepicker.regional['fr'] = {
			timeOnlyTitle : 'Temps',
			timeText : 'Temps',
			hourText : 'Heure',
			minuteText : 'Minute',
			secondText : 'Seconde',
			millisecText : 'milliseconde',
			currentText : 'Maintenant',
			closeText : 'Ok',
			ampm : false,
			timeFormat : 'hh:mm',
		};
		$.timepicker.setDefaults($.timepicker.regional['fr']);

		$('#announceExpiryDate').datetimepicker();

	});
</script>

