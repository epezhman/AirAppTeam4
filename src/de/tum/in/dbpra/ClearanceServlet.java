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

import de.tum.in.dbpra.model.bean.AirportContainerBean;
import de.tum.in.dbpra.model.bean.FlightControllerContainerBean;
import de.tum.in.dbpra.model.bean.FlightSegmentContainerBean;
import de.tum.in.dbpra.model.bean.ResponseBean;
import de.tum.in.dbpra.model.dao.AirlineDAO.AirlineNotFoundException;
import de.tum.in.dbpra.model.dao.AirportDAO;
import de.tum.in.dbpra.model.dao.AirportDAO.AirportNotFoundException;
import de.tum.in.dbpra.model.dao.ClearanceDAO;
import de.tum.in.dbpra.model.dao.FlightControllerDAO;
import de.tum.in.dbpra.model.dao.FlightControllerDAO.FlightControllerException;
import de.tum.in.dbpra.model.dao.FlightSegmentDAO;
import de.tum.in.dbpra.model.dao.SampleDAO;
import de.tum.in.dbpra.model.dao.SampleDAO.SampleException;

@WebServlet("/ClearanceServlet")
public class ClearanceServlet extends HttpServlet {


	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {		
			
		try {
			AirportDAO dao = new AirportDAO();		
			request.setAttribute("airports", dao.getAirports());
			
			FlightSegmentDAO dao_flight = new FlightSegmentDAO();	
			FlightSegmentContainerBean dd = dao_flight.getAllFlights();

			request.setAttribute("all_flights", dao_flight.getAllFlights());
			
			FlightControllerDAO dao_controller = new FlightControllerDAO();		
			request.setAttribute("controllers", dao_controller.getFlightControllers());
			
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/clearance.jsp");
			dispatcher.forward(request, response);
			
		} catch (SQLException | AirportNotFoundException
				| AirlineNotFoundException |FlightControllerException e) {
			e.printStackTrace();
		}
		
		
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// set response type
			response.setContentType("application/json");

			String airport = request.getParameter("airport");
			String airplane_type = request.getParameter("airplane_type");
			String clearance_time = request.getParameter("clearance_time");

			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(
					response);
			ClearanceDAO dao = new ClearanceDAO();
			//request.setAttribute("samples", dao.getSamples());
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

		} catch (IOException  e) {
			e.printStackTrace();
		}

	}

}
