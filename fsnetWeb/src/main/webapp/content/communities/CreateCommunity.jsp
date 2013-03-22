<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<fieldset class="fieldsetCadre">
	<legend>
		<s:text name="communities.title.create" />
	</legend>

	<table id="CreateCommunity" class="inLineTable tableStyle">
		<s:form action="/CreateCommunity">
			<tr>
				<td><label for="communityName"><s:text
							name="communities.form.name" /></label></td>
				<td><s:textfield property="communityName" var="communityName"
						cssErrorClass="error" /></td>
			</tr>

			<tr>
				<td colspan="2"><s:include
						value="<s:url action='InterestCheckBoxes'/>" /></td>
			</tr>

			<tr>
				<td colspan="2" class="tableButton"><s:submit
						cssClass="btn btn-inverse" key="communities.button.validate" />
				</td>
			</tr>
		</s:form>
	</table>
</fieldset>
