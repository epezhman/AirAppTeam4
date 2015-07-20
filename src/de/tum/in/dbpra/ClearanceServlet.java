package de.tum.in.dbpra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import de.tum.in.dbpra.model.bean.ResponseBean;
import de.tum.in.dbpra.model.dao.SampleDAO;
import de.tum.in.dbpra.model.dao.SampleDAO.SampleException;

@WebServlet("/ClearanceServlet")
public class ClearanceServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/clearance.jsp");
		dispatcher.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// set response type
			response.setContentType("application/json");

		//String ticket_num = request.getParameter("ticket_num");
			//String lastName = request.getParameter("last_name");

			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(
					response);
			SampleDAO dao = new SampleDAO();
			request.setAttribute("samples", dao.getSamples());
			request.getRequestDispatcher("/Partials/boarding-passes.jsp")
					.forward(request, customResponse);

			ResponseBean responseBean = new ResponseBean();
			responseBean.setSuccess(true);
			responseBean.setResponse(customResponse.getOutput());

			Gson gson = new Gson();
			// convert java object to JSON format,
			// and returned as JSON formatted string
			String json = gson.toJson(responseBean);

			PrintWriter out = response.getWriter();
			out.write(json);
			System.out.println(json);

		} catch (IOException | SQLException | SampleException e) {
			e.printStackTrace();
		}

	}

}
