<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<div class="paginator">
	<c:choose>
		<c:when test="${paginatorInstance.hasPreviousPage}">
			<html:link styleClass="paginatorPagePrevious" action="${paginatorAction}">
				<html:param name="pageId" value="${paginatorInstance.previousPage}"/>
				<html:param name="tileId" value="${paginatorTile}"/>
		 		<html:param name="${paginatorInstance.requestInputName}" value="${paginatorInstance.requestInput}"/>
				<bean:message key="interests.12"/>
			</html:link>
		</c:when>
		<c:otherwise>
			<span><bean:message key="interests.12"/></span>
		</c:otherwise>
	</c:choose>
	<c:if test="${paginatorInstance.numPages > 1}">
		<c:forEach var="page" begin="0" end="${paginatorInstance.numPages-1}">
			<html:link styleClass="paginatorPageId" action="${paginatorAction}">
				<html:param name="pageId" value="${page}"/>
			 	<html:param name="tileId" value="${paginatorTile}"/>
			 	<html:param name="${paginatorInstance.requestInputName}" value="${paginatorInstance.requestInput}"/>
				<c:choose>
					<c:when test="${page == paginatorInstance.requestedPage}">
						<u>${page}</u>
					</c:when>
					<c:otherwise>
						${page}
					</c:otherwise>
				</c:choose>
			</html:link>
		</c:forEach>
	</c:if>
	<c:choose>
		<c:when test="${paginatorInstance.hasNextPage}">
			<html:link styleClass="paginatorPageNext" action="${paginatorAction}">
				<html:param name="pageId" value="${paginatorInstance.nextPage}"/>
	 			<html:param name="tileId" value="${paginatorTile}"/>
	 			<html:param name="${paginatorInstance.requestInputName}" value="${paginatorInstance.requestInput}"/>
				<bean:message key="interests.13"/>
			</html:link>
		</c:when>
		<c:otherwise>
			<span>
				<bean:message key="interests.13"/>
			</span>
		</c:otherwise>
	</c:choose>
</div>