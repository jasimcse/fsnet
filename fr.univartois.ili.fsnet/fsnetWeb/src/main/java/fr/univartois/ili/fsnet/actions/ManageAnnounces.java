package fr.univartois.ili.fsnet.actions;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
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

import fr.univartois.ili.fsnet.actions.utils.DateUtils;
import fr.univartois.ili.fsnet.auth.Authenticate;
import fr.univartois.ili.fsnet.entities.Annonce;
import fr.univartois.ili.fsnet.entities.EntiteSociale;

/**
 * 
 * @author Mehdi Benzaghar <mehdi.benzaghar at gmail.com>
 */
public class ManageAnnounces extends MappingDispatchAction implements
		CrudAction {

	private static final EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("fsnetjpa");

	/**
	 * @return to announces view after persisting new announce
	 */
	@Override
	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		EntityManager entityManager = factory.createEntityManager();
		request.setCharacterEncoding("UTF-8");
		EntiteSociale entiteSociale = (EntiteSociale) request.getSession()
				.getAttribute(Authenticate.AUTHENTICATED_USER);

		DynaActionForm formAnnounce = (DynaActionForm) form;
		String title = (String) formAnnounce.get("announceTitle");
		String content = (String) formAnnounce.get("announceContent");
		String stringExpiryDate = (String) formAnnounce
				.get("announceExpiryDate");

		try {
			Date expiryDate = DateUtils.format(stringExpiryDate);
			if (0 > DateUtils.compareToToday(expiryDate)) {
				Annonce announce = new Annonce(title, new Date(), content,
						expiryDate, "Y", entiteSociale);
				entityManager.getTransaction().begin();
				entityManager.persist(announce);
				entityManager.getTransaction().commit();
			} else {
				ActionMessages errors = new ActionErrors();
				errors.add("message", new ActionMessage(
						"errors.dateLessThanCurrentDate"));
				saveErrors(request, errors);
				return mapping.findForward("failer");
			}
		} catch (ParseException e) {
			servlet.log(getClass().getName()
					+ " methode:create exception whene formatying date ");
			e.printStackTrace();
			return mapping.findForward("failer");
		}
		entityManager.close();

		return mapping.findForward("success");

	}

	/**
	 * @return to views announce after updating it
	 */
	@Override
	public ActionForward modify(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		EntityManager entityManager = factory.createEntityManager();
		Date today = new Date();
		DynaActionForm formAnnounce = (DynaActionForm) form;
		String title = (String) formAnnounce.get("announceTitle");
		String content = (String) formAnnounce.get("announceContent");
		String stringExpiryDate = (String) formAnnounce
				.get("announceExpiryDate");
		Integer idAnnounce = (Integer) formAnnounce.get("idAnnounce");

		EntiteSociale entiteSociale = (EntiteSociale) request.getSession()
				.getAttribute(Authenticate.AUTHENTICATED_USER);
		try {
			Date expiryDate = DateUtils.format(stringExpiryDate);
			if (0 > DateUtils.compareToToday(expiryDate)) {
				Annonce announce = new Annonce(title, today, content,
						expiryDate, "Y", entiteSociale);
				announce.setId(idAnnounce);
				entityManager.getTransaction().begin();
				entityManager.merge(announce);
				entityManager.getTransaction().commit();
			} else {
				ActionMessages errors = new ActionMessages();
				errors.add("message", new ActionMessage(
						"errors.dateLessThanCurrentDate"));
				saveErrors(request, errors);
			}
		} catch (ParseException e) {
			servlet
					.log("class:ManageAnnounces methode:create exception whene formatying date ");
			e.printStackTrace();
		}
		entityManager.close();
		return mapping.findForward("success");
	}

	/**
 * 
 */
	@Override
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		EntityManager entityManager = factory.createEntityManager();

		Integer idAnnounce = Integer
				.valueOf(request.getParameter("idAnnounce"));

		Annonce announce = entityManager.find(Annonce.class, idAnnounce);
		servlet.log("remove announce");
		entityManager.getTransaction().begin();
		entityManager.remove(announce);

		entityManager.flush();
		entityManager.getTransaction().commit();
		entityManager.close();
		ActionMessages message = new ActionMessages();
		message.add("message", new ActionMessage("success.deleteAnnounce"));
		saveMessages(request, message);
		return mapping.findForward("success");

	}

	/**
	 * @return list of announce
	 */
	@Override
	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		DynaActionForm seaarchForm = (DynaActionForm) form;
		String textSearchAnnounce = (String) seaarchForm
				.get("textSearchAnnounce");
		EntityManager entityManager = factory.createEntityManager();
		List<Annonce> listAnnounces;
		// TODO warning
		servlet.log("search");
		if (textSearchAnnounce != null) {
			listAnnounces = entityManager
					.createQuery(
							"SELECT a FROM Annonce a WHERE a.nom LIKE :textSearchAnnounce OR a.contenu LIKE :textSearchAnnounce ")
					.setParameter("textSearchAnnounce",
							"%" + textSearchAnnounce + "%").getResultList();
		} else {
			listAnnounces = entityManager.createQuery(
					"SELECT a FROM Annonce a ").getResultList();
		}

		request.setAttribute("listAnnounces", listAnnounces);
		return mapping.findForward("success");
	}

	/**
	 * @return announce in request
	 */
	@Override
	public ActionForward display(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		EntityManager entityManager = factory.createEntityManager();

		Integer idAnnounce = Integer
				.valueOf(request.getParameter("idAnnounce"));

		Annonce announce = entityManager.find(Annonce.class, idAnnounce);
		EntiteSociale entiteSocialeOwner = (EntiteSociale) entityManager
				.createQuery(
						"SELECT es FROM EntiteSociale es,IN(es.lesinteractions) e WHERE e = :announce")
				.setParameter("announce", announce).getSingleResult();

		request.setAttribute("announce", announce);
		request.setAttribute("entiteSociale", entiteSocialeOwner);
		EntiteSociale entiteSociale = (EntiteSociale) request.getSession()
				.getAttribute(Authenticate.AUTHENTICATED_USER);
		if (entiteSociale.getId() == entiteSocialeOwner.getId())
			request.setAttribute("owner", true);

		servlet.log(entiteSociale.getId() + "------------"
				+ entiteSocialeOwner.getId());
		return mapping.findForward("success");
	}

}
