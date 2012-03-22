<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="../../WEB-INF/ili.tld" prefix="ili"%>

<bean:define id="searchGroup">
	<bean:message key="groups.placeholder.search" />
</bean:define>

<fieldset class="fieldsetAdmin">
	<legend class="legendAdmin">
		<bean:message key="groups.title.search" />
	</legend>

	<html:form action="SearchGroup">
		<div id="SearchGroup">
			<table class="inLineTable fieldsetTableAdmin">
				<tr>
					<td><html:text property="searchText" styleId="searchTexte" />
						<ili:placeHolder id="searchTexte" value="${searchGroup}" /> <html:submit
							styleClass="button">
							<bean:message key="groups.button.search" />
						</html:submit></td>
				</tr>
			</table>
		</div>
	</html:form>
</fieldset>

<fieldset class="fieldsetAdmin">
	<legend class="legendAdmin">
		<bean:message key="groups.title.listGroups" />
	</legend>

	<c:choose>
		<c:when test="${not empty requestScope.groupsList}">
			<table id="groupTable"
				class="inLineTable fieldsetTableAdmin tablesorter">
				<thead>
					<tr>
						<th><bean:message key="tableheader.groupname" /></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="group" items="${requestScope.groupsList}">
						<tr class="content">
							<td><html:link action="/DisplayGroup">${group.name} 
                		<html:param name="idGroup" value="${group.id}" />
								</html:link></td>
							<td class="tableButton"><html:link
									action="/SwitchStateGroup" styleClass="button">
									<html:param name="groupSelected" value="${group.id}" />
									<c:choose>
										<c:when test="${group.isEnabled}">
											<bean:message key="members.searchDisable" />
										</c:when>
										<c:otherwise>
											<bean:message key="members.searchEnable" />
										</c:otherwise>
									</c:choose>
								</html:link></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
		<c:otherwise>
			<table class="inLineTable fieldsetTableAdmin">
				<tr>
					<td><bean:message key="members.noResult" /></td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
</fieldset>

<c:if test="${!empty success}">
	<script type="text/javascript">
		jQuery(function() {
			popup();
		});
		success = null;
	</script>
	<div id="osx-modal-content" class="simplemodal-data">
		<div id="osx-modal-title">Message</div>
		<div class="close">
			<a class="simplemodal-close" href="#">X</a>
		</div>
		<div id="osx-modal-data">
			<p>
				<c:out value="${success}" />
			</p>
		</div>
	</div>
</c:if>

<script type="text/javascript">
	$(document).ready(
			function pagination() {
				var nomTable = "groupTable";
				var idColonneATrier = 0;
				var sensDeTri = "asc";
				var aoColumns = [ null, {
					"bSortable" : false
				} ];
				miseEnPageTable(nomTable, idColonneATrier, sensDeTri,
						aoColumns, false);
			});
</script>

