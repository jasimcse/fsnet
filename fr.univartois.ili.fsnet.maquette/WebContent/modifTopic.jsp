<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://iliforum.ili.fsnet.com/" prefix="fsnet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon" type="image/png" href="images/favicon.ico" />
<meta http-equiv="content-type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta name="author" content="Luka Cvrk - www.solucija.com" />
<meta name="description" content="Site Description" />
<meta name="keywords" content="site, keywords" />
<meta name="robots" content="index, follow" />
<link rel="stylesheet" type="text/css" media="screen"
	href="css/style.css" />
<title>FSNet</title>
<script type="text/JavaScript">
	function MM_jumpMenu(targ, selObj, restore) { //v3.0
		eval(targ + ".location='" + selObj.options[selObj.selectedIndex].value
				+ "'");
		if (restore)
			selObj.selectedIndex = 0;
	}
	//
</script>
<style type="text/css">
<!--
.Style1 {
	color: #FF6600
}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="JavaScript" src="maquette.js">
</script>
</head>
<body onload="showMenu();">
<div class="wrap background"><jsp:include page="haut.jsp"></jsp:include>
<a href="hub.jsp">FSNet</a> - <a href="GotoTopic?idHub=${monHub.id}">${monHub.nomCommunaute}</a>
<table width="100%">
	<thead>
		<tr style="text-align: center;background-color: #CCCCCC"">
			<td class="thead">
			<div style="text-align: center">Topic</div>
			</td>
			<td class="thead">
			Createur
			</td>
			<td class="thead">Dernier message</td>
			<td class="thead">Messages</td>
		</tr>
	</thead>
	<fsnet:topic var="topicdto" hub="${monHub}">
		<tbody>
			<tr>
				<td class="alt1active" id="h${topicdto.topic.id}"
					style="text-align: left">
				<table style="padding: 0; border: 0">
					<tbody>
						<tr>
							<td><img
								src="icons/page_01_fichiers/icon_from_jimmac_musichall_cz_272.png"
								alt="" style="width: 48; height: 48; border: 0"
								id="forum_statusicon_${topicdto.topic.id}" /></td>
							<td><img alt=""
								src="Général Java - Forum des développeurs_fichiers/clear.gif"
								style="width: 9; border: 0; height: 1" /></td>
							<td>
							<c:if test="${topicdto.topic.id == monTopic.id}">
								<form action="ModifTopic">
								<input type="text" name="titreTopic" value="${topicdto.topic.sujet}" />
								<input type=submit name="modifier" value="modifier" />
								</form>
							</c:if>
							<c:if test="${topicdto.topic.id != monTopic.id}">
								<div><a href="GotoMessage?idTopic=${topicdto.topic.id}">
								<strong>${topicdto.topic.sujet}</strong></a></div>
							</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				</td>
				<td class="alt2">
					${topicdto.topic.propTopic.nom} ${topicdto.topic.propTopic.prenom}
				</td>
				<td class="alt2"><a
					href="GotoMessage?idTopic=${topicdto.lastMessage.topic.id}">${topicdto.lastMessage.dateMessage} - ${topicdto.lastMessage.propMsg.nom} ${topicdto.lastMessage.propMsg.prenom}</a></td>
				<td class="alt2">${topicdto.nbMessage}</td>
			</tr>
		</tbody>
	</fsnet:topic>
	
</table>
 </div>
<jsp:include page="bas.jsp"></jsp:include>
</body>
</html>