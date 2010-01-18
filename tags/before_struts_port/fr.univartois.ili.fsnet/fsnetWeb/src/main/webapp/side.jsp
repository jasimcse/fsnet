<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://iliforum.ili.fsnet.com/" prefix="fsnet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <div id="side">
            <div class="boxtop"></div>
            <div class="box">
                <h3>Derniers messages de mes hubs</h3>
                <fsnet:hub var="hubdto">
                    <c:choose>
                        <c:when test="${ hubdto.lastMessage!=null}">
                            <a href="GotoMessage?idTopic=${hubdto.lastMessage.topic.id }">
                                <span class="item">
                                    <span class="sidedate">
                                        <!-- ${hubdto.hub.nomCommunaute} -->
                                        ${svar}
                                        <br />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <strong>
                                        ${svar2 }
                                    </strong><br />
                                    ${hubdto.lastMessage.dateMessage}
                                </span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="GotoTopic?idHub=${hubdto.hub.id }">
                                <span class="item">
                                    <span class="sidedate">
                                        <!-- ${hubdto.hub.nomCommunaute} -->
                                        ${svar}
                                        <br />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                    </span>
                                    <strong>
                                        <em>Aucun message.</em>
                                    </strong><br />
                                </span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                </fsnet:hub>
            </div>
            <div class="boxbottom"></div>
        </div>
