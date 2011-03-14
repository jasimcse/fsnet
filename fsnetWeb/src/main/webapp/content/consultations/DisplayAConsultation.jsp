<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="../../WEB-INF/ili.tld" prefix="ili"%>

<c:if test="${consultation eq null }"><p><bean:message key="consultation.unavailable" /></p></c:if>

<c:if test="${consultation ne null }">
<h3>${consultation.title }</h3>
<ul>
	<li><bean:message key="consultation.creator" /> : <ili:getSocialEntityInfos socialEntity="${consultation.creator }" /></li>
	<c:if test="${consultation.description ne '' }"><li><bean:message key="consultation.description" /> : ${consultation.description }</li></c:if>
	<li><bean:message key="consultation.createdAtDate" /> <bean:write name="consultation" property="creationDate" format="dd/MM/yyyy" />
		<bean:message key="consultation.createdAtHour" /> <bean:write name="consultation" property="creationDate" format="HH:mm" />
	</li>
	<li><bean:message key="consultation.typeConsultation" /> : 
		<c:choose>
			<c:when test="${consultation.type eq 'YES_NO'}"><bean:message key="consultation.typeYesNo" /></c:when>
			<c:when test="${consultation.type eq 'YES_NO_OTHER'}"><bean:message key="consultation.typeYesNoOther" /></c:when>
			<c:when test="${consultation.type eq 'YES_NO_IFNECESSARY'}"><bean:message key="consultation.typeYesNoIfNecessary" /></c:when>
			<c:when test="${consultation.type eq 'PREFERENCE_ORDER'}"><bean:message key="consultation.typePreferenceOrder" /></c:when>
		</c:choose>
	</li>
	<li>
		<bean:message key="consultation.state" /> : 
		<c:choose>
			<c:when test="${consultation.opened }">
				<bean:message key="consultation.opened" />
				<c:if test="${member eq consultation.creator }">
					(<html:link action="/CloseConsultation?id=${consultation.id}"><bean:message key="consultation.close" /></html:link>)
				</c:if>
			</c:when>
			<c:when test="${not consultation.opened }">
				<bean:message key="consultation.closed" />
				<c:if test="${member eq consultation.creator }">
					(<html:link action="/OpenConsultation?id=${consultation.id}"><bean:message key="consultation.open" /></html:link>)
				</c:if>
			</c:when>	
		</c:choose>
		
	</li>
	<c:if test="${consultation.limitChoicesPerParticipant}">
		<li><bean:message key="consultation.limitChoicesPerVoter" /> - min : ${consultation.limitChoicesPerParticipantMin }, max : ${consultation.limitChoicesPerParticipantMax}</li>
	</c:if>
	<c:if test="${consultation.closingAtMaxVoters}">
		<li>
			<bean:message key="consultation.closingAtMaxVoters" /> : ${consultation.maxVoters}
		</li>
	</c:if>
	<c:if test="${consultation.closingAtDate}">
		<li>
			<bean:message key="consultation.deadline" /> : <bean:write name="consultation" property="maxDate" format="dd/MM/yyyy" />
		</li>
	</c:if>
</ul>
<br />
<c:if test="${errorChoicesPerParticipant}"><p><bean:message key="consultation.errorChoicesPerParticipant"/></p></c:if>
<c:if test="${errorPreferenceOrderDistinct}"><p><bean:message key="consultation.errorPreferenceOrderDistinct"/></p></c:if>
<table>
	<tr>
		<td></td>
		<td class="consultationPerticipant"><bean:message key="consultation.voter" /></td>
		<c:forEach var="choice" items="${consultation.choices }">
			<td class="consultationResultChoice">${choice.intituled }</td>
		</c:forEach>
		<c:if test="${consultation.type eq 'YES_NO_OTHER' }"><td class="consultationResultChoice"><bean:message key="consultation.other" /></td></c:if>
		<td class="consultationComment"><bean:message key="consultation.comment" /></td>
	</tr>

	<c:forEach var="vote" items="${consultation.consultationVotes }">
		<c:if test="${allowedToShowResults or vote.voter eq member}">
			<tr>
			<td><c:if test="${consultation.opened and member.id eq vote.voter.id }">
				<html:link action="/DeleteVoteConsultation?consultation=${consultation.id}&amp;vote=${vote.id}">
					<html:img src="images/mini-delete.png" altKey="consultation.delete" />
				</html:link>
			</c:if></td>
			<td class="consultationPerticipant"><ili:getSocialEntityInfos socialEntity="${vote.voter }" /></td>
			<c:forEach var="choice" items="${consultation.choices }">
				<c:choose>
					<c:when test="${consultation.type eq 'PREFERENCE_ORDER'}">
						<c:forEach var="choiceVote" items="${vote.choices }">
							<c:if test="${choice.id eq choiceVote.choice.id }">
								<td class="consultationPreferenceOrder">${choiceVote.preferenceOrder}</td>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:set var="isVoted" value="false"/>
						<c:set var="isIfNecessary" value="false"/>
						<c:forEach var="choiceVote" items="${vote.choices }">
							<c:if test="${choice.id eq choiceVote.choice.id }">
								<c:set var="isVoted" value="true"/>
								<c:if test="${choiceVote.ifNecessary }"><c:set var="isIfNecessary" value="true"/></c:if>
							</c:if>
						</c:forEach>
						<td <c:if test="${isVoted and not isIfNecessary}">class="consultationIsVoted"</c:if>
						<c:if test="${isIfNecessary}">class="consultationIsIfNecessary"</c:if>
						<c:if test="${not isVoted}">class="consultationIsNotVoted"</c:if> /></td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${consultation.type eq 'YES_NO_OTHER' }"><td class="consultationOther">${vote.other}</td></c:if>
			<td class="consultationComment">${vote.comment}</td>
			</tr>
		</c:if>
	</c:forEach>
	<c:if test="${allowedToShowResults}">
		<tr>
			<td colspan="2"></td>
			<c:choose>
				<c:when test="${consultation.type eq 'PREFERENCE_ORDER' }">
					<ili:consultationResults consultation="${consultation}" number="number">
						<td class="${number eq 1?'consultationResultMax':'consultationResult' }">${number}</td>
					</ili:consultationResults>
				</c:when>
				<c:otherwise>
					<ili:consultationResults consultation="${consultation}" number="number" percent="percent" maximum="max">
						<td class="${max?'consultationResultMax':'consultationResult' }">${number}<br />${percent }%</td>
					</ili:consultationResults>
				</c:otherwise>
			</c:choose>
		<tr>
	</c:if>
	<c:if test="${allowedToVote }">
	<html:form action="/VoteConsultation" method="post" styleId="voteForm">
		<tr class="consultationVote">
			<td colspan="2"></td>
			<c:forEach var="choice" items="${consultation.choices }">
				<td class="consultationFormChoices">
					<c:choose>
						<c:when test="${consultation.type eq 'YES_NO_IFNECESSARY' }">
							<html:select property="voteChoice">
								<html:option value="no${choice.id}"><bean:message key="consultation.choiceNo" /></html:option>
								<html:option value="yes${choice.id}"><bean:message key="consultation.choiceYes" /></html:option>
								<html:option value="ifNecessary${choice.id}"><bean:message key="consultation.choiceIfNecessary" /></html:option>
							</html:select>
						</c:when>
						<c:when test="${consultation.type eq 'PREFERENCE_ORDER'}">
							<html:select property="voteChoice">
								<c:forEach var="index" begin="1" end="${fn:length(consultation.choices) }">
									<html:option value="${choice.id}_${index}">${index }</html:option>
								</c:forEach>
							</html:select>
						</c:when>
						<c:otherwise>
							<html:multibox property="voteChoice" value="${choice.id}" />
						</c:otherwise>
					</c:choose>
				</td>
			</c:forEach>
			<c:if test="${consultation.type eq 'YES_NO_OTHER' }"><td><html:text property="voteOther" styleId="voteOther"  />
			<div class="consultationAutoCompleteList" id="autoCompleteList"><jsp:include page="autocompleteOtherChoice.jsp" /></div></td></c:if>
			<td><html:text property="voteComment"/></td>
			
			<html:hidden property="id" value="${consultation.id }"/>
			<td><html:submit styleClass="button"><bean:message key="consultation.vote" /></html:submit></td>
		</tr>
	</html:form>
	</c:if>
</table>

<c:if test="${ allowedToShowResults and consultation.type ne 'PREFERENCE_ORDER' }">
	<h3><bean:message key="consultation.histogramme" /></h3>
	
	<div>
		<ili:consultationResults consultation="${consultation}" percent="percent" number="number" choice="choice" histogram="yes">
		<span class="consultationHistoPercent">${choice} ${percent}% (${number})</span>
			<div class="consultationHistoStick" style="width:${percent}%;">
				
			</div>
		</ili:consultationResults>
	</div>
</c:if>

</c:if>

<script type="text/javascript">
$(function() 
{
	$("#voteOther").attr("autocomplete","off");
	$("#voteOther").keyup(function(e){
		var datas = $("#voteForm").serialize();
		$.ajax({
	         type: 'POST',      // envoi des donn�es en POST
	         url: 'AutocompleteOther.do',    
	         data: datas,     // s�lection des champs � envoyer
	         success: function(data) { 
	        	$("#autoCompleteList").html(data);
	        	$(".autoCompleteListMember").click(function(e){
	        		$("#voteOther").val($(this).text());
	        		$("#autoCompleteList").html("");
	        	});
	        	$("body").click(function(){
	        		$("#autoCompleteList").html("");
	        	});
	         }
	    });
	});	
});
</script>