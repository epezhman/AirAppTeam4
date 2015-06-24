package de.tum.in.dbpra;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.tum.in.dbpra.model.dao.SampleDAO;

import java.io.IOException;

@SuppressWarnings("serial")
public class SampleServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			SampleDAO dao = new SampleDAO();
			request.setAttribute("samples", dao.getSamples());

		} catch (Throwable e) {
			request.setAttribute("error", e.getMessage());
		}
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/WEB-INF/sample.jsp");
		dispatcher.forward(request, response);
	}

}