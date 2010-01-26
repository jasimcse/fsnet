package fr.univartois.ili.fsnet.facade.iliforumtags;

import java.util.List;

import fr.univartois.ili.fsnet.entities.Message;
import fr.univartois.ili.fsnet.entities.Topic;

public class TopicDTO {

    private Topic topic;
    private int nbMessage;
    private Message lastMessage;

    public Message getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(final Message lastMessage) {
        this.lastMessage = lastMessage;
    }

    public TopicDTO(final Topic top) {
        this.topic = top;
        update();

    }

    private void update() {
        List<Message> lMessage;
        lMessage = topic.getLesMessages();
        this.nbMessage = lMessage.size();
        if (!lMessage.isEmpty()) {
            this.lastMessage = lMessage.get(lMessage.size() - 1);
        }

    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(final Topic topic) {
        this.topic = topic;
    }

    public int getNbMessage() {
        return nbMessage;
    }

    public void setNbMessage(final int nbMessage) {
        this.nbMessage = nbMessage;
    }
}