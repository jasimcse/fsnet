$(function() {

	// init
	displayExpNone();
	displayDegreeNone();
	displayTrainingNone();
	displayHobbieNone();
	displayLangNone();
	
	var i = 0;
	var j = 0;
	var k = 0;
	var z = 0;
	var f = 0;
	
	var tabExp = new Array();

	// experiences
	$(".addExp").click(function() {
		$(".corp_experience").css("display", "inline");
		displayDegreeNone();
		displayTrainingNone();
		displayHobbieNone();
		displayLangNone();

		displayErrorExpNone();

		$(".addDiplTable").css("display", "inline");
		$(".addFormTable").css("display", "inline");
		$(".addLoisirTable").css("display", "inline");
		$(".addLangueTable").css("display", "inline");
		$(".addExpTable").css("display", "none");
	});
	
	$(".SaveExp")
			.click(
					function() {
						displayErrorExpNone();
						
						var erreur = 0;
						if ($("#cvExpJob").val() == '') {
							$(".CvExpJobError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvExpFirmName").val() == '') {
							$(".CvExpFirmNameError").css("display", "inline");
							erreur = 1;
						}

						if ($("#cvExpDomain").val() == '') {
							$(".CvExpDomainError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvExpBeginDate").val() == '') {
							$(".CvExpBeginDateError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvExpEndDate").val() == '') {
							$(".CvExpEndDateError").css("display", "inline");
							erreur = 1;
						}

						if (erreur == 0) {
							tabExp[i] = i;
							var recapExp = "<strong>" + $("#cvExpJob").val()
									+ "</strong><p>"
									+ $("#cvExpFirmName").val() + "</p><p>"
									+ $("#cvExpDomain").val() + "</p><p>"
									+ $("#cvExpCountry").val() + "</p><p>"
									+ $("#cvExpCity").val() + "</p><p>"
									+ $("#cvExpBeginDate").val() + "</p><p> "
									+ $("#cvExpEndDate").val() + "</p>";

							var inputRecap = '<div id="ExpInput" style="display:none;"><input type="hidden" id="CVPostehidden" name="cvExpJob'
									+ i
									+ '" value="'
									+ $("#cvExpJob").val()
									+ '" />'
									+ '<input type="hidden" name="cvExpFirmName'
									+ i
									+ '" value="'
									+ $("#cvExpFirmName").val()
									+ '" />'
									+ '<input type="hidden" name="cvExpCountry'
									+ i
									+ '" value="'
									+ $("#cvExpCountry").val()
									+ '" />'
									+ '<input type="hidden" name="cvExpCity'
									+ i
									+ '" value="'
									+ $("#cvExpCity").val()
									+ '" />'
									+ '<input type="hidden" name="cvExpBeginDate'
									+ i
									+ '" value="'
									+ $("#cvExpBeginDate").val()
									+ '" />'
									+ '<input type="hidden" name="cvExpDomain'
									+ i
									+ '" value="'
									+ $("#cvExpDomain").val()
									+ '" />'
									+ '<input type="hidden" name="cvExpEndDate'
									+ i
									+ '" value="'
									+ $("#cvExpEndDate").val() + '" /></div>';
							
							$('.listeExperience').append(
									'<li class="liste" id="experience_' + i
											+ '">' + recapExp + '</li>');
							$('#experience_' + i).append(inputRecap);
							
							$("#cvExpJob").val('');
							$("#cvExpFirmName").val('');
							$("#CvSecteur").val('');
							$("#cvExpCountry").val('');
							$("#cvExpCity").val('');
							$("#cvExpBeginDate").val('');
							$("#cvExpEndDate").val('');

							displayExpNone();
							$(".addExpTable").css("display", "inline");
							
							i++;
						}

					});
	
	$(".annuleExp").click(function() {
		$(".corp_experience").css("display", "none");
		$(".addExpTable").css("display", "inline");
	});

	$(".addDip").click(function() {
		displayExpNone();
		displayTrainingNone();
		displayHobbieNone();
		displayLangNone();
		$(".corp_diplome").css("display", "inline");

		displayErrorDegreeNone();

		$(".addFormTable").css("display", "inline");
		$(".addLoisirTable").css("display", "inline");
		$(".addLangueTable").css("display", "inline");
		$(".addExpTable").css("display", "inline");
		$(".addDiplTable").css("display", "none");
	});
	
	$(".SaveDip")
			.click(
					function() {
						displayErrorDegreeNone();
						
						var erreur = 0;
						if ($("#cvDegreeName").val() == '') {
							$(".CvDegreeNameError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvDegreeDomain").val() == '') {
							$(".CvDegreeDomainError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvDegreeBeginDate").val() == '') {
							$(".CvDegreeBeginDateError").css("display", "inline");
							erreur = 1;
						}

						if ($("#cvDegreeEndDate").val() == '') {
							$(".CvDegreeEndDateError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvDegreeSchool").val() == '') {
							$(".CvDegreeSchoolError").css("display", "inline");
							erreur = 1;
						}

						if (erreur == 0) {
							var recapExp = "<strong>"
									+ $("#cvDegreeName").val() + "</strong><p>"
									+ $("#cvDegreeDomain").val() + "</p><p>"
									+ $("#cvDegreeSchool").val() + "</p><p>"
									+ $("#cvDegreeCountry").val() + "</p><p>"
									+ $("#cvDegreeCity").val()
									+ "</p><p> Date debut :"
									+ $("#cvDegreeBeginDate").val()
									+ "</p><p> date fin "
									+ $("#cvDegreeEndDate").val() + "</p>";
							
							var inputRecap = '<div id="DipInput" style="display:none;"><input type="hidden" name="cvDegreeName'
									+ j
									+ '" value="'
									+ $("#cvDegreeName").val()
									+ '" />'
									+ '<input type="hidden" name="cvDegreeDomain'
									+ j
									+ '" value="'
									+ $("#cvDegreeDomain").val()
									+ '" />'
									+ '<input type="hidden" name="cvDegreeSchool'
									+ j
									+ '" value="'
									+ $("#cvDegreeSchool").val()
									+ '" />'
									+ '<input type="hidden" name="cvDegreeCountry'
									+ j
									+ '" value="'
									+ $("#cvDegreeCountry").val()
									+ '" />'
									+ '<input type="hidden" name="cvDegreeCity'
									+ j
									+ '" value="'
									+ $("#cvDegreeCity").val()
									+ '" />'
									+ '<input type="hidden" name="cvDegreeBeginDate'
									+ j
									+ '" value="'
									+ $("#cvDegreeBeginDate").val()
									+ '" />'
									+ '<input type="hidden" name="cvDegreeEndDate'
									+ j
									+ '" value="'
									+ $("#cvDegreeEndDate").val()
									+ '" /></div>';
							
							$('.listeDiplome').append(
									'<li class="liste" id="diplome_' + j + '">'
											+ recapExp + '</li>');
							$('#diplome_' + j).append(inputRecap);

							$("#cvDegreeName").val('');
							$("#cvDegreeDomain").val('');
							$("#cvDegreeSchool").val('');
							$("#cvDegreeCity").val('');
							$("#cvDegreeCountry").val('');
							$("#cvDegreeBeginDate").val('');
							$("#cvDegreeEndDate").val('');
							
							displayDegreeNone();
							$(".addDiplTable").css("display", "inline");
						}
					});
	
	$(".annuleDip").click(function() {
		$(".corp_diplome").css("display", "none");
		$(".addDiplTable").css("display", "inline");
	});
	
	// formation
	$(".addForm").click(function() {
		displayExpNone();
		displayDegreeNone();
		displayHobbieNone();
		displayLangNone();
		$(".corp_formation").css("display", "inline");
		
		displayErrorTrainingNone();

		$(".addLoisirTable").css("display", "inline");
		$(".addLangueTable").css("display", "inline");
		$(".addExpTable").css("display", "inline");
		$(".addDiplTable").css("display", "inline");
		$(".addFormTable").css("display", "none");
	});
	
	$(".SaveForm")
			.click(
					function() {
						displayErrorTrainingNone();

						var erreur = 0;

						if ($("#cvTrainingInstitution").val() == '') {
							$(".CvTrainingInstitutionError").css("display",
									"inline");
							erreur = 1;
						}
						if ($("#cvTrainingObtainingDate").val() == '') {
							$(".CvTrainingObtainingDateError").css("display", "inline");
							erreur = 1;
						}
						if ($("#cvTrainingName").val() == '') {
							$(".CvTrainingNameError").css("display", "inline");
							erreur = 1;
						}

						if (erreur == 0) {
							var recapExp = "<strong>"
									+ $("#cvTrainingName").val()
									+ "</strong><p>"
									+ $("#cvTrainingInstitution").val()
									+ "</p><p>" + $("#cvTrainingCountry").val()
									+ "-" + $("#cvTrainingCity").val()
									+ "</p><p> "
									+ $("#cvTrainingObtainingDate").val();
							var inputRecap = '<div id="FormInput" style="display:none;"><input type="hidden" name="cvTrainingName'
									+ f
									+ '" value="'
									+ $("#cvTrainingName").val()
									+ '" />'
									+ '<input type="hidden" name="cvTrainingInstitution'
									+ f
									+ '" value="'
									+ $("#cvTrainingInstitution").val()
									+ '" />'
									+ '<input type="hidden" name="cvTrainingCountry'
									+ f
									+ '" value="'
									+ $("#cvTrainingCountry").val()
									+ '" />'
									+ '<input type="hidden" name="cvTrainingCity'
									+ f
									+ '" value="'
									+ $("#cvTrainingCity").val()
									+ '" />'
									+ '<input type="hidden" name="cvTrainingObtainingDate'
									+ f
									+ '" value="'
									+ $("#cvTrainingObtainingDate").val()
									+ '" /></div>';

							$('.listeFormation').append(
									'<li class="liste" id="formation_' + f
											+ '">' + recapExp + '</li>');
							$('#formation_' + f).append(inputRecap);

							$("#cvTrainingName").val('');
							$("#cvTrainingInstitution").val('');
							$("#cvTrainingCountry").val('');
							$("#cvTrainingCity").val('');
							$("#cvTrainingObtainingDate").val('');

							$(".addFormTable").css("display", "inline");
							displayTrainingNone();

							f++;
						}
					});
	$(".annuleForm").click(function() {
		$(".corp_formation").css("display", "none");
		$(".addFormTable").css("display", "inline");
	});

	// loisirs
	$(".addLoisir").click(function() {
		$(".corp_loisir").css("display", "inline");
		displayExpNone();
		displayDegreeNone();
		displayTrainingNone();
		displayLangNone();

		displayErrorHobbyNone();
		
		$(".addLangueTable").css("display", "inline");
		$(".addExpTable").css("display", "inline");
		$(".addDiplTable").css("display", "inline");
		$(".addFormTable").css("display", "inline");
		$(".addLoisirTable").css("display", "none");
	});
	
	$(".SaveLoisir")
			.click(
					function() {
						displayErrorHobbyNone();

						var erreur = 0;
						if ($("#cvHobbyName").val() == '') {

							$(".CvHobbyNameError").css("display", "inline");
							erreur = 1;

						}

						if (erreur == 0) {
							var recapExp = "<strong>" + $("#cvHobbyName").val()
									+ "</strong><br/>";
							
							var inputRecap = '<div id="loisirInput" style="display:none;"><input type="hidden" name="cvHobbyName'
									+ k
									+ '" value="'
									+ $("#cvHobbyName").val()
									+ '" /></div>';

							$('.listeLoisir').append(
									'<li class="liste" id="loisir_' + k + '">'
											+ recapExp + '</li>');
							$('#loisir_' + k).append(inputRecap);
							
							$("#CvNomLoisir").val('');

							$(".addLoisirTable").css("display", "inline");
							displayHobbieNone();

							k++;
						}

					});
	$(".annuleLoisir").click(function() {
		$(".corp_loisir").css("display", "none");
		$(".addLoisirTable").css("display", "inline");
	});

	// langues
	$(".addLangue").click(function() {
		displayExpNone();
		displayDegreeNone();
		displayTrainingNone();
		displayHobbieNone();
		$(".corp_langue").css("display", "inline");

		displayErrorLangNone();
		
		$(".addExpTable").css("display", "inline");
		$(".addDiplTable").css("display", "inline");
		$(".addFormTable").css("display", "inline");
		$(".addLoisirTable").css("display", "inline");
		$(".addLangueTable").css("display", "none");
	});

	$(".SaveLangue")
			.click(
					function() {
						displayErrorLangNone();
						$(".CvLangNameError").css("display", "none");
						
						var erreur = 0;
						if ($("#cvLangName").val() == '') {
							$(".CvLangNameError").css("display", "inline");
							erreur = 1;
						}
						if (erreur == 0) {
							var recapExp = "<table><tr><td><strong>"
									+ $("#cvLangName").val()
									+ "</strong></td><td>"
									+ $("#cvLangLevel").val()
									+ "</td></tr></table>";
							
							var inputRecap = '<div id="LangueInput" style="display:none;"><input type="hidden" name="cvLangName'
									+ z
									+ '" value="'
									+ $("#cvLangName").val()
									+ '" />'
									+ '<input type="hidden" name="cvLangLevel'
									+ z
									+ '" value="'
									+ $("#cvLangLevel").val()
									+ '" /></div>';
							
							$('.listeLangues').append(
									'<li class="liste" id="Langues_' + z + '">'
											+ recapExp + '</li>');
							$('#Langues_' + z).append(inputRecap);
							
							$("#cvLangName").val('');

							displayLangNone();
							$(".addLangueTable").css("display", "inline");

							z++;
						}

					});

	$(".annuleLangue").click(function() {
		$(".corp_langue").css("display", "none");
		$(".addLangueTable").css("display", "inline");
	});

	
	$(".Edit").click(function() {

		$(".corp_experience").css("display", "inline");
		$('#experience_' + 0).css("display", "none");

	});

	
	$("#envoi").click(
			function() {
				var nbExp = '<input type="hidden" name="nbexp" value="' + i
						+ '" />';
				var nbForm = '<input type="hidden" name="nbform" value="' + f
						+ '" />';
				var nblangue = '<input type="hidden" name="nblangue" value="'
						+ k + '" />';
				var nbloisir = '<input type="hidden" name="nbloisir" value="'
						+ z + '" />';
				var nbdip = '<input type="hidden" name="nbdip" value="' + j
						+ '" />';
				$('.listeExperience').append(nbExp);
				$('.listeFormation').append(nbForm);
				$('.listeLangues').append(nblangue);
				$('.listeLoisir').append(nbloisir);
				$('.listeDiplome').append(nbdip);

			});

});

function displayExpNone() {
	$(".corp_experience").css("display", "none");
	$(".CvExpJobError").css("display", "none");
	$(".cvExpFirmNameError").css("display", "none");
	$(".CvExpBeginDateError").css("display", "none");
	$(".CvExpEndDateError").css("display", "none");
	$(".CvExpDomainError").css("display", "none");
}

function displayDegreeNone() {
	$(".corp_diplome").css("display", "none");
	$(".CvDegreeSchoolError").css("display", "none");
	$(".CvDegreeBeginDateError").css("display", "none");
	$(".CvDegreeEndDateError").css("display", "none");
	$(".CvDegreeDomainError").css("display", "none");
	$(".CvDegreeNameError").css("display", "none");
}

function displayTrainingNone() {
	$(".corp_formation").css("display", "none");
	$(".CvTrainingInstitutionError").css("display", "none");
	$(".CvTrainingNameError").css("display", "none");
	$(".CvTrainingObtainingDateError").css("display", "none");
}

function displayHobbieNone() {
	$(".corp_loisir").css("display", "none");
	$(".CvHobbyNameError").css("display", "none");
}

function displayLangNone() {
	$(".corp_langue").css("display", "none");
	$(".CvLangNameError").css("display", "none");
}

function displayErrorExpNone() {
	$(".CvExpJobError").css("display", "none");
	$(".CvExpFirmNameError").css("display", "none");
	$(".CvExpBeginDateError").css("display", "none");
	$(".CvExpEndDateError").css("display", "none");
	$(".CvExpDomainError").css("display", "none");
}

function displayErrorDegreeNone() {
	$(".CvDegreeSchoolError").css("display", "none");
	$(".CvDegreeBeginDateError").css("display", "none");
	$(".CvDegreeEndDateError").css("display", "none");
	$(".CvDegreeDomainError").css("display", "none");
	$(".CvDegreeNameError").css("display", "none");
}

function displayErrorTrainingNone() {
	$(".CvTrainingInstitutionError").css("display", "none");
	$(".CvTrainingNameError").css("display", "none");
	$(".CvTrainingObtainingDateError").css("display", "none");
}

function displayErrorHobbyNone() {
	$(".CvHobbyNameError").css("display", "none");
}

function displayErrorLangNone() {
	$(".CvLangNameError").css("display", "none");
}
