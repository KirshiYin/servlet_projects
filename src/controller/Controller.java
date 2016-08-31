package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import beans.Recipies;
import database.Account;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		super();
	}

	// check
	// https://tomcat.apache.org/tomcat-7.0-doc/jndi-datasource-examples-howto.html
	// for resource for tomcat context.xml and the app web.xml
	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			InitialContext initContext = new InitialContext();
			Context env = (Context) initContext.lookup("java:comp/env");
			ds = (DataSource) env.lookup("jdbc/recipies");

		} catch (NamingException e) {
			throw new ServletException();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		// if there is no action, forward to index.jsp
		if (action == null) {
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		} else if (action.equals("dologin")) {
			request.setAttribute("username", "");
			request.setAttribute("password", "");
			request.setAttribute("message", "message");
			request.getRequestDispatcher("/login.jsp").forward(request, response);

		} else if (action.equals("goRecipies")) {
			request.getRequestDispatcher("/recipies.jsp").forward(request, response);

		} else if (action.equals("image")) {
			request.getRequestDispatcher("/image.jsp").forward(request, response);
		} else if (action.equals("deleteRecipe")) {
			request.getRequestDispatcher("/deleteRecipe.jsp").forward(request, response);

		} else if (action.equals("editRecipe")) {
			request.getRequestDispatcher("/editRecipe.jsp").forward(request, response);

		} else if (action.equals("addRecipe")) {

			request.getRequestDispatcher("/added.jsp").forward(request, response);
		} else if (action.equals("goFavourites")) {
			request.getRequestDispatcher("/favourites.jsp").forward(request, response);
		} else if (action.equals("insertRecipe")) {
			request.getRequestDispatcher("/insert.jsp").forward(request, response);
		} else {
			out.println("unrecognised action");
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// use connection
		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");

		if (action == null) {
			out.println("unrecognised action");
			return;
		}

		Connection conn = null;

		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			out.println("Unable to connect to database.");
			System.out.println("Unable to connect to database.");
			return;
			// throw new ServletException();
		}

		Account account = new Account(conn);

		if (action.equals("dologin")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			// User user = new User(username, password);

			request.setAttribute("username", username);
			request.setAttribute("password", "");
			// if the count is more than 0 in Account.java, the user can login
			try {
				if (account.login(username, password)) {
					request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
				} else {
					request.setAttribute("message", "username or password not recognised");
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}
			} catch (SQLException e) {
				request.setAttribute("username", "Database error: please try again later.");
			}
		} else if (request.getParameter("delete") != null) {
			String id = request.getParameter("imgId");
			try {
				Recipies.removeFavoured(conn, id);
				System.out.println("removed from favs: " + id);
				request.getRequestDispatcher("/favourites.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("cannot remove from favs " + e.getMessage());
			}
		} else if (request.getParameter("back") != null) {
			request.getRequestDispatcher("/recipies.jsp").forward(request, response);
		} else if (action.equals("edit")) {
			String description = request.getParameter("descriptionArea");
			String id = request.getParameter("imgId");
			try {

				Recipies.updateDescription(conn, description, id);
				System.out.println("updated text: " + "\n" + " id " + id + " \n" + description);
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("cannot update " + e.getMessage());
			}
			request.getRequestDispatcher("/saved.jsp").forward(request, response);

		} else if (request.getParameter("addToFavs") != null) {
			String id = request.getParameter("imgId");
			try {
				Recipies.addFavoured(conn, id);
				System.out.println("added to favourites " + id);
				request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if (request.getParameter("insert") != null) {
			String url = request.getParameter("urlArea");
			String urlEnd = url.substring(url.lastIndexOf("/")+1, url.length());
			try {
				Recipies.insertRecipe(conn,urlEnd, url);
				System.out.println("inserted recipe " + urlEnd );
				request.getRequestDispatcher("/inserted.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("cannot insert recipe " + e.getMessage());
			}
		} else {
			out.println("unrecognised action");
		}

		try {
			conn.close();
		} catch (SQLException e) {
			throw new ServletException();
		}

	}

}
