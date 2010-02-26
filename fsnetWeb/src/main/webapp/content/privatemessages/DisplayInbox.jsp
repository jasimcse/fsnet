<%-- 
    Document   : DisplayMessages
    Created on : 2 févr. 2010, 18:29:45
    Author     : Matthieu Proucelle <matthieu.proucelle at gmail.com>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="../../WEB-INF/ili.tld" prefix="ili"%>
<h3><bean:message key="privatemessages.inbox" /></h3>
<logic:empty name="messages">
	<bean:message key="privatemessages.nomessages" />
</logic:empty>
<html:form action="/DeleteMultiMessages">
	<table class="inLineTable">

		<c:forEach items="${requestScope.messages}" var="message">
			<c:if test="${not message.reed}">
				<tr class="notReed">
					<td>
						<html:multibox property="selectedMessages"value="${message.id}" />
					</td>
					<td>
						<html:link action="/DisplayProfile">
               	    		<html:param name="id" value="${message.from.id}"/>
							<img src="GetMiniature.do?memberId=${message.from.id}" />
						</html:link>
					</td>
					<td style="width: 25%"><html:link action="/DisplayMessage">
						<html:param name="messageId" value="${message.id}" />
                        ${message.from.firstName} ${message.from.name}
                    </html:link></td>
					<td style="width: 50%"><html:link action="/DisplayMessage">
						<html:param name="messageId" value="${message.id}" />
						<span>${fn:substring(message.subject, 0,20)} : </span>
						<span style="color: gray"> <ili:substring beginIndex="0"
							endIndex="20">
							<ili:noxml>${message.body}</ili:noxml>
						</ili:substring> </span>
					</html:link></td>
			</c:if>
			<c:if test="${message.reed}">
				<tr>
					<td><html:multibox property="selectedMessages"
						value="${message.id}" /></td>
					<td>
						<html:link action="/DisplayProfile">
               	    		<html:param name="id" value="${message.from.id}"/>
							<img src="GetMiniature.do?memberId=${message.from.id}" />
						</html:link>
					</td>
					<td style="width: 25%"><html:link action="/DisplayMessage">
						<html:param name="messageId" value="${message.id}" />
                        ${message.from.firstName} ${message.from.name}
                    </html:link></td>
					<td style="width: 50%"><html:link action="/DisplayMessage">
						<html:param name="messageId" value="${message.id}" />
						<span>${fn:substring(message.subject, 0,20)} : </span>
						<span style="color: gray"> <ili:substring beginIndex="0"
							endIndex="20">
							<ili:noxml>${message.body}</ili:noxml>
						</ili:substring> </span>
					</html:link></td>
			</c:if>
			<td class="alignRight"><bean:write name="message"
				property="creationDate" format="dd/MM/yyyy HH:mm" /></td>
		</c:forEach>
	</table>
	<c:if test="${ ! empty requestScope.messages}">
		<html:submit styleClass="button">
			<bean:message key="privatemessages.delete" />
		</html:submit>
	</c:if>
</html:form>