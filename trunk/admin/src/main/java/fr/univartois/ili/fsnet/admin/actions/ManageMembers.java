package fr.univartois.ili.fsnet.admin.actions;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.RollbackException;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.action.DynaActionForm;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.util.MessageResources;

import fr.univartois.ili.fsnet.commons.mail.FSNetConfiguration;
import fr.univartois.ili.fsnet.commons.mail.FSNetMailer;
import fr.univartois.ili.fsnet.commons.mail.Mail;
import fr.univartois.ili.fsnet.commons.pagination.Paginator;
import fr.univartois.ili.fsnet.commons.security.Encryption;
import fr.univartois.ili.fsnet.commons.utils.DateUtils;
import fr.univartois.ili.fsnet.entities.Address;
import fr.univartois.ili.fsnet.entities.Interest;
import fr.univartois.ili.fsnet.entities.SocialEntity;
import fr.univartois.ili.fsnet.facade.InterestFacade;
import fr.univartois.ili.fsnet.facade.SocialEntityFacade;

/**
 * Execute CRUD Actions (and more) for the entity member
 * 
 * @author Audrey Ruellan and Cerelia Besnainou
 * @author Mehdi Benzaghar
 */
public class ManageMembers extends MappingDispatchAction implements CrudAction {

	private static EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("fsnetjpa");
	private static final Logger logger = Logger.getAnonymousLogger();

	@Override
	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		DynaActionForm dynaForm = (DynaActionForm) form; // NOSONAR
		String name = (String) dynaForm.get("name");
		dynaForm.set("name", "");
		String firstName = (String) dynaForm.get("firstName");
		dynaForm.set("firstName", "");
		String mail = (String) dynaForm.get("email");
		dynaForm.set("email", "");
		String personalizedMessage = (String) dynaForm.get("message");
		dynaForm.set("message", "");
		String inputPassword = (String) dynaForm.get("password");

		EntityManager em = factory.createEntityManager();

		SocialEntityFacade facadeSE = new SocialEntityFacade(em);
		SocialEntity socialEntity = facadeSE.createSocialEntity(name,
				firstName, mail);
		try {
			String definedPassword = null;
			String encryptedPassword = null;
			if (inputPassword == null || "".equals(inputPassword)) {
				definedPassword = Encryption.generateRandomPassword();
				logger.info("#### Generated Password : " + definedPassword);
				encryptedPassword = Encryption
						.getEncodedPassword(definedPassword);
			} else {
				definedPassword = inputPassword;
				logger.info("#### Defined Password : " + inputPassword);
				encryptedPassword = Encryption
						.getEncodedPassword(inputPassword);
			}
			socialEntity.setPassword(encryptedPassword);
			em.getTransaction().begin();
			em.persist(socialEntity);
			em.getTransaction().commit();

			Locale currentLocale = request.getLocale();
			sendConfirmationMail(socialEntity, definedPassword,
					personalizedMessage, currentLocale);
		} catch (RollbackException e) {
			ActionErrors errors = new ActionErrors();
			errors.add("email", new ActionMessage("members.user.exists"));
			saveErrors(request, errors);
		} catch (Exception e) {
			ActionErrors errors = new ActionErrors();
			errors.add("email", new ActionMessage("members.error.on.create"));
			saveErrors(request, errors);
		}
		em.close();

		dynaForm.set("name", "");
		dynaForm.set("firstName", "");
		dynaForm.set("email", "");

		return mapping.findForward("success");
	}

	/**
	 * 
	 * Same as create but for multiple entity. Create multiple
	 * {@link SocialEntity} and persist them in database. Format : one entity
	 * per line using the following pattern : name/firstname/email
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @author stephane Gronowski
	 */
	public ActionForward createMultiple(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		DynaActionForm dynaForm = (DynaActionForm) form; // NOSONAR

		String formInput = (String) dynaForm.get("multipleMember");
		dynaForm.set("multipleMember", "");
		String personalizedMessage = (String) dynaForm.get("message");
		dynaForm.set("message", "");

		EntityManager em = factory.createEntityManager();
		SocialEntityFacade facadeSE = new SocialEntityFacade(em);

		String[] formSocialEntities = formInput.split("\n");
		Map<SocialEntity, String> socialEntities = new HashMap<SocialEntity, String>();

		em.getTransaction().begin();

		for (String formSocialEntitie : formSocialEntities) {
			formSocialEntitie = formSocialEntitie.replaceAll("\r", "");
			String[] socialEntitieInput = formSocialEntitie.split("/");

			SocialEntity socialEntity = facadeSE.createSocialEntity(
					socialEntitieInput[0], socialEntitieInput[1],
					socialEntitieInput[2]);

			String definedPassword = Encryption.generateRandomPassword();
			logger.info("#### Defined Password : " + definedPassword);
			String encryptedPassword = Encryption
					.getEncodedPassword(definedPassword);
			socialEntity.setPassword(encryptedPassword);

			socialEntities.put(socialEntity, definedPassword);
			em.persist(socialEntity);
		}

		try {
			em.getTransaction().commit();
		}
		// I'm not really sure about the exception, so I took the same as in the
		// create methode
		catch (RollbackException e) {
			e.printStackTrace();
			ActionErrors errors = new ActionErrors();
			errors.add("email", new ActionMessage("members.user.exists"));
			saveErrors(request, errors);
			return mapping.getInputForward();
		} catch (Exception e) {
			e.printStackTrace();
			ActionErrors errors = new ActionErrors();
			errors.add("email", new ActionMessage("members.error.on.create"));
			saveErrors(request, errors);
			return mapping.getInputForward();
		}

		em.close();

		Locale currentLocale = request.getLocale();
		for (Entry<SocialEntity, String> entry : socialEntities.entrySet()) {
			try {
				sendConfirmationMail(entry.getKey(), entry.getValue(),
						personalizedMessage, currentLocale);
			}
			// I'm not really sure about the exception, so I took the same as in
			// the create methode
			catch (RollbackException e) {
				e.printStackTrace();
				ActionErrors errors = new ActionErrors();
				errors.add("email", new ActionMessage("members.user.exists"));
				saveErrors(request, errors);
			} catch (Exception e) {
				e.printStackTrace();
				ActionErrors errors = new ActionErrors();
				errors.add("email",
						new ActionMessage("members.error.on.create"));
				saveErrors(request, errors);
			}

		}
		return mapping.findForward("success");
	}

	/**
	 * Send mails to a list of recipient.
	 * 
	 * @param socialEntity
	 *            the new EntiteSociale
	 * @param password
	 *            the password of the {@link SocialEntity}
	 * @param personalizedMessage
	 *            message that will be send to the person to inform it that it
	 *            has been registered
	 * @param locale
	 *            the current {@link Locale}
	 * @return true if success false if fail
	 * 
	 * @author Mathieu Boniface < mat.boniface {At} gmail.com >
	 * @author stephane Gronowski
	 */
	private void sendConfirmationMail(SocialEntity socialEntity,
			String password, String personalizedMessage, Locale locale) {
		FSNetConfiguration conf = FSNetConfiguration.getInstance();
		String fsnetAddress = conf.getFSNetConfiguration().getProperty(
				FSNetConfiguration.FSNET_WEB_ADDRESS_KEY);
		String message;

		if (personalizedMessage != null && !personalizedMessage.isEmpty())
			message = createPersonalizedMessage(fsnetAddress, password,
					personalizedMessage, locale);
		else
			message = createMessageRegistration(socialEntity.getName(),
					socialEntity.getFirstName(), fsnetAddress, password, locale);
		// send a mail
		FSNetMailer mailer = FSNetMailer.getInstance();
		Mail mail = mailer.createMail();

		MessageResources bundle = MessageResources
				.getMessageResources("FSneti18n");

		mail.setSubject(bundle.getMessage(locale,
				"members.welcomeMessage.subject"));
		mail.addRecipient(socialEntity.getEmail());
		mail.setContent(message);

		mailer.sendMail(mail);
	}

	/**
	 * Method that creates an personalized welcome message to FSNet.
	 * 
	 * @param addressFsnet
	 *            url of the FSnet application
	 * @param password
	 *            the password of the {@link SocialEntity}
	 * @param personalizedMessage
	 *            message that will be send to the person to inform it that it
	 *            has been registered
	 * @param locale
	 *            the current {@link Locale}
	 * @return the message .
	 * @author stephane Gronowski
	 */
	private String createPersonalizedMessage(String addressFsnet,
			String password, String personalizedMessage, Locale locale) {

		MessageResources bundle = MessageResources
				.getMessageResources("FSneti18n");
		StringBuilder message = new StringBuilder();

		message.append(personalizedMessage);
		message.append(bundle.getMessage(locale,
				"members.welcomeMessage.footer"));
		message.append(addressFsnet);
		message.append(" .<br/><br/>");

		message.append(
				bundle.getMessage(locale,
						"members.welcomeMessage.passwordBegin")).append("<em>");
		message.append(password);
		message.append("</em><br/><br/>")
				.append(bundle.getMessage(locale,
						"members.welcomeMessage.passwordEnd"));
		return message.toString();
	}

	/**
	 * Method that creates an welcome message to FSNet.
	 * 
	 * @param nom
	 *            the name of the {@link SocialEntity}
	 * @param prenom
	 *            the first name of the {@link SocialEntity}
	 * @param addressFsnet
	 *            url of the FSnet application
	 * @param password
	 *            the password of the {@link SocialEntity}
	 * @param locale
	 *            the current {@link Locale}
	 * @return the message .
	 */
	private String createMessageRegistration(String nom, String prenom,
			String addressFsnet, String password, Locale locale) {

		MessageResources bundle = MessageResources
				.getMessageResources("FSneti18n");

		StringBuilder message = new StringBuilder();
		message.append(
				bundle.getMessage(locale, "members.welcomeMessage.welcome"))
				.append(nom).append(" ").append(prenom);
		message.append(",<br/><br/>");
		message.append(bundle.getMessage(locale, "members.welcomeMessage.main"))
				.append("<br/><br/>");
		message.append(bundle.getMessage(locale,
				"members.welcomeMessage.footer"));
		message.append(addressFsnet);
		message.append(" .<br/><br/>");

		message.append(
				bundle.getMessage(locale,
						"members.welcomeMessage.passwordBegin")).append("<em>");
		message.append(password);
		message.append("</em><br/><br/>")
				.append(bundle.getMessage(locale,
						"members.welcomeMessage.passwordEnd"));
		return message.toString();
	}

	@Override
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		throw new UnsupportedOperationException();
	}

	public ActionForward switchState(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String entitySelected = request.getParameter("entitySelected");
		EntityManager em = factory.createEntityManager();
		SocialEntityFacade socialEntityFacade = new SocialEntityFacade(em);
		em.getTransaction().begin();
		int socialEntityId = Integer.parseInt(entitySelected);
		socialEntityFacade.switchState(socialEntityId);
		em.getTransaction().commit();
		em.close();
		return mapping.findForward("success");
	}

	@Override
	public ActionForward display(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		DynaActionForm dynaForm = (DynaActionForm) form; // NOSONAR
		EntityManager entityManager = factory.createEntityManager();
		SocialEntityFacade socialEntityFacade = new SocialEntityFacade(
				entityManager);

		Integer idMember = Integer.valueOf(request.getParameter("idMember"));

		SocialEntity member = socialEntityFacade.getSocialEntity(idMember);

		entityManager.close();
		String adress = "";
		String city = "";
		if (member.getAddress() != null) {
			if (member.getAddress().getAddress() != null)
				adress = member.getAddress().getAddress();
			if (member.getAddress().getCity() != null)
				city = member.getAddress().getCity();
		}
		dynaForm.set("address", adress);
		dynaForm.set("city", city);
		dynaForm.set("phone", member.getPhone());
		dynaForm.set("sexe", member.getSex());
		dynaForm.set("job", member.getProfession());
		dynaForm.set("birthDay", member.getBirthDate());
		dynaForm.set("name", member.getName());
		dynaForm.set("email", member.getEmail());
		dynaForm.set("firstName", member.getFirstName());
		dynaForm.set("id", member.getId());

		Paginator<Interest> paginator = new Paginator<Interest>(
				member.getInterests(), request, "interestsMember", "idMember");

		request.setAttribute("interestsMemberPaginator", paginator);
		request.setAttribute("id", member.getId());

		return mapping.findForward("success");
	}

	@Override
	public ActionForward modify(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		EntityManager entityManager = factory.createEntityManager();
		DynaActionForm formSocialENtity = (DynaActionForm) form;// NOSONAR
		String name = (String) formSocialENtity.get("name");
		String firstName = (String) formSocialENtity.get("firstName");
		String email = (String) formSocialENtity.get("email");
		String job = (String) formSocialENtity.get("job");
		String address = (String) formSocialENtity.get("address");
		String city = (String) formSocialENtity.get("city");
		String phone = (String) formSocialENtity.get("phone");
		String sexe = (String) formSocialENtity.get("sexe");
		Date birthDay = null;
		try {
			birthDay = DateUtils.format((String) formSocialENtity
					.get("formatBirthDay"));
			formSocialENtity.set("birthDay", birthDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Integer idMember = (Integer) formSocialENtity.get("id");

		SocialEntityFacade facadeSE = new SocialEntityFacade(entityManager);

		SocialEntity member = facadeSE.getSocialEntity(idMember);
		member.setFisrtname(firstName);
		member.setName(name);
		member.setEmail(email);
		member.setAddress(new Address(address, city));
		member.setBirthDate(birthDay);
		member.setPhone(phone);
		member.setSex(sexe);
		member.setProfession(job);
		entityManager.getTransaction().begin();
		entityManager.merge(member);
		entityManager.getTransaction().commit();
		request.setAttribute("member", member);

		ActionMessages errors = new ActionErrors();
		errors.add("message", new ActionMessage("member.success.update"));
		saveErrors(request, errors);
		return mapping.findForward("success");
	}

	@Override
	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		TypedQuery<SocialEntity> query = null;
		Set<SocialEntity> resultOthers = null;

		if (form != null) {
			DynaActionForm dynaForm = (DynaActionForm) form; // NOSONAR
			String searchText = (String) dynaForm.get("searchText");
			SocialEntityFacade socialEntityFacade = new SocialEntityFacade(em);
			resultOthers = socialEntityFacade.searchSocialEntity(searchText);
			em.getTransaction().commit();
			em.close();
			if (resultOthers != null) {
				List<SocialEntity> resultOthersList = new ArrayList<SocialEntity>(
						resultOthers);
				Paginator<SocialEntity> paginator = new Paginator<SocialEntity>(
						resultOthersList, request, "membersList");
				request.setAttribute("membersListPaginator", paginator);
			} else
				request.setAttribute("membersListPaginator", null);
		} else {
			query = em.createQuery("SELECT es FROM SocialEntity es",
					SocialEntity.class);
			List<SocialEntity> resultOthersList = query.getResultList();
			em.getTransaction().commit();
			em.close();

			Paginator<SocialEntity> paginator = new Paginator<SocialEntity>(
					resultOthersList, request, "membersList");

			request.setAttribute("membersListPaginator", paginator);
		}

		return mapping.findForward("success");
	}

	/**
	 * delete interest member by admin
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 */
	public ActionForward deleteInterestMember(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		Integer interestSelected = Integer.valueOf(request
				.getParameter("interestSelected"));
		Integer idSocialEntity = Integer.valueOf(request
				.getParameter("idMember"));

		EntityManager em = factory.createEntityManager();

		logger.info("delete interest social entity");
		SocialEntityFacade ise = new SocialEntityFacade(em);
		InterestFacade interestFacade = new InterestFacade(em);
		em.getTransaction().begin();
		ise.removeInterest(interestFacade.getInterest(interestSelected),
				ise.getSocialEntity(idSocialEntity));
		em.getTransaction().commit();
		em.close();

		return mapping.findForward("success");
	}
}
