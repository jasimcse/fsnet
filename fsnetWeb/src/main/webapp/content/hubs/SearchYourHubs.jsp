<%-- 
    Document   : CreateHub
    Author     : Audrey Ruellan and Cerelia Besnainou
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="../../WEB-INF/ili.tld" prefix="ili"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<bean:define id="searchMessage">
	<bean:message key="hubs.search" />
</bean:define>

<h3>
	<bean:message key="hubs.searchHubs" />
</h3>
<table class="inLineTable">
	<tr>
		<td><html:form action="/SearchYourHubs" method="GET">
				<html:hidden property="communityId" value="${param.communityId}" />
				<table id="SearchHub">
					<tr>
						<td><html:text property="hubName" styleId="hubName" /> <ili:placeHolder
								id="hubName" value="${searchMessage}" /></td>
						<td><html:submit styleClass="button">
								<bean:message key="hubs.searchButton" />
							</html:submit></td>
					</tr>
				</table>
			</html:form></td>
	</tr>
</table>


<jsp:include page="/content/hubs/ModifyHub.jsp" />


<h3>
	<bean:message key="hubs.yourhubs" />
</h3>
<c:set var="hub" value="${hubResults}" />
<table class="inLineTable">
	<logic:empty name="hub">
		<tr>
			<td><bean:message key="hubs.hubNotFound" />
			<td>
		</tr>
	</logic:empty>
	<c:forEach var="hub" items="${hubResults}">
		<tr>
			<th><html:link action="/DisplayHub"
					title='${empty hub.interests? "" : hub.interests}'>
					<html:param name="hubId" value="${hub.id}" />
                    ${hub.title}
                </html:link> (${fn:length(hub.topics)} topics)</th>
			<td><bean:message key="hubs.createdOn" /> <bean:write
					name="hub" property="creationDate" format="dd/MM/yyyy" /> <bean:message
					key="hubs.by" /> <ili:getSocialEntityInfos
					socialEntity="${hub.creator}" /></td>
			<td class="tableButton"><c:if
					test="${sessionScope.userId eq hub.creator.id}">
					<a class="button"
						onclick="confirmDelete('DeleteYourHub.do?hubId='+${hub.id}+'&communityId='+${hub.community.id})">
						<bean:message key="hubs.delete" />
					</a>
				</c:if></td>
		</tr>

	</c:forEach>
</table>