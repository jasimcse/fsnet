package fr.univartois.ili.fsnet.actions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;

import fr.univartois.ili.fsnet.actions.utils.UserUtils;
import fr.univartois.ili.fsnet.commons.utils.DateUtils;
import fr.univartois.ili.fsnet.commons.utils.PersistenceProvider;
import fr.univartois.ili.fsnet.entities.Announcement;
import fr.univartois.ili.fsnet.entities.Interaction;
import fr.univartois.ili.fsnet.entities.InteractionGroups;
import fr.univartois.ili.fsnet.entities.Interest;
import fr.univartois.ili.fsnet.entities.Right;
import fr.univartois.ili.fsnet.entities.SocialEntity;
import fr.univartois.ili.fsnet.entities.SocialGroup;
import fr.univartois.ili.fsnet.facade.AnnouncementFacade;
import fr.univartois.ili.fsnet.facade.InteractionFacade;
import fr.univartois.ili.fsnet.facade.InterestFacade;
import fr.univartois.ili.fsnet.facade.SocialGroupFacade;
import fr.univartois.ili.fsnet.facade.security.UnauthorizedOperationException;
import fr.univartois.ili.fsnet.filter.FilterInteractionByUserGroup;

/**
 * 
 * @author Mehdi Benzaghar <mehdi.benzaghar at gmail.com>
 */
public class ManageAnnounces extends ActionSupport implements
		CrudAction,ServletRequestAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String UNAUTHORIZED_ACTION_NAME = "unauthorized";
	private static final String FAILED_ACTION_NAME = "failed";

	private static final String ANNOUNCE_ID_ATTRIBUTE_NAME = "idAnnounce";
	private static final String ANNOUNCE_EXPIRY_DATE_FORM_FIELD_NAME = "announceExpiryDate";
	private int idAnnounce;
	private String announceTitle;
	private String announceContent;
	private Date announceExpiryDate;
	private String textSearchAnnounce;
	private String[] selectedAnnounces;
	private String[] groupsListRight;
	private String[] selectedInterests;

	private HttpServletRequest request;
	/**
	 * @return to announces view after persisting new announce
	 */
	@Override
	public String create()
			throws Exception {
		EntityManager entityManager = PersistenceProvider.createEntityManager();
		SocialEntity user = UserUtils.getAuthenticatedUser(request,
				entityManager);
		SocialGroupFacade fascade = new SocialGroupFacade(entityManager);
		if (!fascade.isAuthorized(user, Right.ADD_ANNOUNCE)) {
			entityManager.close();
			return SUCCESS;
		}

		try {
			if (groupsListRight.length == 0) {
				request.setAttribute("errorAnnounceRights", true);
				return ERROR;
			}
			
			Announcement createdAnnounce;
			addRightToRequest(request);

			
			if (0 > DateUtils.compareToToday(announceExpiryDate)) {
				AnnouncementFacade announcementFacade = new AnnouncementFacade(
						entityManager);
				entityManager.getTransaction().begin();
				
				List<SocialGroup> listOfGroupAccepted = new ArrayList<SocialGroup>();
				List<InteractionGroups> igList = new ArrayList<InteractionGroups>();
				createdAnnounce = announcementFacade.createAnnouncement(user,
						announceTitle, announceContent, announceExpiryDate, false);
				
				for (String name : groupsListRight) {
					listOfGroupAccepted.add(fascade.findByName(name));
					igList.add(new InteractionGroups(createdAnnounce, fascade.findByName(name)));					
				}								
				createdAnnounce.setInteractionGroups(igList);				
				
				InterestFacade fac = new InterestFacade(entityManager);
				List<Interest> interests = new ArrayList<Interest>();
				int currentId;
				for (currentId = 0; currentId < selectedInterests.length; currentId++) {
					interests.add(fac.getInterest(Integer
							.valueOf(selectedInterests[currentId])));
				}
				InteractionFacade ifacade = new InteractionFacade(entityManager);
				ifacade.addInterests(createdAnnounce, interests);
				entityManager.getTransaction().commit();
				
			} else {
				addFieldError(ANNOUNCE_EXPIRY_DATE_FORM_FIELD_NAME, "date.error.dateBelowDateToday");
				return INPUT;
			}
		} catch (NumberFormatException e) {
			return ERROR;
		} finally {
			entityManager.close();
		}

		return SUCCESS;
	}

	/**
	 * @return to views announce after updating it
	 */
	@Override
	public String modify()
			throws Exception {
		EntityManager entityManager = PersistenceProvider.createEntityManager();

		try {
			
			AnnouncementFacade announcementFacade = new AnnouncementFacade(
					entityManager);
			Announcement announce = announcementFacade
					.getAnnouncement(idAnnounce);
			addRightToRequest(request);
			SocialEntity user = UserUtils.getAuthenticatedUser(request,
					entityManager);

			if (!announce.getCreator().equals(user)) {
				throw new UnauthorizedOperationException("exception.message");
			}

			
			if (0 > DateUtils.compareToToday(announceExpiryDate)) {
				entityManager.getTransaction().begin();
				announcementFacade.modifyAnnouncement(idAnnounce, announceTitle,
						announceContent, announceExpiryDate);
				entityManager.getTransaction().commit();

			} else {
				addFieldError(ANNOUNCE_EXPIRY_DATE_FORM_FIELD_NAME, "date.error.dateBelowDateToday");
				return INPUT;
			}

			request.setAttribute("announce", announce);
			request.setAttribute("owner", true);
		} finally {
			entityManager.close();
		}

		return SUCCESS;
	}

	/**
     *
     */
	@Override
	public String delete()
			throws Exception {
		EntityManager em = PersistenceProvider.createEntityManager();

		try {
			em.getTransaction().begin();

			AnnouncementFacade announcementFacade = new AnnouncementFacade(em);
			Integer idAnnounce = Integer.valueOf(request
					.getParameter(ANNOUNCE_ID_ATTRIBUTE_NAME));
			Announcement announce = announcementFacade
					.getAnnouncement(idAnnounce);
			InteractionFacade interactionFacade = new InteractionFacade(em);
			SocialEntity user = UserUtils.getAuthenticatedUser(request, em);
			addRightToRequest(request);

			if (announce != null) {
				interactionFacade.deleteInteraction(user, announce);
			}

			em.getTransaction().commit();
			
			/*ActionMessages message = new ActionErrors();
			message.add("message", new ActionMessage(
					"announce.message.delete.success"));
			saveMessages(request, message);*/
		} catch (NumberFormatException e) {
			return ERROR;
		} finally {
			em.close();
		}

		return SUCCESS;
	}

	/**
	 * @return list of announce
	 */
	@Override
	public String search()
			throws Exception {
		EntityManager em = PersistenceProvider.createEntityManager();

		em.getTransaction().begin();
		AnnouncementFacade announcementFacade = new AnnouncementFacade(em);

		List<Announcement> listAnnounces = announcementFacade
				.searchAnnouncement(textSearchAnnounce);
		/* filter list announce */
		if (listAnnounces != null && !listAnnounces.isEmpty()) {
			FilterInteractionByUserGroup filter = new FilterInteractionByUserGroup(
					em);
			SocialEntity se = UserUtils.getAuthenticatedUser(request);
			listAnnounces = filter.filterInteraction(se, listAnnounces);
		}

		addRightToRequest(request);

		SocialEntity member = UserUtils.getAuthenticatedUser(request, em);
		List<Announcement> myAnnouncesList = announcementFacade
				.getUserAnnouncements(member);
		InteractionFacade interactionFacade = new InteractionFacade(em);
		List<Integer> unreadInteractionsId = interactionFacade
				.getUnreadInteractionsIdForSocialEntity(member);
		refreshNumNewAnnonces(request, em);
		em.getTransaction().commit();
		em.close();

		request.setAttribute("annoucesList", listAnnounces);
		request.setAttribute("myAnnouncesList", myAnnouncesList);

		request.setAttribute("unreadInteractionsId", unreadInteractionsId);

		return SUCCESS;
	}

	/**
	 * @return announce in request
	 */
	@Override
	public String display()
			throws Exception {
		EntityManager entityManager = PersistenceProvider.createEntityManager();

		try {
			entityManager.getTransaction().begin();
			SocialEntity socialEntity = UserUtils.getAuthenticatedUser(request,
					entityManager);
			Integer idAnnounce = Integer.valueOf(request
					.getParameter(ANNOUNCE_ID_ATTRIBUTE_NAME));
			AnnouncementFacade announcementFacade = new AnnouncementFacade(
					entityManager);
			Announcement announce = announcementFacade
					.getAnnouncement(idAnnounce);
			SocialEntity socialEntityOwner = (SocialEntity) entityManager
					.createQuery(
							"SELECT es FROM SocialEntity es,IN(es.interactions) e WHERE e = :announce")
					.setParameter("announce", announce).getSingleResult();
			addRightToRequest(request);
			
			SocialEntity member = UserUtils.getAuthenticatedUser(request,
					entityManager);
			member.addInteractionRead(announce);
			refreshNumNewAnnonces(request, entityManager);
			entityManager.getTransaction().commit();
			entityManager.close();

			request.setAttribute("announce", announce);
			request.setAttribute("SocialEntity", socialEntityOwner);
			/*servlet.log(socialEntityOwner.toString()
					+ socialEntityOwner.getName());*/
			if (socialEntity.getId() == socialEntityOwner.getId()) {
				request.setAttribute("owner", true);
			}
		} catch (NumberFormatException e) {
			return ERROR;
		}

		return SUCCESS;
	}

	/**
	 * @return announce in request
	 */
	public String displayToModify() throws Exception {
		EntityManager em = PersistenceProvider.createEntityManager();

		try {
			em.getTransaction().begin();
			Integer idAnnounce = Integer.valueOf(request
					.getParameter(ANNOUNCE_ID_ATTRIBUTE_NAME));

			AnnouncementFacade announcementFacade = new AnnouncementFacade(em);
			Announcement announce = announcementFacade
					.getAnnouncement(idAnnounce);
			addRightToRequest(request);
			em.getTransaction().commit();

			/*dynaForm.set(ANNOUNCE_ID_ATTRIBUTE_NAME, announce.getId());
			dynaForm.set(ANNOUNCE_TITLE_FORM_FIELD_NAME, announce.getTitle());
			dynaForm.set(ANNOUNCE_CONTENT_FORM_FIELD_NAME,announce.getContent());
			dynaForm.set(ANNOUNCE_EXPIRY_DATE_FORM_FIELD_NAME,
					DateUtils.renderDateWithHours(announce.getEndDate()));*/
		} catch (NumberFormatException e) {
			return ERROR;
		} finally {
			em.close();
		}

		return SUCCESS;
	}

	private void addRightToRequest(HttpServletRequest request) {
		SocialEntity socialEntity = UserUtils.getAuthenticatedUser(request);
		Right rightAddAnnounce = Right.ADD_ANNOUNCE;
		request.setAttribute("rightAddAnnounce", rightAddAnnounce);
		request.setAttribute("socialEntity", socialEntity);
	}

	/**
	 * Store the number of non reed announces
	 * 
	 * @param request
	 * @param em
	 */
	public static final void refreshNumNewAnnonces(HttpServletRequest request,
			EntityManager em) {
		HttpSession session = request.getSession();
		SocialEntity user = UserUtils.getAuthenticatedUser(request, em);
		InteractionFacade inf = new InteractionFacade(em);
		List<Interaction> list = inf.getUnreadInteractionsForSocialEntity(user);
		int numNonReedAnnounces = Interaction.filter(list, Announcement.class)
				.size();
		session.setAttribute("numNonReedAnnounces", numNonReedAnnounces);
	}

	/**
	 * @author stephane gronowski Access to the jsp to create an
	 *         {@link Announcement}.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 */
	public String displayCreateAnnounce() throws Exception {
		EntityManager em = PersistenceProvider.createEntityManager();
		SocialEntity user = UserUtils.getAuthenticatedUser(request, em);
		em.close();
		SocialGroupFacade fascade = new SocialGroupFacade(em);
		if (!fascade.isAuthorized(user, Right.ADD_ANNOUNCE)) {
			return ERROR;
		}

		return SUCCESS;
	}

	/**
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 */
	public String deleteMulti()
			throws Exception {
		EntityManager em = PersistenceProvider.createEntityManager();
		addRightToRequest(request);
		SocialEntity authenticatedUser = UserUtils.getAuthenticatedUser(
				request, em);

		try {

			AnnouncementFacade announcementFacade = new AnnouncementFacade(em);
			InteractionFacade interactionFacade = new InteractionFacade(em);

			addRightToRequest(request);

			for (int i = 0; i < selectedAnnounces.length; i++) {
				em.getTransaction().begin();
				Announcement announce = announcementFacade
						.getAnnouncement(Integer.valueOf(selectedAnnounces[i]));

				addRightToRequest(request);

				if (announce != null) {
					interactionFacade.deleteInteraction(authenticatedUser,
							announce);
				}
				em.getTransaction().commit();
			}

		} finally {
			em.close();
		}

		return SUCCESS;
	}

	public int getIdAnnounce() {
		return idAnnounce;
	}

	public void setIdAnnounce(int idAnnounce) {
		this.idAnnounce = idAnnounce;
	}

	public String getAnnounceTitle() {
		return announceTitle;
	}

	public void setAnnounceTitle(String announceTitle) {
		this.announceTitle = announceTitle;
	}

	public String getAnnounceContent() {
		return announceContent;
	}

	public void setAnnounceContent(String announceContent) {
		this.announceContent = announceContent;
	}

	public Date getAnnounceExpiryDate() {
		return announceExpiryDate;
	}

	public void setAnnounceExpiryDate(Date announceExpiryDate) {
		this.announceExpiryDate = announceExpiryDate;
	}

	public String getTextSearchAnnounce() {
		return textSearchAnnounce;
	}

	public void setTextSearchAnnounce(String textSearchAnnounce) {
		this.textSearchAnnounce = textSearchAnnounce;
	}

	public String[] getSelectedAnnounces() {
		return selectedAnnounces;
	}

	public void setSelectedAnnounces(String[] selectedAnnounces) {
		this.selectedAnnounces = selectedAnnounces;
	}

	public String[] getGroupsListRight() {
		return groupsListRight;
	}

	public void setGroupsListRight(String[] groupsListRight) {
		this.groupsListRight = groupsListRight;
	}

	public String[] getSelectedInterests() {
		return selectedInterests;
	}

	public void setSelectedInterests(String[] selectedInterests) {
		this.selectedInterests = selectedInterests;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	
}
