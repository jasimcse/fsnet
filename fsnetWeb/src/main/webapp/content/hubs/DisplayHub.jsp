<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="../../WEB-INF/ili.tld" prefix="ili"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<bean:define id="searchMessage">
	<bean:message key="topics.placeholder.search" />
</bean:define>

<fieldset class="fieldsetCadre">
	<legend>
		<c:import url="/FavoriteFragment.do">
			<c:param name="interactionId" value="${hubResult.id}" />
		</c:import>

		<bean:write name="hubResult" property="title" />
	</legend>

	<c:set var="theInteraction" value="${hubResult}" scope="request" />
	<jsp:include page="/content/interactions/LargeInteractionInfo.jsp" />
</fieldset>
<div class="clear"></div>

<fieldset class="fieldsetCadre">
	<legend>
		<bean:message key="hubs.title.searchTopic" />
	</legend>
	<table class="inLineTable tableStyle">
		<html:form action="/SearchTopic" method="get">
			<tr>
				<td><html:text property="topicSujetSearch" styleId="topicSujet" />
					<ili:placeHolder id="topicSujet" value="${searchMessage}" /></td>
				<td><html:hidden property="hubId" value="${hubResult.id}" /></td>
				<td><html:submit styleClass="btn btn-inverse">
						<bean:message key="hubs.button.searchTopic" />
					</html:submit></td>
			</tr>
		</html:form>
	</table>
</fieldset>

<fieldset class="fieldsetCadre">
	<legend>
		<html:link action="/DisplayCommunity">
			<html:param name="communityId" value="${hubResult.community.id}" />
        ${hubResult.community.title}
    </html:link>
		-&gt;
		<html:link action="/DisplayHub">
			<html:param name="hubId" value="${hubResult.id}" />
        ${hubResult.title}
    </html:link>
		-&gt;
		<bean:message key="hubs.title.topics" />
	</legend>
	<table class="inLineTable tableStyle">
		<logic:empty name="topicsLastMessage">
			<tr>
				<td><bean:message key="hubs.noTopics" /></td>
			</tr>
		</logic:empty>
		<c:forEach var="couple" items="${topicsLastMessage}">
			<c:set var="theTopic" value="${couple.key}" />
			<tr>
				<td><c:import url="/FavoriteFragment.do">
						<c:param name="interactionId" value="${theTopic.id}" />
					</c:import></td>
				<td><html:link action="/DisplayTopic"
						title='${empty theTopic.interests? "" : theTopic.interests}'>
						<html:param name="topicId" value="${theTopic.id}" />
                    ${theTopic.title}
                </html:link> (${fn:length(theTopic.messages)} messages) <br /> <bean:message
						key="hubs.createdOn" /> <bean:write name="hubResult"
						property="creationDate" format="dd/MM/yyyy" /> <bean:message
						key="hubs.by" /> <ili:getSocialEntityInfos
						socialEntity="${couple.key.creator}" /></td>

				<td style="background-color: #C7E5F8;"><logic:notEmpty
						name="couple" property="value">
						<c:set var="lastMessage" value="${couple.value}" />
						<bean:write name="lastMessage" property="creationDate"
							format="dd/MM/yyyy" />
						<br />
						<bean:message key="hubs.by" />
						<ili:getSocialEntityInfos socialEntity="${lastMessage.from}" />
					</logic:notEmpty> <logic:empty name="couple" property="value">
						<bean:message key="hubs.noMessage" />
					</logic:empty></td>
				<c:if test="${sessionScope.userId eq couple.key.creator.id}">
					<td class="tableButton"><a class="btn btn-inverse"
						onclick="confirmDelete('DeleteTopic.do?topicId='+${couple.key.id}+'&hubId='+${hubResult.id}, '<bean:message key="message.confirmation.delete" />');">
							<bean:message key="hubs.button.deleteTopic" />
					</a></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</fieldset>
