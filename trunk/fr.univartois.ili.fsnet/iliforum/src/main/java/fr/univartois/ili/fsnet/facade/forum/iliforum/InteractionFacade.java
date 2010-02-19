package fr.univartois.ili.fsnet.facade.forum.iliforum;

import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;

import fr.univartois.ili.fsnet.entities.Interaction;
import fr.univartois.ili.fsnet.entities.Interest;
import fr.univartois.ili.fsnet.entities.SocialEntity;

/**
 *
 * @author Matthieu Proucelle <matthieu.proucelle at gmail.com>
 */
public class InteractionFacade {

    private final EntityManager em;

    public InteractionFacade(EntityManager em) {
        this.em = em;

    }

    /**
     * Add an interest to given interaction
     * @param interaction the interaction to add the interest in
     * @param interest the interest to add to the interaction
     */
    public final void addInterest(Interaction interaction, Interest interest) {
        if (interaction == null || interest == null) {
            throw new IllegalArgumentException();
        }
        final Set<Interest> interests = interaction.getInterests();
        if (!interests.contains(interest)) {
            interests.add(interest);
        }
    }

    /**
     * Add a list of interests to given interaction
     * @param interaction the interaction to add the interest in
     * @param interests the list of interests to add to the interaction
     */
    public final void addInterests(Interaction interaction, List<Interest> interests) {
        if (interaction == null || interests == null) {
            throw new IllegalArgumentException();
        }
        final Set<Interest> interactionInterests = interaction.getInterests();
        interactionInterests.addAll(interests);
    }

    /**
     * Remove an interest from a given interaction
     * @param interaction the interaction to remove the interest from
     * @param interests the interest to remove from the interaction
     */
    public final void removeInterest(Interaction interaction, Interest interest) {
        if (interaction == null || interest == null) {
            throw new IllegalArgumentException();
        }
        interaction.getInterests().remove(interest);
    }
    
    
    /**
     * delete an interaction, control if the deleter is the owner
     * @param entity the entity who call the delete
     * @param interaction the interaction who is deleted
     * @return a boolean who display if entity is the owner or not
     */
    public final boolean deleteInteraction(SocialEntity entity,Interaction interaction){
    	if(interaction == null || entity == null) {
            throw new IllegalArgumentException();
        }
    	if(interaction.getCreator().equals(entity)){
    		em.remove(interaction);
    		return true;
    	}
    	
    	return false;
    }
}
