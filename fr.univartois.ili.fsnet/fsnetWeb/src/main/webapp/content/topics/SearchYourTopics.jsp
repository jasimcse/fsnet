<%-- 
    Document   : SearchYourTopics
    Author     : Audrey Ruellan, Cerelia Besnainou
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>



<h3><bean:message key="hubs.searchTopic"/></h3>
<table>
    <html:form action="/SearchYourTopics">
        <tr>
            <td><label><bean:message key="hubs.subjectTopic"/></label></td>
            <td><html:text property="searchText" styleId="topicSujet" /></td>
            <td><html:hidden property="hubId" value="${hubResult.id}"/></td>
            <td><html:submit styleClass="button"><bean:message key="hubs.searchTopic"/></html:submit></td>
        </tr>
    </html:form>
</table>


<h3><bean:message key="hubs.hub"/> ${hubResult.title} - <bean:message key="topics.yourTopics"/></h3>
<logic:empty name="topicsLastMessage">
    <bean:message key="hubs.notopics"/>
</logic:empty>
<table class="inLineTable" style="margin-bottom: 20px;">
    <c:forEach var="couple" items="${topicsLastMessage}">
        <tr>
            <td>
                <!-- TODO gerer les favoris -->
                <img src="images/non-favorite.png" alt="Favorite" onclick="this.src='images/favorite.png';" onmouseover="this.style.cursor='pointer'"/>
                <img src="images/message.png"/>
            </td>
            <td>
                <html:link action="/DisplayTopic">
                    <html:param name="topicId" value="${couple.key.id}"/>
                    ${couple.key.title}
                </html:link>
                <br/>
                <bean:message key="hubs.createdOn"/>
                <bean:write name="hubResult" property="creationDate" format="dd/MM/yyyy"/>
                <bean:message key="hubs.by"/>
                <html:link action="/DisplayProfile">
                    <html:param name="id" value="${couple.key.creator.id}"/>
                    ${couple.key.creator.firstName} ${couple.key.creator.name}
                </html:link>
            </td>

            <td style="background-color: #C7E5F8;">
                <logic:notEmpty name="couple" property="value">
                    <c:set var="lastMessage" value="${couple.value}"/>
                    <bean:write name="lastMessage" property="creationDate" format="dd/MM/yyyy"/>
                    <br/>
                    <bean:message key="hubs.by"/> ${lastMessage.from.firstName} ${lastMessage.from.name}
                </logic:notEmpty>
                <logic:empty name="couple" property="value">
                    <bean:message key="hubs.noMessage"/>
                </logic:empty>
            </td>
            <c:if test="${sessionScope.user.id eq couple.key.creator.id}">
                <td class="tableButton">
                    <html:link action="/DeleteYourTopic" styleClass="button">
                        <html:param name="topicId" value="${couple.key.id}"/>
                        <html:param name="hubId" value="${hubResult.id}"/>
                        <bean:message key="hubs.deleteTopic"/>
                    </html:link>
                </td>
            </c:if>
        </tr>
    </c:forEach>
</table>