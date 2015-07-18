package de.tum.in.dbpra;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.tum.in.dbpra.model.bean.AirlineBean;

import de.tum.in.dbpra.model.bean.AirplaneBean;
import de.tum.in.dbpra.model.bean.AirportBean;
import de.tum.in.dbpra.model.bean.FlightSegmentBean;
import de.tum.in.dbpra.model.dao.AirlineDAO;

import de.tum.in.dbpra.model.dao.AirplaneDAO;
import de.tum.in.dbpra.model.dao.AirportDAO;
import de.tum.in.dbpra.model.dao.FlightSegmentDAO;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@SuppressWarnings("serial")
public class FlightSegmentservlet extends HttpServlet {


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FlightSegmentservlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		try {
			response.setContentType("application/json");
		    StringBuilder sb = new StringBuilder();
		    BufferedReader br = request.getReader();
		    String str;
		    while( (str = br.readLine()) != null ){
		        sb.append(str);
		    }    
		      JsonParser parser = new JsonParser();
		    JsonObject rootObj = parser.parse(sb.toString()).getAsJsonObject();
		    
			AirlineBean airline = new AirlineBean();
			AirlineDAO airlinedao = new AirlineDAO();
			
			AirportBean airport = new AirportBean();
			AirportDAO airportdao = new AirportDAO();
			
			AirplaneBean airplane = new AirplaneBean();
			AirplaneDAO airplanedao = new AirplaneDAO();
			
			FlightSegmentBean flight_segment = new FlightSegmentBean();
			FlightSegmentDAO flightsegmentdao = new FlightSegmentDAO();
			
			flight_segment.setFlightSegmentId(rootObj.get("flight_segment_id").getAsInt());
			flight_segment.setDurationMinutes(rootObj.get("duration_minutes").getAsInt());
			flight_segment.setNumberOfMiles(rootObj.get("number_of_miles").getAsInt());
			
			try{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
				Date date = sdf.parse(rootObj.get("departure_time").getAsString());
				Timestamp departure_time = new java.sql.Timestamp(date.getTime());
				flight_segment.setDepartureTime(departure_time);
				
				date = sdf.parse(rootObj.get("arrival_time").getAsString());
				Timestamp arrival_time = new java.sql.Timestamp(date.getTime());
				flight_segment.setArrivalTime(arrival_time);
				
			}catch(Exception e){//this generic but you can control another types of exception
				System.out.println("error");
			 e.printStackTrace();
			}
			
			
			
			/*String arrivalstr = rootObj.get("arrival_time").getAsString();
			Date parsedate1 = (Date) sdf.parse(arrivalstr);
			Timestamp arrival_time = new java.sql.Timestamp(parsedate1.getTime());
			flight_segment.setArrivalTime(arrival_time);*/
			
			airline.setAirlineId(rootObj.get("airline_id").getAsInt());
			airlinedao.getAirlineByID(airline);
//			 inserting airline object into airplane
			flight_segment.setAirline(airline);
			
			airport.setAirportId(rootObj.get("airport_departure_id").getAsString());
			airportdao.getAirportByID(airport);
//			 inserting airline object into airplane
			flight_segment.setAirportDeparture(airport);
			airport = new AirportBean();
			
			airport.setAirportId(rootObj.get("airport_destination_id").getAsString());
			airportdao.getAirportByID(airport);
//			 inserting airline object into airplane
			flight_segment.setAirportDestination(airport);
			
			if(rootObj.get("airplane_type").getAsString()!=null){
			airplane.setAirplaneType(rootObj.get("airplane_type").getAsString());
			airplanedao.getAirplaneByType(airplane);
//			 inserting airline object into airplane
			flight_segment.setAirplane(airplane);
			}
			
			
			flightsegmentdao.addflight_segment(flight_segment);
			//preparing json using Gson
			Gson gson = new Gson();
			String json = gson.toJson(flight_segment);
			PrintWriter out = response.getWriter();
			out.write(json);
			System.out.println(json);
			}
				catch (IOException e) {
				e.printStackTrace();
				}
		catch (Throwable e) {
			e.printStackTrace();
			//request.setAttribute("error", e.getMessage());
		}
	      
		   // RequestDispatcher dispatcher = request.getRequestDispatcher("/airplane.jsp");
			//dispatcher.forward(request, response);

	}

}
