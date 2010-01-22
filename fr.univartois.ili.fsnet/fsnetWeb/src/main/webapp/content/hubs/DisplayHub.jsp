<%-- 
    Document   : CreateHub
    Author     : Audrey Ruellan, Cerelia Besnainou et Zhu rui <zrhurey@gmail.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>


<html:form action="/CreateTopic">
	<h3>Create Topic :</h3>
	<table>
		<tr>
		<td><label>Topic's subjet :</label></td>
		<td><html:text property="topicSujet" styleId="topicSujet" /></td>
		<td><html:hidden property="hubId" value="${hubResult.id}"/></td>
		<td><html:submit styleClass="button">Create Topic</html:submit></td>
		</tr>
    </table>
</html:form>

<h3>Search Topic</h3>
<table>
	<html:form action="/SearchTopic">
		<tr>
		<td><label>Topic's subjet :</label></td>
		<td><html:text property="topicSujetSearch" styleId="topicSujet" /></td>
		<td><html:hidden property="hubId" value="${hubResult.id}"/></td>
		<td><html:submit styleClass="button">Search Topic</html:submit></td>
		</tr>
	</html:form>
	<c:if test="${not empty resRearchTopics}">
		<tr>
		<th>Result of search</th>
		</tr>
		<c:forEach var="topic" items="${resRearchTopics}">
		<tr>
			<td> <html:link action="/DisplayTopic">
		    		<html:param name="topicId" value="${topic.id}"/>
	    			${topic.sujet}
	    		</html:link></td>
	    	<td>
		    	<c:if test="${sessionScope.user.id eq topic.propTopic.id}">
		    	 <html:link action="/DeleteTopic" styleClass="button">
			    		<html:param name="topicId" value="${topic.id}"/>
		    			Delete Topic
		    	</html:link>
		    	</c:if>
	    	</td>
	    </tr>
		</c:forEach>
				
	</c:if>
</table>

<h3><bean:message key="hubs.hub"/> ${hubResult.nomCommunaute}</h3>
<table id="HubList">
	<tr class="content">
			<td class="left">${hubResult.dateCreation}</td>
			<td class="left">${hubResult.createur.prenom} ${hubResult.createur.nom}</td>
    		<td class="right">
    			 <c:if test="${sessionScope.user.id eq hubResult.createur.id}">
	    			 <html:link action="/DeleteHub" styleClass="button">
		    			 <html:param name="hubId" value="${hub.id}"/>
		    			 <bean:message key="hubs.delete"/>
	    			 </html:link>
				</c:if>
    		</td>
    </tr>
   
    	<c:forEach var="topic" items="${hubResult.lesTopics}">
    	 <tr>
    	 	<td>
    	 	<html:link action="/DisplayTopic">
		    		<html:param name="topicId" value="${topic.id}"/>
		    		${topic.sujet}
	    	</html:link></td>
	    	<td>
		    	<c:if test="${sessionScope.user.id eq topic.propTopic.id}">
		    	 <html:link action="/DeleteTopic" styleClass="button">
			    		<html:param name="topicId" value="${topic.id}"/>
		    			Delete Topic
		    	</html:link>
		    	</c:if>
	    	</td>
    	 </tr>
    	</c:forEach>
    
    <tr class="gap">
    		<td colspan="2"></td>
    </tr>
</table>