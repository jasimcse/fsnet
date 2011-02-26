package fr.univartois.ili.fsnet.mobile.services;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;

import fr.univartois.ili.fsnet.entities.PrivateMessage;
import fr.univartois.ili.fsnet.entities.SocialEntity;
import fr.univartois.ili.fsnet.facade.SocialEntityFacade;
import fr.univartois.ili.fsnet.mobile.services.model.RestPrivateMessage;
@Path("/messages")
public class Messages {

	private EntityManagerFactory factory;
	private EntityManager em;

	public Messages() {
		factory = Persistence.createEntityManagerFactory("fsnetjpa");
		em = factory.createEntityManager();
	}

	/**
	 * Return the unread personal messages
	 * 
	 * @param login
	 * @param password
	 * @return
	 */
	@GET
	@Path("/unread/{delay}")
	@Produces(MediaType.APPLICATION_JSON)
	public GenericEntity<List<RestPrivateMessage>> getNewMessages( //
			@QueryParam("login") String login, // 
			@QueryParam("pwd") String password, //
			@PathParam("delay") Integer delay) {
		Logger.getAnonymousLogger().info(login);
		List<RestPrivateMessage> messages = new ArrayList<RestPrivateMessage>();
		SocialEntityFacade sef = new SocialEntityFacade(em);
		if (sef.isMember(login, password)) {
			SocialEntity se = sef.findByEmail(login);
			TypedQuery<PrivateMessage> messageQuery = em
					.createQuery(
							"SELECT message FROM SocialEntity soc, IN(soc.receivedPrivateMessages) message where message.reed='false' and soc=:member",
							PrivateMessage.class);
			messageQuery.setParameter("member", se);
			for (PrivateMessage message : messageQuery.getResultList()) {
				RestPrivateMessage restPrivateMessage = new RestPrivateMessage();
				
				String from = message.getFrom().getName() + " " + message.getFrom().getFirstName();
				restPrivateMessage.setFrom(from);
				restPrivateMessage.setMessageId(restPrivateMessage.getMessageId());
				restPrivateMessage.setSubject(message.getSubject());
				
				messages.add(restPrivateMessage);
			}
		}
		return new GenericEntity<List<RestPrivateMessage>>(messages){};
	}

}