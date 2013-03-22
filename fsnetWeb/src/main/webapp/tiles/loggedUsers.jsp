<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="../WEB-INF/ili.tld" prefix="ili"%>
<h2>
	<s:text name="leftMenu.title.loggedUsers" />
</h2>

<div id="loggedUsers" class="littlePadding">
	<ili:loggedUsers var="user" userId="${sessionScope.currentUserId}"
		loggedUsers="${applicationScope.loggedUsers}">


		<s:url action="DisplayProfile" var="urlDisplayProfile">
			<s:param name="id" value="%{user.id}" />
		</s:url>
		<a href="<s:property value="#urlDisplayProfile" />" class="miniature" >
			<img src="avatar/${user.id}.png"
				title="${user.name} ${user.firstName}" alt="Avatar"></img>
		</a>
		
	</ili:loggedUsers>
</div>