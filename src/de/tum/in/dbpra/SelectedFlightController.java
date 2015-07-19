package de.tum.in.dbpra;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import de.tum.in.dbpra.model.bean.AirlineBean;
import de.tum.in.dbpra.model.bean.AirplaneBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.FlightSegmentBean;

@WebServlet("/selectedFlight")
public class SelectedFlightController extends HttpServlet {
	
	
	
	private static final long serialVersionUID = 1L;
	List<FlightSegmentBean> userSelectedflight = new ArrayList<FlightSegmentBean>();
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {


		HttpSession session= request.getSession();

		String departTime = request.getParameter("departure_time");
		String arrivalTime = request.getParameter("arrival_time");
		String airlineName = request.getParameter("airline_name");
		String airportDestinationName =   request.getParameter("airport_destination_name");
		String airportDepartName = request.getParameter("airport_departure_name");
		String airplaneType = request.getParameter("airplane_type");
		String flight_price= request.getParameter("airplane_type");
		String flight_number= request.getParameter("flight_number");

		


		AirlineBean airline = new AirlineBean();
		AirplaneBean airplane = new AirplaneBean();
		AirportBean	airportDeparture = new AirportBean();
		AirportBean	airportDestination = new AirportBean();
		FlightSegmentBean flightSegmentBean = new FlightSegmentBean();

		flightSegmentBean.setDeparture_time_ticket(departTime);
		flightSegmentBean.setArrival_time_ticket(arrivalTime);
		airportDeparture.setName(airportDepartName);
		flightSegmentBean.setAirportDeparture(airportDeparture);
		airportDestination.setName(airportDestinationName);
		flightSegmentBean.setAirportDestination(airportDestination);
		airline.setAirlineName(airlineName);
		flightSegmentBean.setAirline(airline);
		airplane.setAirplaneType(airplaneType);
		flightSegmentBean.setAirplane(airplane);
		flightSegmentBean.setPrice(flight_price);
		flightSegmentBean.setFlightNumber(flight_number);

		userSelectedflight.add(flightSegmentBean);
		//setting user selected flight in session
		session.setAttribute("userSelectedflight", userSelectedflight);

	}


}
