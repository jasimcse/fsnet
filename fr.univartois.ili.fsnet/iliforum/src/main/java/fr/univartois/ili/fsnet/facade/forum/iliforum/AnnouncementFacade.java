package fr.univartois.ili.fsnet.facade.forum.iliforum;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;

import fr.univartois.ili.fsnet.entities.Announcement;
import fr.univartois.ili.fsnet.entities.SocialEntity;

/**
 * @author mickael watrelot - micgamers@gmail.com
 */
public class AnnouncementFacade {

    
    private final EntityManager em;

    /**
     * Contructor
     * @param em
     */
    public AnnouncementFacade(EntityManager em) {
        this.em = em;
    }

    /**
     * Create a New Announcement
     * @param member
     * @param annName
     * @param annDescription
     * @param endDate
     * @param isPrivate
     * @return the new Announcement
     */
    public Announcement createAnnouncement(SocialEntity member, String annName,
            String annDescription, Date endDate, Boolean isPrivate) {
        Announcement announce = new Announcement(member, annName,
                annDescription, endDate, isPrivate);

        em.persist(announce);

        return announce;
    }

    
    /**
     * Modify the Announcement
     * @param idAnnounce
     * @param annName
     * @param annDescription
     * @param endDate
     * @return the Announcement modify
     */
    public Announcement modifyAnnouncement(int idAnnounce, String annName,
            String annDescription, Date endDate) {
        Announcement announce = em.find(Announcement.class, idAnnounce);
        announce.setTitle(annName);
        announce.setContent(annDescription);
        announce.setEndDate(endDate);
        em.merge(announce);
        return announce;
    }

    /**
     * Delete the Announcement with the id of the Announcement AnnouncementId
     * 
     * @param idAnnounce
     */
    public void deleteAnnouncement(int idAnnounce) {
        Announcement announce = em.find(Announcement.class, idAnnounce);
        em.remove(announce);
        em.flush();
    }

    /**
     * Search the Announcement with the param textSearchAnnounce
     * @param textSearchAnnounce
     * @return a list of Announcement
     */
    public List<Announcement> searchAnnouncement(String textSearchAnnounce) {
        List<Announcement> listAnnounces;
        listAnnounces = em.createQuery(
                "SELECT a FROM Announcement a WHERE  TYPE(a) IN(Announcement) AND ( a.title LIKE :textSearchAnnounce OR a.content LIKE :textSearchAnnounce) ", Announcement.class).setParameter("textSearchAnnounce",
                "%" + textSearchAnnounce + "%").getResultList();
        return listAnnounces;

    }
}