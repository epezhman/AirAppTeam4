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

import de.tum.in.dbpra.model.bean.BoardingPassContainerBean;
import de.tum.in.dbpra.model.bean.ResponseBean;
import de.tum.in.dbpra.model.dao.CheckInDAO;
import de.tum.in.dbpra.model.dao.CheckInDAO.CheckInException;

@WebServlet("/CheckInServlet")
public class CheckInServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/checkIn.jsp");
		dispatcher.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			response.setContentType("application/json");

			String ticket_num = request.getParameter("ticket_num");
			String lastName = request.getParameter("last_name");

			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(
					response);
			
			CheckInDAO dao = new CheckInDAO();
						
			request.setAttribute("passes", dao.getBoardingPass(ticket_num,lastName ));
			request.getRequestDispatcher("/Partials/boarding-passes.jsp")
					.forward(request, customResponse);

			ResponseBean responseBean = new ResponseBean();
			responseBean.setSuccess(true);
			responseBean.setResponse(customResponse.getOutput());

			Gson gson = new Gson();

			String json = gson.toJson(responseBean);

			PrintWriter out = response.getWriter();
			out.write(json);
			System.out.println(json);

		} catch (IOException | SQLException | CheckInException e) {
			e.printStackTrace();
		}

	}

}
