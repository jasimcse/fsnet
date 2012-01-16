<%-- 
		 Author : SAID Mohamed
--%>
	<%@page contentType="text/html" pageEncoding="UTF-8"%>
	<%@ taglib uri="http://struts.apache.org/tags-html"  prefix="html"%>
	<%@ taglib uri="http://struts.apache.org/tags-bean"  prefix="bean"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<tr>
			<td colspan="2">
				<label for="message"> 
					<bean:message key="members.message" /> :
				</label>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<bean:message key="members.welcomeMessage.welcome" /> "<bean:message key="members.name" />" "<bean:message key="members.firstName" />"
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:set var="welcomeMain"><bean:message key="members.welcomeMessage.main" /></c:set>
				<c:if test="${!empty CreateMemberForm.map.message}">
					<c:set var="welcomeMain">${CreateMemberForm.map.message}</c:set>
				</c:if>	
				<c:if test="${!empty CreateMultipleMemberForm.map.message}">
					<c:set var="welcomeMain">${CreateMultipleMemberForm.map.message}</c:set>
				</c:if>	
				<html:textarea property="message" styleId="message"  errorStyleClass="error" value="${welcomeMain}" rows="5" cols="50"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<bean:message key="members.welcomeMessage.url" /> "url". 
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<bean:message key="members.welcomeMessage.password" /> "<bean:message key="members.password" />" . 
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<bean:message key="members.welcomeMessage.donotreply" /> 
			</td>
		</tr>
		
		<tr class="errorMessage">
			<td colspan="2">
				<html:errors property="message" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<html:submit styleClass="button">
					<bean:message key="members.validate" />
				</html:submit>
			</td>
		</tr>