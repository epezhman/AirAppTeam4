package de.tum.in.dbpra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.dao.AirportDAO;
import de.tum.in.dbpra.model.dao.FlightSegmentDAO;
import de.tum.in.dbpra.model.dao.PassengerDAO;


@WebServlet(value="/passenger", loadOnStartup=1)
public class PassengerServlet extends HttpServlet {


	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/plain");
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		String nationality = request.getParameter("nationality");
		String passengerType = request.getParameter("passengerType");
		String phoneNumber = request.getParameter("phoneNumber");
		String country = request.getParameter("country");
		
		PassengerDAO passengerDAO = new PassengerDAO();
		boolean returnStatus= false;
		try {
			returnStatus = passengerDAO.createPassenger(firstName, lastName, address, gender,
					nationality, passengerType, phoneNumber, country); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.print(returnStatus);
		
	}
}
