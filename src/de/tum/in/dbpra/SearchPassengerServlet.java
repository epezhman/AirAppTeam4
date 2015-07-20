package de.tum.in.dbpra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import de.tum.in.dbpra.model.bean.PassengerBean;
import de.tum.in.dbpra.model.dao.SearchPassengerDAO;

@SuppressWarnings("serial")

/**
 * @brief Controller to search passenger who has done reservation
 * @author ali
 */
@WebServlet(value = "/searchPassengerServlet")
public class SearchPassengerServlet extends HttpServlet {



	public SearchPassengerServlet() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/json");

		String ticketNumber = request.getParameter("ticketNumber");
		System.out.println(ticketNumber);
		String json=null;
		PassengerBean passenger=null;
		
		if (ticketNumber != null){
			SearchPassengerDAO searchPassengerDAO = new SearchPassengerDAO();
			try {
				 passenger = searchPassengerDAO.getPassengerDetails(ticketNumber);
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		Gson gson = new Gson();
		List<PassengerBean> passengerList = new ArrayList<>();
		passengerList.add(passenger);
		json = gson.toJson(passengerList);
		System.out.println(json);
		PrintWriter out = response.getWriter();
		out.print(json);
		
	}	
	

}
