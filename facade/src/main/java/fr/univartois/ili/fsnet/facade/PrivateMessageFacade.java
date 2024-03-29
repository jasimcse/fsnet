package fr.univartois.ili.fsnet.facade;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import fr.univartois.ili.fsnet.entities.PrivateMessage;
import fr.univartois.ili.fsnet.entities.SocialEntity;

public class PrivateMessageFacade {

	private final EntityManager em;

	public PrivateMessageFacade(EntityManager em) {
		this.em = em;
	}

	/**
	 * Send a private message
	 * 
	 * @param body
	 *            the body of the message
	 * @param from
	 *            the author of the message
	 * @param subject
	 *            the subject of the message
	 * @param to
	 *            the recipient of the message
	 * @return the persisted PrivateMessage
	 */
	public final PrivateMessage sendPrivateMessage(String body,
			SocialEntity from, String subject, SocialEntity to) {
		PrivateMessage pm = new PrivateMessage(body, from, subject, to);
		em.persist(pm);
		from.getSentPrivateMessages().add(pm);
		to.getReceivedPrivateMessages().add(pm);
		return pm;
	}

	/**
	 * Delete a PrivateMessage
	 * 
	 * @param entity
	 *            the related entity (author or recipient)
	 * @param message
	 *            the message to delete
	 */
	public final void deletePrivateMessage(SocialEntity entity,
			PrivateMessage message) {
		if (entity == null || message == null) {
			throw new IllegalArgumentException();
		}
		deletePrivateMessage(entity, message, null);

	}

	/**
	 * Delete a PrivateMessage 
	 * 
	 * @param entity
	 *            the related entity (author or recipient)
	 * @param message
	 *            the message to delete
	 * @param fromSource
	 * 			  the from page that called function
	 */
	public final void deletePrivateMessage(SocialEntity entity,
			PrivateMessage message, String fromSource) {
		if (entity == null || message == null) {
			throw new IllegalArgumentException();
		}
		if (message.getFrom().equals(entity) && (fromSource == null || fromSource.equals("out"))) {
			entity.getSentPrivateMessages().remove(message);
		}
		if (message.getTo().equals(entity) && (fromSource == null || fromSource.equals("in"))) {
			entity.getReceivedPrivateMessages().remove(message);
		}

	}
	
	/**
	 * Search a private message in the social entity received messages
	 * 
	 * @param entity
	 *            the recipient of messages
	 * @param pattern
	 *            the pattern to match
	 * @return the list of matching messages
	 */
	public final List<PrivateMessage> searchReceivedPrivateMessage(
			SocialEntity entity, String pattern) {
		if (entity == null || pattern == null) {
			throw new IllegalArgumentException();
		}
		TypedQuery<PrivateMessage> query = em
				.createQuery(
						"SELECT message FROM PrivateMessage message WHERE message.to = :entity "
								+ "AND (message.body LIKE :pattern OR message.subject LIKE :pattern)",
						PrivateMessage.class);
		query.setParameter("pattern", "%" + pattern + "%");
		query.setParameter("entity", entity);
		return query.getResultList();
	}

	/**
	 * Search a private message in the social entity sent messages
	 * 
	 * @param entity
	 *            the author of messages
	 * @param pattern
	 *            the pattern to match
	 * @return the list of matching messages
	 */
	public final List<PrivateMessage> searchSentPrivateMessage(
			SocialEntity entity, String pattern) {
		if (entity == null || pattern == null) {
			throw new IllegalArgumentException();
		}
		TypedQuery<PrivateMessage> query = em
				.createQuery(
						"SELECT message FROM PrivateMessage message WHERE message.from = :entity "
								+ "AND (message.body LIKE :pattern OR message.subject LIKE :pattern)",
						PrivateMessage.class);
		query.setParameter("pattern", "%" + pattern + "%");
		query.setParameter("entity", entity);
		return query.getResultList();
	}

	/**
	 * 
	 * @param id
	 * @return the message with the given id
	 */
	public final PrivateMessage getPrivateMessage(int id) {
		return em.find(PrivateMessage.class, id);
	}

	/**
	 * 
	 * @param from
	 *            the author of the message
	 * @param subject
	 *            the subject of the message
	 * @param to
	 *            the recipient of the message
	 */
	public final List<PrivateMessage> getConversation(SocialEntity from,
			String subject, SocialEntity to) {

		if (from == null || subject == null || to == null) {
			throw new IllegalArgumentException();
		}

		TypedQuery<PrivateMessage> query = em
				.createQuery(
						"SELECT DISTINCT message FROM PrivateMessage message WHERE  message.subject LIKE :pattern "
								+ " AND ((message.to = :to "
								+ "AND message.from = :from )"
								+ "OR (message.to = :from "
								+ "AND message.from = :to ))"
								+ "AND ((message MEMBER OF message.to.receivedPrivateMessages)"
								+ "OR (message MEMBER OF message.from.sentPrivateMessages))"
								+ "ORDER BY message.creationDate",
						PrivateMessage.class);

		query.setParameter("pattern", "%" + subject.replaceAll("RE: ", "")+"%");
		query.setParameter("to", to);
		query.setParameter("from", from);

		return query.getResultList();
	}

}
