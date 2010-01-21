package fr.univartois.ili.fsnet.auth;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * This Servlet is called when a authenticated user wants to log out
 * 
 * @author Mathieu Boniface  < mat.boniface {At} gmail.com >
 */
public class Logout extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * Invalidate the current session of the authenticated user and redirect him 
	 * to the login page
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		if (session != null) {
			session.invalidate();
		}
		RequestDispatcher dispatcher = req
				.getRequestDispatcher(Authenticate.WELCOME_NON_AUTHENTICATED_PAGE);
		dispatcher.forward(req, resp);
	}

	/**
	 * Delegated to doGet
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}

}