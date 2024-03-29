package fr.univartois.ili.fsnet.trayDesktop.views;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Font;
import java.util.ResourceBundle;

import javax.swing.JLabel;
import javax.swing.JPanel;

import fr.univartois.ili.fsnet.trayDesktop.TrayLauncher;

public class NotificationPanel {

    private JPanel panel;
    private JLabel label;
    private BorderLayout border;
    private final ResourceBundle trayi18n = TrayLauncher.getBundle();
    private static final int FONT_SIZE = 16;
    
    public NotificationPanel(int nb, String message) {
        this.panel = new JPanel();
        init(nb, message);
    }

    public JPanel getPanel() {
        return panel;
    }

    public final void init(int nb, String message) {
    	Font font = new Font("Arial", Font.PLAIN, FONT_SIZE);
        this.label = new JLabel(" "+trayi18n.getString("YOU")+" "+ nb + " " + message);
        this.label.setFont(font);
        border = new BorderLayout();
        panel.setLayout(border);
        panel.setMinimumSize(new Dimension(0,30));
        this.panel.add(label, BorderLayout.WEST);
    }

    public JLabel getLabel() {
        return label;
    }
}
