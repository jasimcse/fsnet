<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="logo2">
	<c:choose>
		<c:when test="${sessionScope.hisGroup != null}">
			<img src="groups/${sessionScope.parentGroupId}.png" alt="GroupLogo" />
		</c:when>
		<c:otherwise>
			<img src="/images/FSNET.png" alt="Logo" />
		</c:otherwise>
	</c:choose>

</div>
<div class="cadreDivMenuTop">
<h3>${sessionScope.userFirstName} ${sessionScope.userName}</h3>
<div>
<html:link action="/DisplayProfile" >
	<img src="avatar/${sessionScope.userId}.png" alt="Avatar" />
</html:link>
</div>
<div class="group">
	
	<c:choose>
		<c:when test="${sessionScope.hisGroup != null}">
			<bean:message key="avatar.groups" />
			<html:link action="/DisplayInformationGroup">
				<html:param name="idGroup" value="${sessionScope.hisGroup.id}" />
		${sessionScope.hisGroup.name}
	</html:link>
		</c:when>
		<c:otherwise>
			<bean:message key="avatar.member.no.group" />
		</c:otherwise>
	</c:choose>
	<br>
	<c:choose>
		<c:when test="${isMasterGroup}">
			<html:link action="DisplayProfile.do">
				<bean:message key="leftMenu.user.group.manager" />
			</html:link>
		</c:when>
		<c:otherwise>
			<c:if test="${isGroupResponsible}">
				<html:link action="DisplayProfile.do">
					<bean:message key="leftMenu.user.group.responsible" />
				</html:link>
			</c:if>
		</c:otherwise>
	</c:choose>
</div>
</div>
