package de.tum.in.dbpra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.dao.AirportDAO;
import de.tum.in.dbpra.model.dao.FlightSegmentDAO;

@WebServlet(value = "/searchFlight", loadOnStartup = 1)
public class SearchFlightServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		getServletContext().setAttribute("cities", retrieveCities());
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/json");

		String to = request.getParameter("to");
		String from = request.getParameter("from");
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		String ticketClass = request.getParameter("ticketClass");
		String isOneway = request.getParameter("isOneway");
		String noofPass = request.getParameter("noofPass");

		FlightSegmentDAO flightSegmentDAO = new FlightSegmentDAO();
		List<FlightSegmentBean> searchFlightList = null;
		String json = null;
		try {
			searchFlightList = flightSegmentDAO.searchFlight(to, from, toDate,
					fromDate, ticketClass, noofPass, isOneway);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		Gson gson = new Gson();
		json = gson.toJson(searchFlightList);
		System.out.println(json);
		PrintWriter out = response.getWriter();
		out.print(json);

	}

	public String retrieveCities() {
		List<String> cities = null;
		String json = null;
		AirportDAO dao = new AirportDAO();
		try {
			cities = dao.getCitiesForFlightSearch();
			Gson gson = new Gson();
			json = gson.toJson(cities);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return json;
	}
}
